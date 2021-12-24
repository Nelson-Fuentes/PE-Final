import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapController extends ChangeNotifier {
  MapController() {
    _init();
  }

  final user_ = FirebaseAuth.instance.currentUser!;

  Map<MarkerId, Marker> _markers = {};
  Set<Marker> get markers => _markers.values.toSet();

  late bool _gpsEnable = false;
  bool get gpsEnable => _gpsEnable;

  StreamSubscription? _gpsSubscription, _positionSuscription;

  Position? _initialPosition;
  CameraPosition get initialCameraPosition => CameraPosition(
      target: LatLng(
        _initialPosition!.latitude,
        _initialPosition!.longitude,
      ),
      zoom: 15);

  void addPoint(LatLng position, String title, String description) {
    final markerId = MarkerId(_markers.length.toString());
    final marker = Marker(
      markerId: markerId,
      position: position,
      infoWindow: InfoWindow(title: title, snippet: description),
    );
    _markers[markerId] = marker;
    notifyListeners();
  }

  Future<void> _init() async {
    _gpsEnable = await Geolocator.isLocationServiceEnabled();
    _gpsSubscription =
        Geolocator.getServiceStatusStream().listen((status) async {
      _gpsEnable = status == ServiceStatus.enabled;
      if (_gpsEnable) {
        _initLocationUpdates();
      }
    });
    _initLocationUpdates();
  }

  Future<void> _initLocationUpdates() async {
    bool initialized = false;
    await _positionSuscription?.cancel();
    _positionSuscription = Geolocator.getPositionStream().listen(
      (position) async {
        var dict = {
          "latitude": position.latitude,
          "longitude": position.longitude
        };
        await FirebaseFirestore.instance
            .collection("Users")
            .doc(user_.email)
            .set(dict)
            .whenComplete(() {
          print("actualizado");
        });
        print("😁 $position");
        if (!initialized) {
          _setInitialPosition(position);
          initialized = true;
          notifyListeners();
        }
      },
      onError: (e) {
        //print("👀 onError ${e.runtimeType}");
        if (e is LocationServiceDisabledException) {
          _gpsEnable = false;
          notifyListeners();
        }
      },
    );
  }

  void _setInitialPosition(Position position) {
    if (_gpsEnable && _initialPosition == null) {
      _initialPosition = position;
    }
  }

  @override
  void dispose() {
    _positionSuscription?.cancel();
    _gpsSubscription?.cancel();
    super.dispose();
  }
}
