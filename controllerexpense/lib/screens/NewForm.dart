import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:controllerexpense/screens/Signup.dart';
import 'package:controllerexpense/screens/place_list.dart';

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
              decoration: InputDecoration(
                hintText: 'Enter your password',
                labelText: 'password',
              ),
              onChanged: (value) {
                password = value;
              },
            ),
            Center(
              child: ElevatedButton(
                child: Text('login'),
                onPressed: ()async {
                    try {
                      await auth.signInWithEmailAndPassword(
                          email: email, password: password);
                      await Navigator.of(context).push(
                         MaterialPageRoute(builder: (context) => PlacesList()));
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
                 TextButton(child: Text('Forgot Password'), onPressed: () {}),
            ),
            Center(
                child: TextButton(
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

