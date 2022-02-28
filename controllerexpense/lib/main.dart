import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'NewForm.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Controller Expense',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColorDark: Colors.lightBlue,
        backgroundColor: Colors.blueGrey,
      ),
      home: _MyHomePageState(),
    );
  }
}

class _MyHomePageState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColorDark,
        appBar: AppBar(
          title: Text('Controller Expense'),
          backgroundColor: Theme.of(context).backgroundColor,
        ),
        body: Center(
          child: ElevatedButton(
            child: Text('LESSS GO'),
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
