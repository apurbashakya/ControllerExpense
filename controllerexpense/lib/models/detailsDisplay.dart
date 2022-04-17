import 'package:http/http.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';

class PlaceLocation {
  final double latitude;
  final double longitude;
  final String address;
  PlaceLocation({
    required this.address,
    required this.latitude,
    required this.longitude,
  });
}

class Place {
  final String id;
  final String title;
  final FileImage image;
  final PlaceLocation location; //to display lcation we calucalte in PlaceLocation 
  Place({
    required this.id,
    required this.image,
    required this.title,
    required this.location,
  });
}
