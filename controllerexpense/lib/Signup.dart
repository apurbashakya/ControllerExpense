import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'NewForm.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();

  late String age, email, password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ignore: unnecessary_new
      body: new Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              onChanged: (value) {
                email = value;
              },
              decoration: InputDecoration(
                hintText: 'Enter your email',
                labelText: 'Email ID',
              ),
            ),
            TextFormField(
              onChanged: (value) {
                password = value;
              },
              decoration: InputDecoration(
                hintText: 'Enter your Password',
                labelText: 'Password',
              ),
            ),
            Center(
              child: RaisedButton(
                child: Text('submit'),
                onPressed: () async {
                  UserCredential authResult;
                  authResult = await FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                          email: email, password: password);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
