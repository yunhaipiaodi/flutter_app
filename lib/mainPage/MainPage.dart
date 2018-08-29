import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/bottomTabPage/Home.dart';
import 'package:flutter_app/bottomTabPage/Mine.dart';
import 'package:flutter_app/bottomTabPage/Orders.dart';


//这是一个主页
class MainPage extends StatefulWidget {

  MainPage(){
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
  }

  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage>{
  int _currentPageIndex = 0;
  var _currentPage;

  List<Widget> _bottomPages = [
    Home(),
    Orders(),
    Mine(),
  ];



  @override
  void initState(){
    super.initState();
    _currentPage = _bottomPages[_currentPageIndex];
  }

  @override
  Widget build(BuildContext context) {
    // ignore: non_type_as_type_argument
    List<BottomNavigationBarItem> bottomItems = [
      BottomNavigationBarItem(icon:Icon(Icons.home),title: Text('首页'),),
      BottomNavigationBarItem(icon:Icon(Icons.assignment),title: Text('订单'),),
      BottomNavigationBarItem(icon:Icon(Icons.person),title: Text('我的'),),
    ];
      return WillPopScope(child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          items: bottomItems,
          currentIndex: _currentPageIndex,
          onTap: (index) {
            setState(() {
              _currentPageIndex = index;
              _currentPage = _bottomPages[_currentPageIndex];
            });
          },
        ),
        body: _currentPage,
      ), onWillPop: (){
        exit(0);
        return Future(()=>false);
      });
  }

}

