import 'package:flutter/material.dart';
import 'package:foodlion/scaffold/home.dart';


void main()=>runApp(MyApp());


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Lion',
      home: Home(),
    );
  }
}