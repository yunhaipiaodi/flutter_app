import 'package:flutter/material.dart';
import 'package:flutter_app/mainPage/LoadingPage.dart';
import 'package:flutter_app/mainPage/LoginPage.dart';
import 'package:flutter_app/mainPage/MainPage.dart';
import 'package:flutter_app/mainPage/OrderDetailPage.dart';
import 'package:flutter_app/mainPage/SearchPage.dart';
import 'package:flutter_app/mainPage/SettingPage.dart';
import 'package:flutter_app/mainPage/SignUpPage.dart';
import 'package:flutter_app/mainPage/OrderDetailPage.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      initialRoute:'/',
      routes: {
        '/loading':(context) => LoadingPage(),         //加载页
        '/':(context) => MainPage(),        //首页
        '/search':(context)=>SearchPage(),      //搜索页
        '/login':(context) => LoginPage(),           //登陆页
        '/sign_up':(context) => SignUpPage(),      //注册页
        '/setting':(context) => SettingPage(),      //设置页
        '/order_detail':(context) => OrderDetailPage(),      //设置页
      },
    );
  }
}








