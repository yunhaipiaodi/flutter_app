import 'package:flutter/material.dart';
import 'package:flutter_app/mainPage/AddAddressPage.dart';
import 'package:flutter_app/mainPage/AddressListPage.dart';
import 'package:flutter_app/mainPage/CommendPage.dart';
import 'package:flutter_app/mainPage/LoginPage.dart';
import 'package:flutter_app/mainPage/MainPage.dart';
import 'package:flutter_app/mainPage/OrderDetailPage.dart';
import 'package:flutter_app/mainPage/OrderSuccess.dart';
import 'package:flutter_app/mainPage/SearchPage.dart';
import 'package:flutter_app/mainPage/SettingPage.dart';
import 'package:flutter_app/mainPage/SignUpPage.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "味之道",
      initialRoute:'/',
      routes: {
        '/':(context) => MainPage(),        //首页
        '/search':(context)=>SearchPage(),      //搜索页
        '/login':(context) => LoginPage(),           //登陆页
        '/sign_up':(context) => SignUpPage(),      //注册页
        '/setting':(context) => SettingPage(),      //设置页
        '/order_detail':(context) => OrderDetailPage(0,"","",""),      //下单页
        '/address_list':(context) => AddressListPage(),      //地址管理页
        '/add_address':(context) => AddAddressPage(),      //添加地址
        '/order_success':(context) => OrderSuccess(),     //订购成功
        '/commend':(context) => CommendPage(0),     //评论
      },
    );
  }
}








