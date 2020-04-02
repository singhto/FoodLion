import 'dart:io';

import 'package:flutter/material.dart';
import 'package:foodlion/utility/my_style.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';

class RegisterShop extends StatefulWidget {
  @override
  _RegisterShopState createState() => _RegisterShopState();
}

class _RegisterShopState extends State<RegisterShop> {
  // Field
  double lat, lng;
  File file;

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
          title: 'Your Shop',
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
      child:
          file == null ? Image.asset('images/picture.png') : Image.file(file),
    );
  }

  Widget uploadButton() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: RaisedButton.icon(
        onPressed: () {},
        icon: Icon(Icons.cloud_upload),
        label: Text('Register'),
      ),
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
