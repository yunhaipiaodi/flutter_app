import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingPage extends StatefulWidget{
  @override
  SettingPageState createState() => SettingPageState();
}

class SettingPageState extends State<SettingPage>{

  Future _StoreLoginState(bool loginState) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("hasLogin", loginState);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: (){
              Navigator.pop(context);
            }
        ),
        title: Text("设置"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon:Icon(Icons.more_vert),
            onPressed: (){

            },
          ),
        ],
      ),

      body: Column(
        children: <Widget>[
          GestureDetector(
            child:Container(
              child: Row(
                children: <Widget>[
                  Text("退出登陆"),
                  Icon(Icons.navigate_next,color: Colors.grey,),
                ],
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              ),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.grey,width: 1.0),
                ),
              ),
              margin: EdgeInsets.only(left: 16.0),
              padding: EdgeInsets.only(top:16.0,bottom: 16.0),
            ),
            onTap: (){
              _StoreLoginState(false).then((result){
                Navigator.pop(context);
              });
            },
          ),


        ],
      ),
    );
  }

}