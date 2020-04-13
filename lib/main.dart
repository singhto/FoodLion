import 'package:flutter/material.dart';
import 'package:foodlion/scaffold/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  Map<int, Color> color = {
    50: Color.fromRGBO(239, 121, 54, 0.1),
    100: Color.fromRGBO(239, 121, 54, 0.2),
    200: Color.fromRGBO(239, 121, 54, 0.3),
    300: Color.fromRGBO(239, 121, 54, 0.4),
    400: Color.fromRGBO(239, 121, 54, 0.5),
    500: Color.fromRGBO(239, 121, 54, 0.6),
    600: Color.fromRGBO(239, 121, 54, 0.7),
    700: Color.fromRGBO(239, 121, 54, 0.8),
    800: Color.fromRGBO(239, 121, 54, 0.9),
    900: Color.fromRGBO(239, 121, 54, 1.0)
  };

  @override
  Widget build(BuildContext context) {
    MaterialColor materialColor = MaterialColor(0xffef7936, color);

    return MaterialApp(
      theme: ThemeData(
        primarySwatch: materialColor,
        fontFamily: 'ThaiSansNeue',
      ),
      debugShowCheckedModeBanner: false,
      title: 'Send',
      home: Home(),
    );
  }
}
