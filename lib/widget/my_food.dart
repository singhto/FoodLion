import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyFood extends StatefulWidget {
  @override
  _MyFoodState createState() => _MyFoodState();
}

class _MyFoodState extends State<MyFood> {
  // Field
  bool statusData = true;

  // Method
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readAllFood();
  }

  Future<String> getIdShop() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String idShop = preferences.getString('id');

    return idShop;
  }

  Future<void> readAllFood()async{

    String idShop = await getIdShop();
    String url = 'http://movehubs.com/app/getFoodWhereIdShop.php?isAdd=true&idShop=$idShop';

    Response response = await Dio().get(url);
    if (response.toString() != 'null') {
      setState(() {
        statusData = false;
      });
    } 


  }

  Widget showNoData(){
    return Center(child: Text('No Menu Please Add Food'),);
  }

  Widget showListFood(){
    return Text('ListFood');
  }

  @override
  Widget build(BuildContext context) {
    return statusData ? showNoData(): showListFood();
  }
}
