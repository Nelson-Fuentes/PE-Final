import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapController extends ChangeNotifier{
  MapController(){
    _init();
  }

  Map<MarkerId,Marker> _markers = {};
  Set<Marker> get markers => _markers.values.toSet();

  late bool _gpsEnable=false;
  bool get gpsEnable => _gpsEnable;

  StreamSubscription? _gpsSubscription;

  final initialCamaraPosition = const CameraPosition(
    target: LatLng(-16.399314,-71.536684),
    zoom: 15
  );

  void addPoint(LatLng position,String title,String description){
    final markerId = MarkerId(_markers.length.toString());
    final marker = Marker(
      markerId: markerId,
      position: position,
      infoWindow: InfoWindow(title:title,snippet:description),
    );
    _markers[markerId] = marker;
    notifyListeners();
  }

  Future<void> _init() async{
    _gpsEnable = await Geolocator.isLocationServiceEnabled();
    _gpsSubscription = Geolocator.getServiceStatusStream().listen((status){
      _gpsEnable = status == ServiceStatus.enabled;
      notifyListeners();
    });
      notifyListeners();
  }

  @override
  void dispose(){
    _gpsSubscription?.cancel();
    super.dispose();
  }
}