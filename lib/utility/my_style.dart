import 'package:flutter/material.dart';

class MyStyle {
  // Field

  Widget mySizeBox() {
    return SizedBox(
      width: 8.0,
      height: 16.0,
    );
  }

  Widget showTitle(String string) {
    return Text(
      string,
      style: TextStyle(
        fontSize: 24.0,
      ),
    );
  }

  Widget showProgress() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  // Method
  MyStyle();
}
