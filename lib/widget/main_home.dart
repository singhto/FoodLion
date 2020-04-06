import 'package:flutter/material.dart';
import 'package:foodlion/utility/my_style.dart';

class MainHome extends StatefulWidget {
  @override
  _MainHomeState createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  // Field

  // Method
  Widget showBanner() {
    return Container(
      color: Colors.grey,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.2,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        showBanner(),
        MyStyle().showTitle('Shop'),
      ],
    );
  }
}
