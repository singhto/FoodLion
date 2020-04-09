import 'package:flutter/material.dart';
import 'package:foodlion/widget/add_my_food.dart';
import 'package:foodlion/widget/main_home.dart';
import 'package:foodlion/widget/my_food.dart';
import 'package:foodlion/widget/register_delivery.dart';
import 'package:foodlion/widget/register_shop.dart';
import 'package:foodlion/widget/register_user.dart';
import 'package:foodlion/widget/signin_delivery.dart';
import 'package:foodlion/widget/signin_shop.dart';
import 'package:foodlion/widget/signin_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  void checkWidget(){
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
        menuHome(),
        menuMyFood(),
        menuAddMyFood(),
        menuSignOut(),
      ],
    );
  }

  Widget menuMyFood() {
    return ListTile(
      leading: Icon(Icons.fastfood),
      title: Text('รายการอาหาร',style: TextStyle(fontSize: 20.0),),
      subtitle: Text('เมนูอาหารของฉัน',style: TextStyle(fontSize: 16.0),),
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
      leading: Icon(Icons.add),
      title: Text('เพิ่ม รายการ อาหาร',style: TextStyle(fontSize: 20.0),),
      subtitle: Text('เพิ่มข้อมูลรายการอาหารของฉัน',style: TextStyle(fontSize: 16.0),),
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
      leading: Icon(Icons.android),
      title: Text('text'),
      subtitle: Text('sub text'),
      onTap: () {
        Navigator.of(context).pop();
      },
    );
  }

    Widget menuSignOut() {
    return ListTile(
      leading: Icon(Icons.exit_to_app, color: Colors.red,),
      title: Text('ออกจากระบบ', style: TextStyle(color: Colors.red),),
      subtitle: Text('กดที่นี่ เพื่อออกจากระบบ',style: TextStyle(color: Colors.red.shade400),),
      onTap: () {
        Navigator.of(context).pop();
        signOutProcess();
      },
    );
  }

  Future<void> signOutProcess()async{
    try {

      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.clear();

      MaterialPageRoute route = MaterialPageRoute(builder: (value)=>Home());
      Navigator.of(context).pushAndRemoveUntil(route, (value)=>false);
      
    } catch (e) {
    }
  }

  Widget menuSignUp() {
    return ListTile(
      leading: Icon(Icons.android),
      title: Text('สมัครใช้บริการ'),
      subtitle: Text('สมัครใช้บริการ'),
      onTap: () {
        Navigator.of(context).pop();
        chooseRegister('Register', true);
      },
    );
  }

  Widget menuSignIn() {
    return ListTile(
      leading: Icon(Icons.fingerprint),
      title: Text('เข้าสู่ระบบ'),
      subtitle: Text('กรุณาเข้าสู่ระบบก่อน'),
      onTap: () {
        Navigator.of(context).pop();
        chooseRegister('Login', false);
      },
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
                icon: Icon(Icons.check_box_outline_blank),
                label: Text('สมัคร เพื่อสั่งอาหาร'),
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
                icon: Icon(Icons.check_box_outline_blank),
                label: Text('สมัคร เพื่อขายอาหาร'),
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
                icon: Icon(Icons.check_box_outline_blank),
                label: Text('สมัคร เพื่อส่งอาหาร'),
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
        title: Text('Choose $title Type'),
        content: showButtom(registerBool),
      ),
    );
  }

  Widget menuHome() {
    return ListTile(
      leading: Icon(Icons.home),
      title: Text('หน้าแรก',style: TextStyle(fontSize: 20.0),),
      subtitle: Text('วันนี้กินอะไรดี',style: TextStyle(fontSize: 16.0),),
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
      child: Image.asset('images/logo.png'),
    );
  }

  Widget showHead() {
    return UserAccountsDrawerHeader(
      currentAccountPicture: avatar == null ? showLogo() : showAvatar(),
      accountName: statusLogin ? Text(nameLogin) : Text('Guest'),
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
      appBar: AppBar(),
      body: cuttentWidget,
    );
  }
}
