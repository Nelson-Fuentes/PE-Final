import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pe_final/request_permission/request_permission_controller.dart';
import 'package:permission_handler/permission_handler.dart';

import '../home.dart';

class RequestPermissionPage extends StatefulWidget {
  const RequestPermissionPage({Key? key}) : super(key: key);

  @override
  _RequestPermissionPageState createState() => _RequestPermissionPageState();
}

class _RequestPermissionPageState extends State<RequestPermissionPage> {
  final _controller = RequestPermissionController(Permission.locationWhenInUse);
  late StreamSubscription _subscription;

  @override
  initState() {
    super.initState();
    _subscription = _controller.onStatusChange.listen((status) => {
          if (status == PermissionStatus.granted)
            {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomeView()),
              )
            }
        });
  }

  @override
  dispose() {
    _subscription.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
          width: double.infinity,
          height: double.infinity,
          alignment: Alignment.center,
          child: ElevatedButton(
              child: const Text("Allow"),
              onPressed: () {
                _controller.request();
              })),
    ));
  }
}
