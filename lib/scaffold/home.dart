import 'package:flutter/material.dart';
import 'package:foodlion/utility/my_style.dart';
import 'package:foodlion/widget/main_home.dart';
import 'package:foodlion/widget/register_delivery.dart';
import 'package:foodlion/widget/register_shop.dart';
import 'package:foodlion/widget/register_user.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Field
  Widget cuttentWidget = MainHome();

  // Method

  Widget showDrawer() {
    return Drawer(
      child: ListView(
        children: <Widget>[
          showHead(),
          menuHome(),
          menuSignUp(),
        ],
      ),
    );
  }

  Widget menuSignUp() {
    return ListTile(
      leading: Icon(Icons.android),
      title: Text('Sign Up'),
      subtitle: Text('For New Register'),
      onTap: () {
        Navigator.of(context).pop();
        chooseRegister();
      },
    );
  }

  Widget showButtom() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: 150.0,
          child: Row(
            children: <Widget>[
              FlatButton.icon(
                onPressed: () {
                  setState(() {
                    cuttentWidget = RegisterUser();
                    Navigator.of(context).pop();
                  });
                },
                icon: Icon(Icons.check_box_outline_blank),
                label: Text('User'),
              ),
            ],
          ),
        ),
        Container(
          width: 150.0,
          child: Row(
            children: <Widget>[
              FlatButton.icon(
                onPressed: () {
                  setState(() {
                    cuttentWidget = RegisterShop();
                    Navigator.of(context).pop();
                  });
                },
                icon: Icon(Icons.check_box_outline_blank),
                label: Text('Shop'),
              ),
            ],
          ),
        ),
        Container(
          width: 150.0,
          child: Row(
            children: <Widget>[
              FlatButton.icon(
                onPressed: () {
                  setState(() {
                    cuttentWidget = RegisterDelivery();
                    Navigator.of(context).pop();
                  });
                },
                icon: Icon(Icons.check_box_outline_blank),
                label: Text('Delivery'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> chooseRegister() async {
    showDialog(
      context: context,
      builder: (value) => AlertDialog(
        title: Text('ChooseRegister Type'),
        content: showButtom(),
      ),
    );
  }

  Widget menuHome() {
    return ListTile(
      leading: Icon(Icons.home),
      title: Text('Home'),
      subtitle: Text('Show List Shop'),
      onTap: () {
        setState(() {
          Navigator.of(context).pop();
          cuttentWidget = MainHome();
        });
      },
    );
  }

  Widget showLogo() {
    return Container(
      height: 80.0,
      child: Image.asset('images/logo.png'),
    );
  }

  Widget showHead() {
    return UserAccountsDrawerHeader(
      currentAccountPicture: showLogo(),
      accountName: Text('Guest'),
      accountEmail: Text('Login'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: showDrawer(),
      appBar: AppBar(),
      body: cuttentWidget,
    );
  }
}
