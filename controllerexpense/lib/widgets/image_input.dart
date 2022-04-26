// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
// ignore: import_of_legacy_library_into_null_safe
import 'package:path_provider/path_provider.dart' as sys;

class ImageInput extends StatefulWidget {
  final Function onSelectImage;
  ImageInput(this.onSelectImage);
  @override
  State<ImageInput> createState() => _ImageInputState();
}

//we will be working with real image files not network hechce real time data
class _ImageInputState extends State<ImageInput> {
  File? storedImage;

  //get path => null; //this will hold our file
  //we dont instatntiate we are just gonna use some static methods it has
  Future<void> clickPicture() async {
    //pickimage is future so we need async
    final imageFile = await ImagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );
    setState(() {
      storedImage = imageFile;
    });
    final appDirectory = await sys
        .getApplicationDocumentsDirectory(); //directory with appdata so we can also get the path where we can store
    final fileName = path.basename(imageFile
        .path); //where ur image is currently stored, basename is a fancy name for file name not even extension will be there
    final savedimage = await imageFile.copy(
        '${appDirectory.path}/$fileName'); //copies filename in the appDirectory.path
    widget.onSelectImage(savedimage);
  }

  @override
  Widget build(BuildContext context) {
    //to return preview and button side by side
    return Row(
      children: <Widget>[
        //for preview
        Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(border: Border.all(width: 1)),
          //if image is present we preview else display no image
          //image.file will create image basedd on the file, flutter fill find the file render it parse it
          child: storedImage != null
              ? Image.file(
                  storedImage!,
                  width: double.infinity,
                  fit: BoxFit.cover,
                )
              : Text('No Image found'),
        ),
        //to take a picture
        SizedBox(
          child: Expanded(
              child: TextButton.icon(
                  onPressed:
                      clickPicture, //no parenthisis beacuse we dont want to execute it on code parsing rather when it is clicked
                  icon: Icon(Icons.camera_enhance),
                  label: Text(
                    'Click Picture',
                    textAlign: TextAlign.center,
                  ))),
        ),
      ],
    );
  }
}
