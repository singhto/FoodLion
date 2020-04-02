import 'package:flutter/material.dart';
import 'package:foodlion/utility/my_style.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RegisterShop extends StatefulWidget {
  @override
  _RegisterShopState createState() => _RegisterShopState();
}

class _RegisterShopState extends State<RegisterShop> {
  // Field

  // Method
  Widget showMap() {
    LatLng centerLatLng = LatLng(16.751665, 101.215847);
    CameraPosition cameraPosition = CameraPosition(
      target: centerLatLng,
      zoom: 16.0,
    );

    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      child: GoogleMap(initialCameraPosition: cameraPosition,
      onMapCreated: (value){},),
    );
  }

  Widget nameForm() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 250.0,
          child: TextField(
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
      onPressed: () {},
      icon: Icon(Icons.add_a_photo),
      label: Text('Camera'),
    );
  }

  Widget galleryButton() {
    return OutlineButton.icon(
      onPressed: () {},
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
      child: Image.asset('images/picture.png'),
    );
  }

  Widget showListView() {
    return ListView(
      padding: EdgeInsets.all(16.0),
      children: <Widget>[
        MyStyle().showTitle('Shop Picture'),
        showPicture(),
        showButton(),
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
        showMap(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return showListView();
  }
}
