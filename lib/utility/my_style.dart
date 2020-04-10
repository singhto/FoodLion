import 'package:flutter/material.dart';

class MyStyle {
  // Field
  Color primaryColor = Color.fromARGB(0xff, 0xef, 0x79, 0x36);
  Color dartColor = Color.fromARGB(0xff, 0xb7, 0x4a, 0x02);
  Color lightColor = Color.fromARGB(0xff, 0xff, 0xaa, 0x64);

  String font = 'ThaiSansNeue';

  // Method
  // Icon signInIcon = Icon(
  //   Icons.fingerprint,
  //   size: 36.0,
  //   color: MyStyle().dartColor,
  // );

  Icon signUpIcon = Icon(
    Icons.system_update,
    size: 36.0,
    color: Color.fromARGB(0xff, 0xb7, 0x4a, 0x02),
  );

  TextStyle hiStyleWhite = TextStyle(
    fontFamily: 'ThaiSansNeue',
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: 24.0,
  );

  TextStyle h3StylePrimary = TextStyle(
    fontSize: 16.0,
    color: Color.fromARGB(0xff, 0xef, 0x79, 0x36),
  );

  TextStyle h2StyleWhite = TextStyle(
    fontFamily: 'ThaiSansNeue',
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: 18.0,
  );

  TextStyle h2Style = TextStyle(
    fontFamily: 'ThaiSansNeue',
    color: Color.fromARGB(0xff, 0xb7, 0x4a, 0x02),
    fontWeight: FontWeight.bold,
    fontSize: 18.0,
  );

  TextStyle h2StylePrimary = TextStyle(
    fontFamily: 'ThaiSansNeue',
    color: Color.fromARGB(0xff, 0xef, 0x79, 0x36),
    fontWeight: FontWeight.bold,
    fontSize: 18.0,
  );

  TextStyle h1Style = TextStyle(
    fontFamily: 'ThaiSansNeue',
    color: Color.fromARGB(0xff, 0xb7, 0x4a, 0x02),
    fontWeight: FontWeight.bold,
    fontSize: 24.0,
  );

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
              fontFamily: 'ThaiSansNeue',
              color: Color.fromARGB(0xff, 0xb7, 0x4a, 0x02),
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
          Container(
            width: 250.0,
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

  MyStyle();
}
