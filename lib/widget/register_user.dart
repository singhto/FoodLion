import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:foodlion/utility/my_constant.dart';
import 'package:foodlion/utility/my_style.dart';
import 'package:foodlion/utility/normal_dialog.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';

class RegisterUser extends StatefulWidget {
  @override
  _RegisterUserState createState() => _RegisterUserState();
}

class _RegisterUserState extends State<RegisterUser> {
  // Field
  double lat, lng;
  File file;
  String name, user, password, phone, urlImage, token = 'token';

  // Method

  @override
  void initState() {
    super.initState();
    findLocation();
  }

  Future<void> findLocation() async {
    LocationData myData = await locationData();
    setState(() {
      lat = myData.latitude;
      lng = myData.longitude;
    });
  }

  Future<LocationData> locationData() async {
    var location = Location();

    try {
      return await location.getLocation();
    } catch (e) {
      return null;
    }
  }

  Widget showMap() {
    LatLng centerLatLng = LatLng(lat, lng);
    CameraPosition cameraPosition = CameraPosition(
      target: centerLatLng,
      zoom: 16.0,
    );

    return GoogleMap(
      initialCameraPosition: cameraPosition,
      markers: myMarkers(),
      onMapCreated: (value) {},
    );
  }

  Set<Marker> myMarkers() {
    LatLng latLng = LatLng(lat, lng);

    return <Marker>[
      Marker(
        markerId: MarkerId('idShop'),
        position: latLng,
        infoWindow: InfoWindow(
          title: 'Your',
          snippet: 'lat = $lat, lng = $lng',
        ),
      ),
    ].toSet();
  }

  Widget showLocation() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      child: lat == null ? MyStyle().showProgress() : showMap(),
    );
  }

  Widget nameForm() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 250.0,
          child: TextField(
            onChanged: (value) => name = value.trim(),
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.account_box),
              hintText: 'Name :',
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget userForm() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 250.0,
          child: TextField(
            onChanged: (value) => user = value.trim(),
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.email),
              hintText: 'User :',
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget passwordForm() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 250.0,
          child: TextField(
            onChanged: (value) => password = value.trim(),
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.lock_open),
              hintText: 'Password :',
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget phoneForm() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 250.0,
          child: TextField(
            onChanged: (value) => phone = value.trim(),
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.phone),
              hintText: 'Phone :',
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
      label: Text('Camera'),
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
      label: Text('Gallery'),
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

  Widget showPicture() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      child: file == null ? Image.asset('images/user.png') : Image.file(file),
    );
  }

  Widget uploadButton() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: RaisedButton.icon(color: MyStyle().primaryColor,
        onPressed: () {
          if (name == null ||
              name.isEmpty ||
              user == null ||
              user.isEmpty ||
              password == null ||
              password.isEmpty ||
              phone == null ||
              phone.isEmpty) {
            normalDialog(context, 'Have Space', 'Please Fill Every Blank');
          } else {
            checkUser();
          }
        },
        icon: Icon(Icons.cloud_upload, color: Colors.white,),
        label: Text('Register', style: MyStyle().h2StyleWhite,),
      ),
    );
  }

  Future<void> checkUser() async {
    String url =
        '${MyConstant().urlGetUserWhereUser}?isAdd=true&User=$user';
    try {
      await Dio().get(url).then((response) {
        if (response.toString() == 'null') {
          // uploadImageToServer();
        } else {
          normalDialog(
            context,
            'User ซ้ำ',
            'เปลี่ยน User ใหม่ คะ ? User ซ้ำ',
            icon: MyStyle().signUpIcon,
          );
        }
      });
    } catch (e) {
      insertDtaToMySQL();
    }
  }

  Future<void> uploadImageToServer() async {
    String url = MyConstant().urlSaveFileUser;
    Random random = Random();
    int i = random.nextInt(100000);
    String nameFile = 'user$i.jpg';

    try {
      Map<String, dynamic> map = Map();
      map['file'] = UploadFileInfo(file, nameFile);
      FormData formData = FormData.from(map);
      await Dio()
          .post(url, data: formData)
          .then((response){})
          .catchError(() {});
    } catch (e) {}
  }

  

  Future<void> insertDtaToMySQL() async {
    String urlAPI =
        'http://movehubs.com/app/addUser.php?isAdd=true&Name=$name&User=$user&Password=$password&Token=$token&Lat=$lat&Lng=$lng';

    try {
      await Dio().get(urlAPI).then(
        (response) {
          print('res==>>>$response');
          if (response.toString() == 'true') {
          } else {
            normalDialog(context, 'Register False', 'Please Try Again');
          }
        },
      );
    } catch (e) {}
  }

  Widget showListView() {
    return ListView(
      padding: EdgeInsets.all(16.0),
      children: <Widget>[
        // MyStyle().showTitle('User Picture'),
        // showPicture(),
        // showButton(),
        MyStyle().mySizeBox(),
        MyStyle().showTitle('Information'),
        MyStyle().mySizeBox(),
        nameForm(),
        MyStyle().mySizeBox(),
        userForm(),
        MyStyle().mySizeBox(),
        passwordForm(),
        MyStyle().mySizeBox(),
        phoneForm(),
        MyStyle().mySizeBox(),
        showLocation(),
        MyStyle().mySizeBox(),
        uploadButton(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return showListView();
  }
}
