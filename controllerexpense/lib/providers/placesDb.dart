import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import '../models/detailsDisplay.dart';
import 'dart:io';

class PlacesDb with ChangeNotifier {
//ChangeNotifier calls notify listeners which will be use by provider package to update all plcaeswhere we listen yo object we are after
  List<Place> _items = [];
  List<Place> get items {
    return [..._items];
  }

  void addPlace(String pickedtitle, File pickedimage) {
    var location2 = null;
    final newPlace = Place(
        id: DateTime.now().toString(),
        image: FileImage(pickedimage),
        title: pickedtitle,
        location: location2
        );
    _items.add(newPlace);
    notifyListeners();
  }
}
