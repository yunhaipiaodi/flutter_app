import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/tools/UrlManage.dart';
import 'package:http/http.dart' as http;
import 'package:convert/convert.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddAddressPage extends StatefulWidget{
  @override
  AddAddressState createState() => AddAddressState();
}

class AddAddressState extends State<AddAddressPage>{

  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String _address = "";
  String _phone = "";
  String _name = "";

  List<Widget> _showTypeTags(List<String> tagList){
    List<Widget> widgets = List();
    tagList.forEach((String tag){
      widgets.add(_getTypeTagItem(tag,true));
    });
    return widgets;
  }

  Future<Map<String,dynamic>> _getLocalUserData() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int userId = await prefs.getInt("userId");
    String userName = await prefs.getString("userName");
    return{
      "userId":userId,
      "userName":userName
    };
  }

  Future<bool> _commitData (int userId,String userName,String phone,String address,int address_type_id) async{
    String url = addAddressUrl();
    Map postData = {
      "user_id":userId.toString(),
      "address":address,
      "phone":phone,
      "user_name":userName,
      "address_type_id":address_type_id.toString(),
    };
    var response = await http.post(url,body: postData);
    if(response.statusCode == 200){
      return true;
    }else{
      print("commmit data error:" + response.statusCode.toString());
      return false;
    }
  }

  List<String> tags = ["家","公司","学校"];

  Future<List<dynamic>> _getAddressType() async{
    String url = getAddressTypeUrl();
    var response = await http.get(url);
    if(response.statusCode == 200){
      List maps = json.decode(response.body);
      return maps;
    }else{
      throw Exception("getAddressType net error!");
    }
  }

  //create search tag
  Widget _getTypeTagItem(String foodName,bool highLight){
    return GestureDetector(
      onTap: (){

      },
      child: Container(
        height: 20.0,
        child: Text(foodName,style: TextStyle(color: highLight?Colors.white:Colors.black),),
        decoration: BoxDecoration(
            color: highLight?Colors.blue:Color.fromARGB(255, 246, 246,246),
            borderRadius: BorderRadius.all(Radius.circular(10.0))
        ),
        padding: EdgeInsets.only(left: 10.0,right: 10.0),
        margin: EdgeInsets.only(right: 8.0,top:8.0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      key:scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: (){
              Navigator.pop(context);
            }
        ),
        title: Text("添加地址"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[

                Theme(
                  data: ThemeData(
                    hintColor: Colors.blue,
                  ),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "输入联系人名字",
                      hintStyle: TextStyle(color: Colors.blue),
                    ),
                    validator: (String value){
                      _name = value;
                      if(value.isEmpty){
                        return "名字不能为空";
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
                      hintText: "输入手机号码",
                      hintStyle: TextStyle(color: Colors.blue),
                    ),
                    validator: (String value){
                      _phone = value;
                      //validate phone number input is right
                      RegExp regExp = RegExp('^((13[0-9])|(14[5|7])|(15([0-3]|[5-9]))|(18[0,5-9]))\\d{8}\$');
                      bool hasMatch= regExp.hasMatch(value);
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
                      hintText: "输入详细地址",
                      hintStyle: TextStyle(color: Colors.blue),
                    ),
                    validator: (String value){
                      _address = value;
                      //validate phone number input is right
                      if(value.length == 0){
                        return "地址不能为空";
                      }
                    },
                  ),
                ),

                Container(
                  child: Text("所属标签"),
                  margin: const EdgeInsets.only(top:16.0),
                ),

                FutureBuilder(
                  future: _getAddressType(),
                  builder: (BuildContext context,AsyncSnapshot snapShot){
                    List<String> tags = List();
                    if(snapShot.connectionState == ConnectionState.done){
                      if(snapShot.hasData){
                        List<dynamic> maps = snapShot.data;
                        maps.forEach((map){
                          AddressType addressType = AddressType.fromJson(map);
                          tags.add(addressType.type_name);
                        });
                      }
                      return Wrap(
                        children: _showTypeTags(tags),
                      );
                    }else{
                      return Wrap();
                    }
                  },
                ),

                Container(
                  child:  RaisedButton(
                    color:Colors.blue,
                    child: Row(
                      children: <Widget>[
                        Text("创建地址",style: TextStyle(fontSize: 18.0,color: Colors.white),),
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                    onPressed: (){
                      if(_formKey.currentState.validate()){
                        _getLocalUserData().then((Map<String,dynamic> map){
                          int userId = map["userId"];
                          _commitData(userId,_name, _phone, _address, 1).then((bool result){
                            if(result){
                              Navigator.pop(context);
                            }else{
                              scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("提交失败")));
                            }
                          });
                        });
                      }
                    },
                  ),
                  margin: EdgeInsets.only(top:32.0,),
                ),
              ],
              crossAxisAlignment: CrossAxisAlignment.start,
            ),
          ),
          margin: const EdgeInsets.only(left: 16.0,right: 16.0,top:16.0),
        ),
      )
    );
  }

}

class AddressType{
  int id;
  String type_name;

  AddressType(@required this.id,@required this.type_name);

  AddressType.fromJson(Map<String,dynamic> map):
      id = int.parse(map["id"]),
      type_name = map["type_name"];
}