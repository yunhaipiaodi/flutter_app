import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/mainPage/MainPage.dart';
import 'dart:async';

class LoadingPage extends StatelessWidget{

  LoadingPage(){
    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  _delayTrans(BuildContext context) async{
    await Future.delayed(const Duration(microseconds: 2000));
    Navigator.pushNamed(context,
        '/home');
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    print("LoadingPage build");
    _delayTrans(context);
    return Image.asset("images/loading.png",
            fit: BoxFit.fill,);

  /*  return RaisedButton(
      onPressed: (){
        Navigator.pushNamed(context,
            '/home');
      },
      child: Text("跳转"),
    );*/

  }



}