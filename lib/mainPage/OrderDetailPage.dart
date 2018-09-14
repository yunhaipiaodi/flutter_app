import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/tools/UrlManage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class OrderDetailPage extends StatefulWidget{

  int cuisineId = 0;
  String cuisineImageUrl = "";
  String cuisineName = "";
  String cuisinePrice = "";

  OrderDetailPage(
      this.cuisineId,
      this.cuisineImageUrl,
      this.cuisineName,
      this.cuisinePrice,
      );

  @override
  OrderDetailState createState() => OrderDetailState();
}

class OrderDetailState extends State<OrderDetailPage>{

  int _selectValue = 0;

  //get address list data
  Future _getAddressList() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    int userId = sharedPreferences.getInt("userId");
    String url = getAddressListUrl(userId);
    var response = await http.get(url);
    if(response.statusCode == 200){
      return json.decode(response.body);
    }else{
      throw Exception("getAddressList error,code:" + response.statusCode.toString());
    }
  }

  //add order to web
  Future _addOrder(int cuisineId,int userId,int addressId,) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    int userId = sharedPreferences.getInt("userId");
    String url = getAddressListUrl(userId);
    var response = await http.get(url);
    if(response.statusCode == 200){
      return json.decode(response.body);
    }else{
      throw Exception("getAddressList error,code:" + response.statusCode.toString());
    }
  }

  Widget _getAddressWidget(AddressMode addressMode){
    //receiver message
    return Container(
      child: Row(
        children: <Widget>[
          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(addressMode.userName,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18.0),),
                  Container(
                    child: Text(addressMode.phone,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18.0),),
                    margin: const EdgeInsets.only(left: 16.0),
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.start,
              ),
              Row(
                children: <Widget>[
                  Container(
                    height: 12.0,
                    child: Text("默认",style: TextStyle(color: Colors.white,fontSize: 10.0),),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(6.0)),
                      color: Colors.red,
                    ),
                    padding: EdgeInsets.only(left: 6.0,right: 6.0),
                    margin: EdgeInsets.only(right: 4.0,top:4.0),
                  ),
                  Container(
                    child: Text(addressMode.address,style: TextStyle(fontSize: 12.0),),
                    margin: const EdgeInsets.only(left: 16.0),
                    width: 220.0,
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.start,
              ),
            ],
            crossAxisAlignment: CrossAxisAlignment.start,
          ),

          IconButton(
            icon: Icon(Icons.arrow_forward_ios,color: Colors.grey,),
            onPressed: (){
              Navigator.pushNamed(context, '/address_list');
            },
          ),

        ],
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      ),
      padding: EdgeInsets.only(left: 16.0,top:16.0,bottom: 16.0,),
      color: Colors.white,
    );
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
        title: Text("填写订单"),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: <Widget>[

            FutureBuilder(
              future: _getAddressList(),
              builder: (BuildContext context,AsyncSnapshot snapShot){
                // ignore: missing_enum_constant_in_switch
                switch(snapShot.connectionState){
                  case ConnectionState.waiting:
                    return Text("数据查询中...");
                    break;
                  case ConnectionState.done:
                    if(snapShot.hasData){
                      List<dynamic> maps = snapShot.data;
                      AddressMode addressMode = null;
                      maps.forEach((map){
                        AddressMode obj = AddressMode.fromJson(map);
                        if(obj.selected == 1){
                          addressMode = obj;
                        }
                      });
                      return _getAddressWidget(addressMode);
                    }else{
                      return Text("暂无数据");
                    }
                    break;
                }
              },
            ),

            //cuisine
            Container(
              child: Row(
                children: <Widget>[
                  Image.network(
                    widget.cuisineImageUrl,
                    width: 80.0,
                    height: 45.0,
                  ),

                 Column(
                   children: <Widget>[
                     Text(widget.cuisineName,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18.0),),
                     Text("￥" + widget.cuisinePrice,style: TextStyle(color: Colors.blue,),),
                   ],
                   crossAxisAlignment: CrossAxisAlignment.end,
                 ),
                ],
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              ),
              padding: EdgeInsets.only(left: 16.0,top: 8.0,right: 16.0,bottom: 8.0,),
              margin: EdgeInsets.only(top:16.0),
              color: Colors.white,
            ),

            //pay mode
            Container(
              child:Row(
                children: <Widget>[
                  Text("支付方式",style: TextStyle(fontSize: 18.0),),
                ],
              ),
              padding: EdgeInsets.only(left: 16.0,top: 8.0,right: 16.0,bottom: 8.0,),
              margin: EdgeInsets.only(top:16.0),
              color: Colors.white,
            ),
            Divider(
              color: Color.fromARGB(255, 143, 143, 143),
              height: 1.0,
            ),
            GestureDetector(
              child: Container(
                child: ListTile(
                  leading: Icon(FontAwesomeIcons.weixin,color: Colors.blue,),
                  title: Text("微信支付"),
                  selected: _selectValue == 0?true:false,
                  trailing: Radio(
                    value: 0,
                    groupValue: _selectValue,
                    onChanged: (int value){
                      setState(() {
                        _selectValue = value;
                      });
                    },
                  ),
                ),
                color: Colors.white,
              ),
              onTap: (){
                setState(() {
                  _selectValue = 0;
                });
              },
            ),

            Divider(
              color: Color.fromARGB(255, 143, 143, 143),
              height: 1.0,
            ),

            GestureDetector(
              child: Container(
                child: ListTile(
                  leading: Icon(IconData(0xe802, fontFamily: "ali"),color: Colors.blue,),
                  title: Text("支付宝"),
                  selected: _selectValue == 1?true:false,
                  trailing: Radio(
                    value: 1,
                    groupValue: _selectValue,
                    onChanged: (int value){
                      setState(() {
                        _selectValue = value;
                      });
                    },
                  ),
                ),
                color: Colors.white,
              ),
              onTap: (){
                setState(() {
                  _selectValue = 1;
                });
              },
            ),

            Divider(
              color: Color.fromARGB(255, 143, 143, 143),
              height: 1.0,
            ),

            GestureDetector(
              child: Container(
                child: ListTile(
                  leading: Icon(FontAwesomeIcons.creditCard,color: Colors.blue,),
                  title: Text("银行卡"),
                  selected: _selectValue == 2?true:false,
                  trailing: Radio(
                    value: 2,
                    groupValue: _selectValue,
                    onChanged: (int value){
                      setState(() {
                        _selectValue = value;
                      });
                    },
                  ),
                ),
                color: Colors.white,
              ),

              onTap: (){
                setState(() {
                  _selectValue = 2;
                });
              },
            ),

            Divider(
              color: Color.fromARGB(255, 143, 143, 143),
              height: 1.0,
            ),

            Container(
              child: RaisedButton(
                color: Colors.blue,
                child: Row(
                  children: <Widget>[
                    Text("提交订单",style: TextStyle(color: Colors.white,fontSize: 18.0),),
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
                onPressed: (){

                },
              ),
              padding: const EdgeInsets.only(left: 16.0,right: 16.0),
              margin: const EdgeInsets.only(top:100.0),
            ),
          ],
        ),
        color: Color.fromARGB(255, 243, 241, 244),
      )
    );
  }

}

class AddressMode{
  int id;
  int userId;
  String userName;
  String address;
  String phone;
  int selected;
  int addressTypeId;
  String createTime;

  AddressMode.fromJson(Map<String,dynamic> map):
        id = int.parse(map["id"]),
        userId = int.parse(map["user_id"]),
        userName = map["user_name"],
        address = map["address"],
        phone = map["phone"],
        selected = int.parse(map["selected"]),
        addressTypeId = int.parse(map["address_type_id"]),
        createTime = map["create_time"];
}