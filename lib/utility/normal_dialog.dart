import 'package:flutter/material.dart';

Future<void> normalDialog(
    BuildContext context, String title, String message) async {
  showDialog(
    context: context,
    builder: (value) => AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: <Widget>[
        FlatButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('OK'),
        ),
      ],
    ),
  );
}
