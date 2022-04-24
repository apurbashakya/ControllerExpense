// @dart=2.9
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:controllerexpense/providers/placesDb.dart';
import 'package:provider/provider.dart';
import 'package:controllerexpense/screens/place_add.dart';
import 'package:controllerexpense/screens/place_list.dart';
import './screens/NewForm.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: PlacesDb(),
      child: MaterialApp(
        title: 'Systematic Ticketing Life',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          accentColor: Colors.amber,
          primaryColor: Colors.greenAccent,
        ),
        home: _MyHomePageState(),
      ),
    );
  }
}

class _MyHomePageState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColorDark,
        appBar: AppBar(
          title: Text('Systematic Ticketing Life'),
          backgroundColor: Theme.of(context).backgroundColor,
        ),
        body: Center(
          child: ElevatedButton(
            child: Text('SETUP'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NewForm()),
              );
            },
          ),
        )); // This trailing comma makes auto-formatting nicer for build methods.
  }
}
