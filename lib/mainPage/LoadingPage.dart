import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/mainPage/MainPage.dart';
import 'dart:async';

class LoadingPage extends StatelessWidget{
  Timer _timer;

  LoadingPage(){
    SystemChrome.setEnabledSystemUIOverlays([]);

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    _timer = Timer(const Duration(milliseconds: 2000),(){
      Navigator.pushNamed(context,
          '/home');
    });
    return Image.asset("images/loading.png",
            fit: BoxFit.fill,);
  }

  @override
  void dispose(){
    _timer.cancel();
  }

}