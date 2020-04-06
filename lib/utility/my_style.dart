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
    return Row(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(8.0),
          child: Text(
            string,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24.0,
            ),
          ),
        ),
      ],
    );
  }

  Widget showProgress() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget contentSignIn() {
    return Container(
      width: 250.0,
      child: Column(
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
              labelText: 'User :',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(
            height: 16.0,
          ),
          TextField(
            decoration: InputDecoration(
              labelText: 'Password :',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(
            height: 16.0,
          ),
          Container(width: 250.0,
            child: RaisedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.fingerprint),
              label: Text('Sign In'),
            ),
          ),
        ],
      ),
    );
  }

  // Method
  MyStyle();
}
