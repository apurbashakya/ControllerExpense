import 'dart:io';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../widgets/image_input.dart';
import 'package:provider/provider.dart';
import '../providers/placesDb.dart';
import '../widgets/review_input.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:getwidget/getwidget.dart';
import 'package:geocoding/geocoding.dart';

var rating = 3.0;

class AddPlace extends StatefulWidget {
  const AddPlace({Key? key})
      : super(key: key); //beacuse we will add this later to our routes table
  @override
  State<AddPlace> createState() => _AddPlaceState();
}

class _AddPlaceState extends State<AddPlace> {
  final _titleController = TextEditingController();
  final _reviewController = TextEditingController();
  File? _pickedImage;
  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _savePlace() {
    if (_titleController.text.isEmpty || _pickedImage == null) {
      return;
    }
    Provider.of<PlacesDb>(context, listen: false)
        .addPlace(_titleController.text, _reviewController.text, _pickedImage!);
    Navigator.of(context).pop();
  }

  Position? _currentPosition;
  String? _currentAddress;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a new hairSaloon'),
      ),
      body: Column(
        // we romeved main axis alinment because we useed exapnded which will enable first child to take all height it can get, but will leaved"Add place button the required space it needs" , mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    child: Column(
                      // ignore: prefer_const_literals_to_create_immutable
                      children: [
                        TextField(
                          decoration: const InputDecoration(labelText: 'Title'),
                          controller: _titleController,
                        ), //to store our preview and take picture
                        ImageInput(_selectImage),
                        TextField(
                          textAlignVertical: TextAlignVertical.top,
                          controller: _reviewController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(vertical: 40),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.blueAccent,
                              ),
                            ),
                            labelText: "Add the review",
                          ),
                        ),
                        GFCard(
                          content: const Text("Location deatails"),
                          buttonBar: GFButtonBar(
                            children: <Widget>[
                              if (_currentPosition != null)
                                Text(
                                    "LAT: ${_currentPosition?.latitude}, LNG: ${_currentPosition?.longitude}"),
                              Text(_currentAddress.toString()),
                              GFButton(
                                child: Text("Get location"),
                                icon: Icon(Icons.location_on),
                                onPressed: () {
                                  _getCurrentLocation();
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SmoothStarRating(
                    rating: rating,
                    isReadOnly: false,
                    size: 40,
                    filledIconData: Icons.star,
                    halfFilledIconData: Icons.star_half,
                    defaultIconData: Icons.star_border,
                    starCount: 5,
                    allowHalfRating: true,
                    spacing: 1.0,
                    onRated: (value) {
                      // print("rating value dd -> ${value.truncate()}");
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _getCurrentLocation() {
    Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best,
            forceAndroidLocationManager: true)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        _getAddressFromLatLng();
      });
    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          _currentPosition!.latitude, _currentPosition!.longitude);

      Placemark place = placemarks[0];

      setState(() {
        _currentAddress =
            "${place.locality}, ${place.postalCode}, ${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }
}
