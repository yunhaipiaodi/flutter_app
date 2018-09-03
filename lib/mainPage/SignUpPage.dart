import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget{
  @override
  SignUpState createState() => SignUpState();
}

class SignUpState extends State<SignUpPage>{

  final _formKey = GlobalKey<FormState>();
  String firstPwd = "";

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title:Text("用户注册"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,color: Colors.white,),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        color: Color.fromARGB(255, 238, 238, 238),
        child: Container(
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  //account
                  Text("账号",style: TextStyle(color: Colors.blue),),
                  Container(
                    child: Theme(
                      data: ThemeData(
                        hintColor: Colors.blue,
                      ),
                      child:TextFormField(
                        decoration: InputDecoration(
                          hintText: "输入手机号",
                          hintStyle: TextStyle(color:Color.fromARGB(255, 145, 167, 255)),
                          border: OutlineInputBorder(),
                          fillColor: Colors.white,
                          filled: true,
                        ),
                        validator: (phone){
                          //validate phone number input is right
                          RegExp regExp = RegExp('^((13[0-9])|(14[5|7])|(15([0-3]|[5-9]))|(18[0,5-9]))\\d{8}\$');
                          bool hasMatch= regExp.hasMatch(phone);
                          if(!hasMatch){
                            return "请输入正确的手机号码";
                          }
                        },
                       onFieldSubmitted: (String value){
                          print(value);
                       },
                      ),
                    ),
                    margin: EdgeInsets.only(top: 8.0),
                  ),


                  //password
                  Container(
                    child:Text("密码",style: TextStyle(color: Colors.blue),),
                    margin: EdgeInsets.only(top: 16.0),
                  ),
                  Container(
                    child: Theme(
                      data: ThemeData(
                        hintColor: Colors.blue,
                      ),
                      child:TextFormField(
                        decoration: InputDecoration(
                          hintText: "输入密码",
                          hintStyle: TextStyle(color:Color.fromARGB(255, 145, 167, 255)),
                          border: OutlineInputBorder(),
                          fillColor: Colors.white,
                          filled: true,
                        ),
                        validator: (val){
                          //validate phone number input is right
                          String password = val;
                          if(val.length <8){
                            return "密码必须8位以上!";
                          }
                        },
                      ),
                    ),
                    margin: EdgeInsets.only(top: 8.0),
                  ),

                  //confirm password
                  Container(
                    child:Text("确认密码",style: TextStyle(color: Colors.blue),),
                    margin: EdgeInsets.only(top: 16.0),
                  ),
                  Container(
                    child: Theme(
                      data: ThemeData(
                        hintColor: Colors.blue,
                      ),
                      child:TextFormField(
                        decoration: InputDecoration(
                          hintText: "确认密码",
                          hintStyle: TextStyle(color:Color.fromARGB(255, 145, 167, 255)),
                          border: OutlineInputBorder(),
                          fillColor: Colors.white,
                          filled: true,
                        ),
                        validator: (val){
                          //validate phone number input is right
                          String password = val;
                          if(val.length <8){
                            return "密码必须8位以上!";
                          }
                        },
                      ),
                    ),
                    margin: EdgeInsets.only(top: 8.0),
                  ),

                  Container(
                    child: RaisedButton(
                      color: Colors.blue,
                      onPressed: (){

                      },
                      child: Row(
                        children: <Widget>[
                          Text(
                            "注册",
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
                crossAxisAlignment: CrossAxisAlignment.start,
              ),
            ),
            margin: EdgeInsets.only(left: 16.0,top:32.0,right: 16.0,bottom: 16.0),
        ),
      )

    );
  }

}