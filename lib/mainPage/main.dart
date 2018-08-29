import 'package:flutter/material.dart';
import 'package:flutter_app/mainPage/DetailPage.dart';
import 'package:flutter_app/mainPage/LoadingPage.dart';
import 'package:flutter_app/mainPage/MainPage.dart';
import 'package:flutter_app/mainPage/SearchPage.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      initialRoute:'/',
      routes: {
        '/loading':(context) => LoadingPage(),         //加载页
        '/home':(context) => MainPage(),        //首页
        '/search':(context)=>SearchPage(),      //搜索页
        '/':(context)=>DetailPage(),
      },
    );
  }
}








