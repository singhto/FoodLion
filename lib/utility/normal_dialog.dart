import 'package:flutter/material.dart';
import 'package:foodlion/utility/my_style.dart';

Future<void> normalDialog(BuildContext context, String title, String message,
    {Icon icon}) async {
  if (icon == null) {
    icon = Icon(
      Icons.question_answer,
      size: 36,
      color: MyStyle().dartColor,
    );
  }
  showDialog(
    context: context,
    builder: (value) => AlertDialog(
      title: showTitle(title, icon),
      content: Text(message, style: MyStyle().h2StylePrimary,),
      actions: <Widget>[
        FlatButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('OK', style: MyStyle().h2Style,),
        ),
      ],
    ),
  );
}

Widget showTitle(String title, Icon icon) => ListTile(
      leading: icon,
      title: Text(title, style: MyStyle().h2Style,),
    );
