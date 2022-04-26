
import 'dart:io';
import 'package:flutter/material.dart';
import '../widgets/image_input.dart';
import 'package:provider/provider.dart';
import '../providers/placesDb.dart';

class AddPlace extends StatefulWidget {
  const AddPlace({Key? key})
      : super(key: key); //beacuse we will add this later to our routes table
  @override
  State<AddPlace> createState() => _AddPlaceState();
}

class _AddPlaceState extends State<AddPlace> {
  final _titleController = TextEditingController();
  File? _pickedImage;
  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _savePlace() {
    if (_titleController.text.isEmpty || _pickedImage == null) {
      return;
    }
    Provider.of<PlacesDb>(context, listen: false)
        .addPlace(_titleController.text, _pickedImage!);
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
                ],
              ),
            ),
          ),
          ElevatedButton.icon(
            onPressed: _savePlace, //() {MaterialPageRoute(builder: (context) => AddPlace());},
            icon: const Icon(Icons.add),
            label: Text('Add Place'),
            // ignore: deprecated_member_use
          )
        ],
      ),
    );
  }
}
