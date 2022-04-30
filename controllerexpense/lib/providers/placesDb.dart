import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../models/detailsDisplay.dart';
import 'dart:io';
import '../helpers/dbHelper.dart';
import '../widgets/review_input.dart';

var location2 = null;

class PlacesDb with ChangeNotifier {
//ChangeNotifier calls notify listeners which will be use by provider package to update all plcaeswhere we listen yo object we are after
  List<Place> _items = [];
  List<Place> get items {
    return [..._items];
  }

  void addPlace(String pickedtitle, String pickedreview, File pickedimage) {
    final newPlace = Place(
        id: DateTime.now().toString(),
        image: FileImage(pickedimage),
        title: pickedtitle,
        location: location2
    );
    _items.add(newPlace);
    notifyListeners();
    DBHelper.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.file.path
    });
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.getData('user_places');
    _items = dataList
        .map(
          (item) => Place(
              id: item['id'],
              title: item['title'],
              image: FileImage(item['image']),
              location: location2
              ),
        )
        .toList();
         
      print('SAD');
        //we return the Place
    //We have to tranform dataList to list of places
    notifyListeners();
  }
}
