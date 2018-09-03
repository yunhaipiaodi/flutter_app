import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginPage extends StatefulWidget{
  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<LoginPage>{
  final _formKey = GlobalKey<FormState>();
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
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Theme(
                    data: ThemeData(
                        hintColor: Colors.blue,
                    ),
                    child:TextFormField(
                      decoration: InputDecoration(
                        hintText: "输入手机号",
                        hintStyle: TextStyle(color: Colors.blue),
                        icon: Icon(Icons.person,color: Colors.blue,),
                      ),
                      validator: (phone){
                          //validate phone number input is right
                          RegExp regExp = RegExp('^((13[0-9])|(14[5|7])|(15([0-3]|[5-9]))|(18[0,5-9]))\\d{8}\$');
                          bool hasMatch= regExp.hasMatch(phone);
                          if(!hasMatch){
                            return "请输入正确的手机号码";
                          }

                      },
                    ),
                  ),

                  Theme(
                    data: ThemeData(
                      hintColor: Colors.blue,
                    ),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: "输入密码",
                        hintStyle: TextStyle(color: Colors.blue),
                        icon: Icon(Icons.lock,color: Colors.blue,),
                      ),
                      obscureText: true,
                      validator: (value){
                        if(value.length < 8){
                          return '密码不能小于8位!';
                        }
                      },
                    ),
                  ),


                  Container(
                    child: RaisedButton(
                      color: Colors.blue,
                      onPressed: (){
                        if(_formKey.currentState.validate()){
                          Scaffold.of(context)
                              .showSnackBar(SnackBar(content: Text("提交数据成功")));
                        }
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
            ),

            Container(
              child: Row(
                children: <Widget>[
                  Container(
                    child:IconButton(icon: Icon(FontAwesomeIcons.qq,color: Colors.blue,),onPressed: null,),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue,width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(32.0))
                    ),
                  ),

                  Container(
                    child:IconButton(icon: Icon(FontAwesomeIcons.weixin,color: Colors.blue,),onPressed: null,),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue,width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(32.0))
                    ),
                  ),
                  Container(
                    child:IconButton(icon: Icon(FontAwesomeIcons.weibo,color: Colors.blue,),onPressed: null,),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue,width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(32.0))
                    ),
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              ),
              margin: EdgeInsets.only(top:16.0),
            ),

            Container(
              child:GestureDetector(
                child: Text(
                  "还没有账号?",
                  style: TextStyle(
                    color: Colors.green,
                    decoration: TextDecoration.underline,
                  ),
                ),
                onTap: (){
                  Navigator.pushNamed(context, "/sign_up");
                },
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