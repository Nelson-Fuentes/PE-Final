import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:pe_final/map_controller.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';


class MapPage extends StatelessWidget {
  final String name, lastname;
  final LatLng ubicacion;
  
  const MapPage(
      {Key? key,
      required this.name,
      required this.lastname, 
      required this.ubicacion})
      : super(key: key);

  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MapController>(
      create: (_){
        final controller = MapController();
        controller.addPoint(this.ubicacion,this.name,this.lastname);
        return controller;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Mapa de " + name),
        ),
        body: Consumer<MapController>(
          builder: (_,controller,__){
            var widget=null;
            print("Access"+controller.gpsEnable.toString());
            if(!controller.gpsEnable){
              widget = Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text("Necesitamos de la tu Ubicación para proporcionarte servicio",
                      textAlign:TextAlign.center
                    )
                  ],
                ),
              );
            }else{
                widget = GoogleMap(
                markers: controller.markers,
                initialCameraPosition: CameraPosition(target: ubicacion , zoom: 16),
                myLocationButtonEnabled: true,
                myLocationEnabled: true,
                scrollGesturesEnabled: true,
                zoomGesturesEnabled: true 
              );
            }
            return widget;
          } 
        ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              FlutterPhoneDirectCaller.callNumber('51983199102');
            },
            backgroundColor: Colors.green,
            child: const Icon(Icons.phone)
          )
        )
      );
  }
}

//widget.longitude.toString()
// GoogleMap(
//           markers: controller.markers,
//           initialCameraPosition: CameraPosition(target: ubicacion , zoom: 16),
//           myLocationButtonEnabled: true,
//           scrollGesturesEnabled: true,
//           zoomGesturesEnabled: true
//         ),
//         floatingActionButton: FloatingActionButton(
//           onPressed: () {
//             FlutterPhoneDirectCaller.callNumber('51983199102');
//           },
//           backgroundColor: Colors.green,
//           child: const Icon(Icons.phone),
//         ))