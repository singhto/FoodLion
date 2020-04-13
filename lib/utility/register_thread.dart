import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:foodlion/utility/my_style.dart';


import 'normal_dialog.dart';

class RegisterThread {

  Future<bool> checkUser(BuildContext context, String url) async {
    // String url =
    //     '${MyConstant().urlGetUserShopWhereUser}?isAdd=true&User=$user';
    try {
      await Dio().get(url).then((response) {
        if (response.toString() == 'null') {
          // uploadImageToServer();
          return true;
        } else {
          normalDialog(
            context,
            'User ซ้ำ',
            'เปลี่ยน User ใหม่ คะ ? User ซ้ำ',
            icon: MyStyle().signUpIcon,
          );
          return false;
        }
      });
    } catch (e) {
      return false;
    }
  }

  RegisterThread();

  
}