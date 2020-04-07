import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:foodlion/models/food_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyFood extends StatefulWidget {
  @override
  _MyFoodState createState() => _MyFoodState();
}

class _MyFoodState extends State<MyFood> {
  // Field
  bool statusData = true;
  List<FoodModel> foodModels = List();

  // Method
  @override
  void initState() {
    super.initState();
    readAllFood();
  }

  Future<String> getIdShop() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String idShop = preferences.getString('id');

    return idShop;
  }

  Future<void> readAllFood() async {
    String idShop = await getIdShop();
    String url =
        'http://movehubs.com/app/getFoodWhereIdShop.php?isAdd=true&idShop=$idShop';

    Response response = await Dio().get(url);
    if (response.toString() != 'null') {
      var result = json.decode(response.data);
      print('result ===>>> $result');

      for (var map in result) {
        FoodModel model = FoodModel.fromJson(map);
        setState(() {
          foodModels.add(model);
          statusData = false;
        });
      }
    }
  }

  Widget showNoData() {
    return Center(
      child: Text('No Menu Please Add Food'),
    );
  }

  Widget showListFood() {
    return ListView.builder(
      itemCount: foodModels.length,
      itemBuilder: (value, index) => showContent(index),
    );
  }

  Widget showContent(int index) => Row(
        children: <Widget>[
          showImageFood(index),
          showText(index),
        ],
      );

  Widget showText(int index) => Container(
        padding: EdgeInsets.all(10.0),
        width: MediaQuery.of(context).size.width * 0.5,
        height: MediaQuery.of(context).size.width * 0.4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            showNameFood(index),
            showPrice(index),
          ],
        ),
      );

  Widget showPrice(int index) => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Text(
            'ราคา = ${foodModels[index].priceFood} บาท',
            style: TextStyle(
              fontSize: 18.0,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ],
      );

  Widget showNameFood(int index) => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(width: MediaQuery.of(context).size.width*0.5-30,
            child: Text(
              foodModels[index].nameFood,
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColorDark,
              ),
            ),
          ),
        ],
      );

  Widget showImageFood(int index) => Container(
        padding: EdgeInsets.all(10.0),
        width: MediaQuery.of(context).size.width * 0.5,
        height: MediaQuery.of(context).size.width * 0.4,
        child: Image.network(
          foodModels[index].urlFood,
          fit: BoxFit.cover,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return statusData ? showNoData() : showListFood();
  }
}
