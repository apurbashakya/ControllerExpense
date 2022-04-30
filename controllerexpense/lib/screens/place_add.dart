import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import '../widgets/image_input.dart';
import 'package:provider/provider.dart';
import '../providers/placesDb.dart';
import '../widgets/review_input.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';


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
    if (_titleController.text.isEmpty ||
        _reviewController.text.isEmpty ||
        _pickedImage == null) {
      return;
    }
    Provider.of<PlacesDb>(context, listen: false)
        .addPlace(_titleController.text, _reviewController.text, _pickedImage!);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a new hairSaloon'),
      ),
      body: Column(
        // we romeved main axis alinment because we useed exapnded which will enable first child to take all height it can get, but will leaved"Add place button the required space it needs" , mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(labelText: 'Title'),
                    controller: _titleController,
                  ),
                  SizedBox(
                    height: 10,
                  ), //to store our preview and take picture
                  ImageInput(_selectImage),
                  Container(
                    padding: EdgeInsetsDirectional.all(10),
                    height: 220,
                    width: double.maxFinite,
                    child: Card(
                      child: Column(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          const TextField(
                              textAlignVertical: TextAlignVertical.top,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 40),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.blueAccent,
                                  ),
                                ),
                                labelText: "Add the review",
                              )),
                        ],
                      ),
                      elevation: 10,
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
                  ElevatedButton.icon(
                    onPressed:
                        () {}, //() {MaterialPageRoute(builder: (context) => AddPlace());},
                    icon: Icon(Icons.abc_sharp),
                    label: Text('Add Review'),
                    // ignore: deprecated_member_use
                  )
                ],
              ),
            ),
          ),
          ElevatedButton.icon(
            onPressed:
                _savePlace, //() {MaterialPageRoute(builder: (context) => AddPlace());},
            icon: const Icon(Icons.add),
            label: Text('Add Place'),
            // ignore: deprecated_member_use
          )
        ],
      ),
    );
  }
}
