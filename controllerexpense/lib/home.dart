import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'NewForm.dart';
import 'locationGet.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorDark,
      appBar: AppBar(
        title: Text('WELCOME'),
        backgroundColor: Theme.of(context).backgroundColor,
      ),
    );
  }
}
