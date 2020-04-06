import 'package:flutter/material.dart';
import 'package:foodlion/utility/my_style.dart';

class SignInApp extends StatefulWidget {
  final String typeLogin;
  SignInApp({Key key, this.typeLogin});

  @override
  _SignInAppState createState() => _SignInAppState();
}

class _SignInAppState extends State<SignInApp> {
  // Field
  String typeLogin;

  // Method
  @override
  void initState() {
    super.initState();
    typeLogin = widget.typeLogin;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[MyStyle().showTitle('Login Type $typeLogin')],
    );
  }
}
