import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/mainPage/MainPage.dart';
import 'dart:async';

import 'package:flutter_app/tools/SqfliteHelp.dart';

class LoadingPage extends StatelessWidget{

  LoadingPage(){
    SystemChrome.setEnabledSystemUIOverlays([]);
  }


  Future<bool> _initStorage() async{
    return SqfliteHelp.init().then((bool result) async{
      String createTableSql = "CREATE TABLE IF NOT EXISTS SEARCH_HISTORY("
          "ID INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,"
          "SEARCH_KEYWORD VARCHAR(30),"
          "CREATE_TIME DATETIME"
          ")";
     await SqfliteHelp.createTable(createTableSql);
     return true;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    _initStorage().then((result){
      Navigator.pushNamed(context,
          '/home');
    });
    return Image.asset("images/loading.png",
            fit: BoxFit.fill,);

  }



}