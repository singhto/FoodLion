import 'package:flutter/material.dart';
import 'package:foodlion/utility/my_style.dart';

class OrderShop extends StatefulWidget {
  @override
  _OrderShopState createState() => _OrderShopState();
}

class _OrderShopState extends State<OrderShop> {
  // Field

  // Method
  Widget waitOrder() {
    return Container(alignment: Alignment(0, -0.6),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.7,
        child: Card(
          color: MyStyle().primaryColor,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              MyStyle().mySizeBox(),
              Container(
                width: MediaQuery.of(context).size.width * 0.3,
                child: Image.asset('images/wait2.png'),
              ),
              MyStyle().mySizeBox(),
              Text(
                'โปรดรอ สักครู่คะ ยังไม่มี รายการสั่ง',
                style: MyStyle().h2StyleWhite,
              ),
              MyStyle().mySizeBox(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return waitOrder();
  }
}
