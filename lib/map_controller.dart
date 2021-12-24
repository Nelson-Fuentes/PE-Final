import 'dart:async';
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapController extends ChangeNotifier {
  late bool isSending;
  late String email;

  MapController(bool isSending, String email) {
    this.isSending = isSending;
    this.email = email;
    _init();
  }

  final user_ = FirebaseAuth.instance.currentUser!;

  Map<MarkerId, Marker> _markers = {};
  Set<Marker> get markers => _markers.values.toSet();

  late bool _gpsEnable = false;
  bool get gpsEnable => _gpsEnable;

  StreamSubscription? _gpsSubscription, _positionSuscription;
  var ubicationSuscription;

  Position? _initialPosition;
  CameraPosition get initialCameraPosition => CameraPosition(
      target: LatLng(
        _initialPosition!.latitude,
        _initialPosition!.longitude,
      ),
      zoom: 15);

  void addPoint(List list) {
    //LatLng position, String title, String description
    _markers = {};
    final markerId = MarkerId(_markers.length.toString());
    final marker = Marker(
      markerId: markerId,
      position: list[0],
      infoWindow: InfoWindow(title: list[1], snippet: list[2]),
    );
    _markers[markerId] = marker;
    notifyListeners();
  }

  Future<void> _init() async {
    if (!isSending) {
      ubicationSuscription =
          NumberCreator(this.email).stream.map((i) => i).listen(addPoint);
    }
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
        if (isSending) {
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
        }
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
    if (!isSending) {
      ubicationSuscription.cancel();
    }
    super.dispose();
  }
}

class NumberCreator {
  final user_ = FirebaseAuth.instance.currentUser!;
  late String email;
  NumberCreator(String email) {
    this.email = email;
    Timer.periodic(Duration(seconds: 1), (timer) async {
      if (user_ != null) {
        _controller.sink.add(await getUserInfo());
      } else {
        _controller.sink
            .add([new LatLng(-16.3989, -71.537), "Erick", "Marcelo"]);
      }
      // var documentReference =
      //     FirebaseFirestore.instance.collection("Users").doc(user_.email);
      // documentReference.get().then((doc) => {
      //       if (doc.exists) {(documentReference)} else {}
      //     });
    });
  }
  var _count = 1;

  final _controller = StreamController<List>();
  Stream<List> get stream => _controller.stream;

  Future<List> getUserInfo() async {
    var collection = FirebaseFirestore.instance.collection('Users');
    var docSnapshot = await collection.doc(this.email).get();
    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data();
      var latitude = data?['latitude'];
      var longitude = data?['longitude'];
      if (latitude != null && longitude != null) {
        return [new LatLng(latitude, longitude), "Erick", "Marcelo"];
      }
    }
    return [new LatLng(-16.3989, -71.537), "Erick", "Marcelo"];
  }
}
