import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget{
  @override
  SignUpState createState() => SignUpState();
}

class SignUpState extends State<SignUpPage>{

  final _formKey = GlobalKey<FormState>();

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
                    child: TextFormField(
                        decoration: InputDecoration(
                          hintText: "输入账号",
                          fillColor: Colors.white,
                          filled: true,
                          contentPadding: EdgeInsets.only(left: 16.0,top: 8.0,right: 16.0,bottom: 8.0),
                          border:InputBorder.none,
                          hintStyle: TextStyle(color: Colors.lightBlue),
                        ),
                      style:TextStyle(color: Colors.blue),
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color:Colors.blue,width: 1.0),
                    ),
                    margin: EdgeInsets.only(top: 4.0),
                  ),

                  //password
                  Container(
                    child:Text("密码",style: TextStyle(color: Colors.blue),),
                    margin: EdgeInsets.only(top: 16.0),
                  ),
                  Container(
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: "输入密码",
                        fillColor: Colors.white,
                        filled: true,
                        contentPadding: EdgeInsets.only(left: 16.0,top: 8.0,right: 16.0,bottom: 8.0),
                        border:InputBorder.none,
                        hintStyle: TextStyle(color: Colors.lightBlue),
                      ),
                      style:TextStyle(color: Colors.blue),
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color:Colors.blue,width: 1.0),
                    ),
                    margin: EdgeInsets.only(top: 4.0),
                  ),

                  //confirm password
                  Container(
                    child:Text("确认密码",style: TextStyle(color: Colors.blue),),
                    margin: EdgeInsets.only(top: 16.0),
                  ),
                  Container(
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: "再次输入密码",
                        fillColor: Colors.white,
                        filled: true,
                        contentPadding: EdgeInsets.only(left: 16.0,top: 8.0,right: 16.0,bottom: 8.0),
                        border:InputBorder.none,
                        hintStyle: TextStyle(color:Colors.lightBlue),
                      ),
                      style:TextStyle(color: Colors.blue),
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color:Colors.blue,width: 1.0),
                    ),
                    margin: EdgeInsets.only(top: 4.0),
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