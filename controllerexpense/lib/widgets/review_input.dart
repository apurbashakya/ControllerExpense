import 'package:flutter/material.dart';

class Review extends StatefulWidget {
  const Review({Key? key}) : super(key: key);
  @override
  State<Review> createState() => _ReviewState();
}

class _ReviewState extends State<Review> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container(
      padding: EdgeInsetsDirectional.all(10),
      height: 220,
      width: 10,
    ));
  }
}
