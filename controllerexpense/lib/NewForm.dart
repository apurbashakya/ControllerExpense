// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Signup.dart';
import 'home.dart';

class NewForm extends StatefulWidget {
  const NewForm({Key? key}) : super(key: key);

  @override
  _NewFormState createState() => _NewFormState();
}
final auth = FirebaseAuth.instance;
late String email, password;
bool showSpinner = false;

class _NewFormState extends State<NewForm> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    return Scaffold(body: new Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Enter your name',
                labelText: 'Name',
              ),
              onChanged: (value) {
                email = value;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Enter your password',
                labelText: 'password',
              ),
              onChanged: (value) {
                password = value;
              },
            ),
            Center(
              child: RaisedButton(
                child: Text('login'),
                onPressed: ()async {
                    try {
                      await auth.signInWithEmailAndPassword(
                          email: email, password: password);
                      await Navigator.of(context).push(
                         MaterialPageRoute(builder: (context) => Home()));
                    } on FirebaseAuthException catch (e) {
                      showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                                title: const Text("Login Failed"),
                                content: Text('${e.message}'),
                              ));
                    }
                    /*{
                  auth.signInWithEmailAndPassword(email: email, password: password).then((_){
                    
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Home()));
                  });
                  
            }*/
                  }),
            ),
            Center(
              child:
                  FlatButton(child: Text('Forgot Password'), onPressed: () {}),
            ),
            Center(
                child: FlatButton(
              child: Text('Dont have an account',
                  style: TextStyle(color: Colors.blue[400], fontSize: 16)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Signup()),
                );
              },
            ))
          ],
        ),
      ),
    );
  }
}

