import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/tools/UrlManage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class CommendPage extends StatefulWidget{
  int cuisineId = 0;

  CommendPage(this.cuisineId);

  @override
  CommendState createState() => CommendState();


}

class CommendState extends State<CommendPage>{

  int _currentStep = 0;
  bool _isGoodCommend = true;
  bool _isGood = true;
  String _commendContent = "";

  GlobalKey<ScaffoldState> _scaffoldState = GlobalKey();

  Future<bool> _addCommend(int cuisineId,int thumbUp,int isGoodCommend,String commendContent) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    int userId = await sharedPreferences.getInt("userId");
    String url = addCommendUrl();
    Map postData = {
      "user_id":userId.toString(),
      "cuisine_id":cuisineId.toString(),
      "commend_content":commendContent,
      "thumb_up":thumbUp.toString(),
      "is_good_commend":isGoodCommend.toString(),
    };
    var response = await http.post(url,body: postData);
    if(response.statusCode == 200){
      return true;
    }else{
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return Scaffold(
      key:_scaffoldState,
      appBar: AppBar(
        title:Text("评论"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,color: Colors.white,),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
      body: Stepper(
        steps: [
          Step(
              title: Text("请选择好评还是差评"),
              content: Row(
                children: <Widget>[
                  GestureDetector(
                    child:Container(
                      child: Text("差评",style: TextStyle(color: _isGoodCommend?Colors.black:Colors.blue),),
                      padding: EdgeInsets.all(16.0),
                    ),
                    onTap: (){
                      setState(() {
                        _isGoodCommend = false;
                      });
                    },
                  ),
                  Switch(value: _isGoodCommend, onChanged: (bool value){
                      setState(() {
                        _isGoodCommend = value;
                      });
                  }),
                  GestureDetector(
                    child:Container(
                      child: Text("好评",style: TextStyle(color: _isGoodCommend?Colors.blue:Colors.black),),
                      padding: EdgeInsets.all(16.0),
                    ),
                    onTap: (){
                      setState(() {
                        _isGoodCommend = true;
                      });
                    },
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
          ),
          Step(
            title: Text("点赞"),
            content: Row(
              children: <Widget>[
                GestureDetector(
                  child:Container(
                    child: Text("不点赞",style: TextStyle(color: _isGood?Colors.black:Colors.blue),),
                    padding: EdgeInsets.all(16.0),
                  ),
                  onTap: (){
                    setState(() {
                      _isGood = false;
                    });
                  },
                ),
                Switch(value: _isGood, onChanged: (bool value){
                  setState(() {
                    _isGood = value;
                  });
                }),
                GestureDetector(
                  child:Container(
                    child: Text("点赞",style: TextStyle(color: _isGood?Colors.blue:Colors.black),),
                    padding: EdgeInsets.all(16.0),
                  ),
                  onTap: (){
                    setState(() {
                      _isGood = true;
                    });
                  },
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ),
          Step(
              title: Text("评论"),
              content: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                onChanged: (value){
                  _commendContent = value;
                },
              ),
          ),
        ],
        currentStep: _currentStep,
        onStepContinue: (){
          setState(() {
            if(_currentStep < 2){
              _currentStep++;
            }else if(_currentStep == 2){
              //submit commend
              int thumbUp = _isGood?0:1;    //0，点赞；1不点赞
              int isGoodCommend = _isGoodCommend?0:1;   //0，好评；1差评
              _addCommend(widget.cuisineId,thumbUp,isGoodCommend,_commendContent).then((bool result){
                  if(result){
                    Navigator.pop(context);
                  }else{
                    _scaffoldState.currentState.showSnackBar(SnackBar(content: Text("添加评论失败")));
                  }
              });
            }
          });
        },
        onStepCancel: (){
          setState(() {
            if(_currentStep > 0){
              _currentStep--;
            }
          });
        },
      ),
    );
  }

}