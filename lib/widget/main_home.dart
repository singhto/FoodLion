import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:foodlion/models/user_shop_model.dart';
import 'package:foodlion/utility/my_constant.dart';
import 'package:foodlion/utility/my_style.dart';

class MainHome extends StatefulWidget {
  @override
  _MainHomeState createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  // Field
  List<UserShopModel> userShopModels = List();
  List<Widget> showWidgets = List();

  // Method

  @override
  void initState() {
    super.initState();
    readShopThread();
  }

  Future<void> readShopThread() async {
    String url = MyConstant().urlGetAllShop;

    try {
      Response response = await Dio().get(url);
      var result = json.decode(response.data);
      print('result ===>>> $result');

      for (var map in result) {
        UserShopModel model = UserShopModel.fromJson(map);
        setState(() {
          userShopModels.add(model);
          showWidgets.add(createCard(model));
        });
      }
    } catch (e) {}
  }

  Widget showImageShop(UserShopModel model) {
    return Container(
      width: 60.0,
      height: 60.0,
      child: CircleAvatar(
        backgroundImage: NetworkImage(model.urlShop),
      ),
    );
  }

  Widget createCard(UserShopModel model) {
    return GestureDetector(
      onTap: () {
        print('You Click ${model.id}');
      },
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            showImageShop(model),
            showName(model),
          ],
        ),
      ),
    );
  }

  Text showName(UserShopModel model) => Text(
        model.name,
        style: TextStyle(
          fontSize: 16.0,
        ),
      );

  Widget showShop() {
    return showWidgets.length == 0
        ? MyStyle().showProgress()
        : Expanded(
            child: GridView.extent(
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
              maxCrossAxisExtent: 130.0,
              children: showWidgets,
            ),
          );
  }

  Widget showBanner() {
    return Container(
      color: Colors.grey,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.2,
    );
  }

  @override
  Widget build(BuildContext context) {
    // return showShop();

    return Column(
      children: <Widget>[
        showBanner(),
        MyStyle().showTitle('Shop'),
        showShop(),
      ],
    );
  }
}
