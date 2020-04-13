import 'package:flutter/material.dart';
import 'package:foodlion/widget/add_my_food.dart';
import 'package:foodlion/widget/main_home.dart';
import 'package:foodlion/widget/my_food.dart';
import 'package:foodlion/widget/order_shop.dart';
import 'package:foodlion/widget/register_delivery.dart';
import 'package:foodlion/widget/register_shop.dart';
import 'package:foodlion/widget/register_user.dart';
import 'package:foodlion/widget/signin_delivery.dart';
import 'package:foodlion/widget/signin_shop.dart';
import 'package:foodlion/widget/signin_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utility/my_style.dart';

class Home extends StatefulWidget {
  final Widget currentWidget;
  Home({Key key, this.currentWidget}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Field
  Widget cuttentWidget = MainHome();
  String nameLogin, avatar;
  bool statusLogin = false; //false => no login

  // Method
  @override
  void initState() {
    super.initState();
    checkWidget();
    checkLogin();
  }

  void checkWidget() {
    Widget myWidget = widget.currentWidget;
    if (myWidget != null) {
      setState(() {
        cuttentWidget = myWidget;
      });
    }
  }

  Future<void> checkLogin() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      nameLogin = preferences.getString('Name');
      avatar = preferences.getString('UrlShop');
      print('nameLogin = $nameLogin, avatar = $avatar');

      if (!(nameLogin == null || nameLogin.isEmpty)) {
        setState(() {
          statusLogin = true;
          cuttentWidget = OrderShop();
        });
      }
    } catch (e) {}
  }

  Widget showDrawer() {
    return Drawer(
      child: statusLogin ? shopList() : generalList(),
    );
  }

  ListView generalList() {
    return ListView(
      children: <Widget>[
        showHead(),
        menuHome(),
        menuSignIn(),
        menuSignUp(),
      ],
    );
  }

  ListView shopList() {
    return ListView(
      children: <Widget>[
        showHead(),
        menuOrderShop(),
        menuMyFood(),
        menuAddMyFood(),
        menuSignOut(),
      ],
    );
  }

  Widget menuMyFood() {
    return ListTile(
      leading: Icon(
        Icons.restaurant_menu,
        size: 36.0,
        color: MyStyle().dartColor,
      ),
      title: Text(
        'รายการอาหาร',
        style: MyStyle().h2Style,
      ),
      subtitle: Text(
        'เมนูอาหารของฉัน',
        style: MyStyle().h3StylePrimary,
      ),
      onTap: () {
        Navigator.of(context).pop();
        setState(() {
          cuttentWidget = MyFood();
        });
      },
    );
  }

  Widget menuAddMyFood() {
    return ListTile(
      leading: Icon(
        Icons.playlist_add,
        size: 36.0,
        color: MyStyle().dartColor,
      ),
      title: Text(
        'เพิ่ม รายการ อาหาร',
        style: MyStyle().h2Style,
      ),
      subtitle: Text(
        'เพิ่มข้อมูลรายการอาหารของฉัน',
        style: MyStyle().h3StylePrimary,
      ),
      onTap: () {
        Navigator.of(context).pop();
        setState(() {
          cuttentWidget = AddMyFood();
        });
      },
    );
  }

  Widget menu() {
    return ListTile(
      leading: Icon(
        Icons.android,
        size: 36.0,
        color: MyStyle().dartColor,
      ),
      title: Text(
        'text',
        style: MyStyle().h2Style,
      ),
      subtitle: Text(
        'sub text',
        style: MyStyle().h3StylePrimary,
      ),
      onTap: () {
        Navigator.of(context).pop();
      },
    );
  }

  Widget menuOrderShop() {
    return ListTile(
      leading: Icon(
        Icons.playlist_add_check,
        size: 36.0,
        color: MyStyle().dartColor,
      ),
      title: Text(
        'รายการอาหาร ที่ลูกค้าสั่ง',
        style: MyStyle().h2Style,
      ),
      subtitle: Text(
        'รายการอาหาร ที่ลูกค้าสั่งมา แสดงสถานะ',
        style: MyStyle().h3StylePrimary,
      ),
      onTap: () {
        Navigator.of(context).pop();
        setState(() {
          cuttentWidget = OrderShop();
        });
      },
    );
  }

  Widget menuSignOut() {
    return ListTile(
      leading: Icon(
        Icons.exit_to_app,
        color: MyStyle().dartColor,
        size: 36.0,
      ),
      title: Text(
        'ออกจากระบบ',
        style: MyStyle().h2Style,
      ),
      subtitle: Text(
        'กดที่นี่ เพื่อออกจากระบบ',
        style: MyStyle().h3StylePrimary,
      ),
      onTap: () {
        Navigator.of(context).pop();
        signOutProcess();
      },
    );
  }

  Future<void> signOutProcess() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.clear();

      MaterialPageRoute route = MaterialPageRoute(builder: (value) => Home());
      Navigator.of(context).pushAndRemoveUntil(route, (value) => false);
    } catch (e) {}
  }

  Widget menuSignUp() {
    return ListTile(
      leading: iconSignUp(),
      title: Text(
        'สมัครใช้บริการ',
        style: MyStyle().h2Style,
      ),
      subtitle: Text(
        'คลิกเพื่อ สมัครใช้บริการ',
        style: MyStyle().h3StylePrimary,
      ),
      onTap: () {
        Navigator.of(context).pop();
        chooseRegister('Register', true);
      },
    );
  }

  Icon iconSignUp() {
    return Icon(
      Icons.system_update,
      size: 36,
      color: MyStyle().dartColor,
    );
  }

  Widget menuSignIn() {
    return ListTile(
      leading: iconSignIn(),
      title: Text(
        'เข้าสู่ระบบ',
        style: MyStyle().h2Style,
      ),
      subtitle: Text(
        'กรุณาเข้าสู่ระบบก่อน',
        style: MyStyle().h3StylePrimary,
      ),
      onTap: () {
        Navigator.of(context).pop();
        chooseRegister('Login', false);
      },
    );
  }

  Icon iconSignIn() {
    return Icon(
      Icons.fingerprint,
      size: 36.0,
      color: MyStyle().dartColor,
    );
  }

  Widget showButtom(bool registerBool) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: 150.0,
          child: Row(
            children: <Widget>[
              FlatButton.icon(
                onPressed: () {
                  if (registerBool) {
                    setState(() {
                      cuttentWidget = RegisterUser();
                    });
                  } else {
                    setState(() {
                      cuttentWidget = SingInUser();
                    });
                  }
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  Icons.touch_app,
                  color: MyStyle().primaryColor,
                ),
                label: Text(
                  'เพื่อสั่งอาหาร',
                  style: MyStyle().h2StylePrimary,
                ),
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
                  if (registerBool) {
                    setState(() {
                      cuttentWidget = RegisterShop();
                    });
                  } else {
                    setState(() {
                      cuttentWidget = SignInshop();
                    });
                  }
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  Icons.fastfood,
                  color: MyStyle().primaryColor,
                ),
                label: Text(
                  'เพื่อขายอาหาร',
                  style: MyStyle().h2StylePrimary,
                ),
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
                  if (registerBool) {
                    setState(() {
                      cuttentWidget = RegisterDelivery();
                    });
                  } else {
                    setState(() {
                      cuttentWidget = SignDelivery();
                    });
                  }
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  Icons.directions_bike,
                  color: MyStyle().primaryColor,
                ),
                label: Text(
                  'เพื่อส่งอาหาร',
                  style: MyStyle().h2StylePrimary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> chooseRegister(String title, bool registerBool) async {
    showDialog(
      context: context,
      builder: (value) => AlertDialog(
        title: ListTile(
          leading: iconSignUp(),
          title: Text(
            '$title Type',
            style: MyStyle().h1Style,
          ),
        ),
        content: showButtom(registerBool),
        actions: <Widget>[
          FlatButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'Cancel',
              style: MyStyle().h2Style,
            ),
          ),
        ],
      ),
    );
  }

  Widget menuHome() {
    return ListTile(
      leading: Icon(
        Icons.fastfood,
        size: 36.0,
        color: MyStyle().dartColor,
      ),
      title: Text(
        'หน้าแรก',
        style: MyStyle().h2Style,
      ),
      subtitle: Text(
        'วันนี้กินอะไรดี',
        style: MyStyle().h3StylePrimary,
      ),
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
      width: 80.0,
      child: Image.asset('images/logo_1024.png'),
    );
  }

  Widget showHead() {
    return UserAccountsDrawerHeader(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('images/bic2.png'), fit: BoxFit.cover),
      ),
      currentAccountPicture: avatar == null ? showLogo() : showAvatar(),
      accountName: statusLogin
          ? Text(
              nameLogin,
              style: MyStyle().h2StyleWhite,
            )
          : Text(
              'Guest',
              style: MyStyle().h2StyleWhite,
            ),
      accountEmail: Text('Login'),
    );
  }

  Widget showAvatar() => CircleAvatar(
        backgroundImage: NetworkImage(avatar),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: showDrawer(),
      appBar: AppBar(
        title: Text(
          'Send',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: cuttentWidget,
    );
  }
}
