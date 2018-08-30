import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget{
  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<LoginPage>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title:Text("用户登入"),
        centerTitle: true,
        leading: IconButton(
        icon: Icon(Icons.arrow_back,color: Colors.white,),
        onPressed: (){
          Navigator.pop(context);
        },
        ),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
              Container(
                child: Row(
                  children: <Widget>[
                    Icon(Icons.person,color: Colors.blue,),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration.collapsed(
                          hintText: "输入手机号码",
                          border: InputBorder.none,
                          hintStyle: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                        color: Colors.blue,
                        width: 1.0,
                      ),
                  ),
                ),
                padding: EdgeInsets.only(top: 8.0,bottom: 8.0),
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    Icon(Icons.lock,color: Colors.blue,),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration.collapsed(
                          hintText: "输入密码",
                          border: InputBorder.none,
                          hintStyle: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color:  Colors.blue,
                      width: 1.0,
                    ),
                  ),
                ),
                padding: EdgeInsets.only(top: 8.0,bottom: 8.0),
              ),

              Container(
                child: RaisedButton(
                  color: Colors.blue,
                  onPressed: (){

                  },
                  child: Row(
                    children: <Widget>[
                      Text(
                        "登陆",
                        style: TextStyle(
                          color:Colors.white,
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                ),
                margin: EdgeInsets.only(top:16.0),
              ),
          ],
        ),
        margin: EdgeInsets.only(left: 16.0,top:32.0,right: 16.0,bottom: 16.0),
      ),
    );
  }

}