import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AddressListPage extends StatefulWidget{
  @override
  AddressState createState() => AddressState();
}


class AddressState extends State<AddressListPage>{

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  Widget _buildAddressListItem(int index,AddressMode addressMode){
    return GestureDetector(
      child: Container(
        child: ListTile(
          leading: addressMode.selected == 1?Icon(Icons.check,color: Colors.red,):Container(width: 24.0,height: 24.0,),
          title: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(addressMode.userName,style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold),),
                  Text(addressMode.phone,style: TextStyle(fontSize: 14.0,),),
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
                ],
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              ),
              Container(
                child: Text(addressMode.address,style: TextStyle(fontSize: 12.0),),
                width: 200.0,
              ),
            ],
          ),
          trailing: IconButton(icon: Icon(Icons.edit,color: Colors.blue,), onPressed: (){}),
        ),
        decoration: BoxDecoration(border: Border(bottom: BorderSide(color:Colors.grey))),
      ),
      onTap: (){
        _updateSelected(addressMode.userId,addressMode.id).then((bool result){
          if(result){
            Navigator.pop(context);
          }else{
            _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("更改地址失败")));
          }
        });
      },
    );
  }

  Future<bool> _updateSelected(int userId,int addressId) async{
    String url = "http://yunhaipiaodi.gz01.bdysite.com/AppServer/php/update_address_select.php?user_id=$userId&address_id=$addressId";
    var response = await http.get(url);
    if(response.statusCode == 200){
      return true;
    }else{
      return false;
    }
  }

  //get address list data
  Future _getAddressList() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    int userId = sharedPreferences.getInt("userId");
    String url = "http://yunhaipiaodi.gz01.bdysite.com/AppServer/php/get_address_list.php?user_id=" + userId.toString();
    var response = await http.get(url);
    if(response.statusCode == 200){
      return json.decode(response.body);
    }else{
      throw Exception("getAddressList error,code:" + response.statusCode.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: (){
              Navigator.pop(context);
            }
        ),
        title: Text("地址管理"),
        centerTitle: true,
      ),
      body:
      Column(
        children: <Widget>[
          FutureBuilder(
            future: _getAddressList(),
            builder: (BuildContext context,AsyncSnapshot snapshot){
              // ignore: missing_enum_constant_in_switch
              switch(snapshot.connectionState){
                case ConnectionState.waiting:
                  return Text("数据加载中");
                  break;
                case ConnectionState.done:
                  if(snapshot.hasData){
                    List<dynamic> maps = snapshot.data;
                    List<AddressMode> addressModes = List();
                    maps.forEach((map){
                      addressModes.add(AddressMode.fromJson(map));
                    });
                    return  Expanded(
                      child: ListView.builder(
                        itemCount: addressModes.length,
                        itemBuilder: (BuildContext context,int index) => _buildAddressListItem(index,addressModes[index]),
                      ),
                    );
                  }else{
                    return Text("暂无数据");
                  }
                  break;
              }
           },
          ),


          Container(
            child:  RaisedButton(
              color:Colors.blue,
              child: Row(
                children: <Widget>[
                  Text("+ 新建收货地址",style: TextStyle(fontSize: 18.0,color: Colors.white),),
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
              onPressed: (){
                  Navigator.pushNamed(context, '/add_address');
              },
            ),
            margin: EdgeInsets.only(top:16.0,left: 16.0,right: 16.0),
          ),
        ],
      ),
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