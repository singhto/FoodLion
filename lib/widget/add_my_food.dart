import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:foodlion/scaffold/home.dart';
import 'package:foodlion/utility/my_style.dart';
import 'package:foodlion/utility/normal_dialog.dart';
import 'package:foodlion/widget/my_food.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddMyFood extends StatefulWidget {
  @override
  _AddMyFoodState createState() => _AddMyFoodState();
}

class _AddMyFoodState extends State<AddMyFood> {
  // Field
  String idShop, nameFood, detailFood, urlFood, priceFood, score = '0';
  File file;

  // Method
  @override
  void initState() {
    super.initState();
    findIdShop();
  }

  Future<void> findIdShop() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      idShop = preferences.getString('id');
    } catch (e) {}
  }

  Widget showImageFood() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.3,
      child: file == null ? Image.asset('images/food2.png') : Image.file(file),
    );
  }

  Widget nameForm() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 250.0,
          child: TextField(
            onChanged: (value) => nameFood = value.trim(),
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.fastfood),
              hintText: 'ชื่ออาหาร :',
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget detailForm() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 250.0,
          child: TextField(
            onChanged: (value) => detailFood = value.trim(),
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.details),
              hintText: 'รายละเอียด :',
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget priceForm() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 250.0,
          child: TextField(
            keyboardType: TextInputType.number,
            onChanged: (value) => priceFood = value.trim(),
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.attach_money),
              hintText: 'ราคา :',
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget cameraButton() {
    return OutlineButton.icon(
      onPressed: () => chooseImage(ImageSource.camera),
      icon: Icon(Icons.add_a_photo),
      label: Text('ถ่ายภาพ'),
    );
  }

  Future<void> chooseImage(ImageSource source) async {
    try {
      var object = await ImagePicker.pickImage(
        source: source,
        maxWidth: 800.00,
        maxHeight: 800.00,
      );

      setState(() {
        file = object;
      });
    } catch (e) {}
  }

  Widget galleryButton() {
    return OutlineButton.icon(
      onPressed: () => chooseImage(ImageSource.gallery),
      icon: Icon(Icons.add_photo_alternate),
      label: Text('คลังภาพ'),
    );
  }

  Widget showButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        cameraButton(),
        galleryButton(),
      ],
    );
  }

  Widget saveButton() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: RaisedButton.icon(color: MyStyle().primaryColor,
        onPressed: () {
          if (file == null) {
            normalDialog(
                context, 'Non Choose Image', 'Please Click Camera or Gallery');
          } else if (nameFood == null ||
              nameFood.isEmpty ||
              detailFood == null ||
              detailFood.isEmpty ||
              priceFood == null ||
              priceFood.isEmpty) {
            normalDialog(context, 'Have Space', 'Please Fill Every Blank');
          } else {
            uploadImage();
          }
        },
        icon: Icon(Icons.fastfood, color: Colors.white,),
        label: Text('Save Food', style: MyStyle().h2StyleWhite,),
      ),
    );
  }

  Future<void> uploadImage() async {
    try {
      String url = 'http://movehubs.com/app/saveFood.php';
      Random random = Random();
      int i = random.nextInt(100000);
      String nameImage = 'food$i.jpg';
      print('nameImage = $nameImage');

      Map<String, dynamic> map = Map();
      map['file'] = UploadFileInfo(file, nameImage);
      FormData formData = FormData.from(map);
      await Dio().post(url, data: formData).then((response) {
        urlFood = 'http://movehubs.com/app/Food/$nameImage';
        print('urlFood ===>>> $urlFood');
        saveFoodThread();
      });
    } catch (e) {}
  }

  Future<void> saveFoodThread() async {
    try {

      String url = 'http://movehubs.com/app/addFoodShop.php?isAdd=true&idShop=$idShop&NameFood=$nameFood&DetailFood=$detailFood&UrlFood=$urlFood&PriceFood=$priceFood&Score=$score';

      Response response = await Dio().get(url);
      if (response.toString() == 'true') {
        MaterialPageRoute route = MaterialPageRoute(builder: (value)=>Home(currentWidget: MyFood(),));
        Navigator.of(context).pushAndRemoveUntil(route, (value)=>false);
      } else {
        normalDialog(context, 'Cannot Add Food', 'Please Try Again');
      }

    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16.0),
      children: <Widget>[
        MyStyle().showTitle('เพิ่มรายการอาหาร'),
        MyStyle().mySizeBox(),
        showImageFood(),
        MyStyle().mySizeBox(),
        showButton(),
        MyStyle().mySizeBox(),
        nameForm(),
        MyStyle().mySizeBox(),
        detailForm(),
        MyStyle().mySizeBox(),
        priceForm(),
        MyStyle().mySizeBox(),
        saveButton(),
        MyStyle().mySizeBox(),
      ],
    );
  }
}
