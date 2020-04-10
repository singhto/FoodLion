import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:foodlion/models/banner_model.dart';
import 'package:foodlion/models/user_shop_model.dart';
import 'package:foodlion/scaffold/home.dart';
import 'package:foodlion/utility/my_constant.dart';
import 'package:foodlion/utility/my_style.dart';
import 'package:foodlion/widget/my_food.dart';

class MainHome extends StatefulWidget {
  @override
  _MainHomeState createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  // Field
  List<UserShopModel> userShopModels = List();
  List<Widget> showWidgets = List();
  List<BannerModel> bannerModels = List();
  List<Widget> showBanners = List();

  // Method
  @override
  void initState() {
    super.initState();
    readBanner();
    readShopThread();
  }

  Future<void> readBanner() async {
    String url = MyConstant().urlGetAllBanner;
    try {
      Response response = await Dio().get(url);
      var result = json.decode(response.data);
      for (var map in result) {
        BannerModel model = BannerModel.fromJson(map);
        Widget bannerWieget = createBanner(model);
        setState(() {
          bannerModels.add(model);
          showBanners.add(bannerWieget);
        });
      }
    } catch (e) {}
  }

  Widget createBanner(BannerModel model) {
    return CachedNetworkImage(imageUrl: model.pathImage);
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
      width: 80.0,
      height: 80.0,
      child: CircleAvatar(
        backgroundImage: NetworkImage(model.urlShop),
      ),
    );
  }

  Widget testListView() {
    return Expanded(
      child: ListView.builder(
        itemCount: showWidgets.length,
        itemBuilder: (BuildContext context, int index) {
          return Text('Test');
        },
      ),
    );
  }

  Widget createCard(UserShopModel model) {
    return GestureDetector(
      onTap: () {
        print('You Click ${model.id}');
        MaterialPageRoute route = MaterialPageRoute(
          builder: (value) => Home(
            currentWidget: MyFood(
              idShop: model.id,
            ),
          ),
        );
        Navigator.of(context).pushAndRemoveUntil(route, (value) => false);
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
          fontSize: 18.0,
        ),
      );

  Widget showShop() {
    return showWidgets.length == 0
        ? MyStyle().showProgress()
        : Expanded(
            child: GridView.extent(
              mainAxisSpacing: 3.0,
              crossAxisSpacing: 3.0,
              maxCrossAxisExtent: 160.0,
              children: showWidgets,
            ),
          );
  }

  Widget showBanner() {
    return showBanners.length == 0
        ? MyStyle().showProgress()
        : CarouselSlider(
            items: showBanners,
            enlargeCenterPage: true,
            aspectRatio: 16/9,
            pauseAutoPlayOnTouch: Duration(seconds: 3),
            autoPlay: true,
            autoPlayAnimationDuration: Duration(seconds: 3),
          );
  }

  @override
  Widget build(BuildContext context) {
    // return showShop();

    return Column(
      children: <Widget>[
        showBanner(),
        MyStyle().showTitle('ร้านอาหารใกล้คุณ'),
        showShop(),
      ],
    );
  }
}
