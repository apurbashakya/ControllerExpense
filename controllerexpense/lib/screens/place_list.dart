import 'package:flutter/material.dart';
import 'package:controllerexpense/screens/place_add.dart';

class PlacesList extends StatelessWidget {
  const PlacesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Scaffold be cause we want to render entire page

    return Scaffold(
      appBar: AppBar(
        title: Text('Saloons'),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddPlace()),
                );
            }, 
            icon: Icon(Icons.add)
            )
        ],
      ),
      body: Center(child: CircularProgressIndicator(),
      ),
    );
  }
}
