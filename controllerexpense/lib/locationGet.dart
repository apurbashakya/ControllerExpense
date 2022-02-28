import 'dart:ffi';

import 'home.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

class location extends StatefulWidget {
  const location({Key? key}) : super(key: key);

  @override
  _locationState createState() => _locationState();
}
  bool? _serviceEnabled;
  PermissionStatus? _permissionGranted;
  LocationData ?_userLocation;
Future getUserLocation() async {
  
    Location location = new Location();

    // Check if location service is enable
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled!) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled!) {
        return;
      }
    }

    // Check if permission is granted
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    final _locationData = await location.getLocation();
}

class _locationState extends State<location> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('$_userLocation'),
    );
  }
}
