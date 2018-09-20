import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/mainPage/OrderDetailPage.dart';
import 'package:flutter_app/tools/UrlManage.dart';
import 'package:http/http.dart' as http;


class OrderItemView extends StatelessWidget{

  int _payState = 0;

  OrderItemView(@required this._payState);

  Future _getOrderItemDataList() async{
    String url = getOrderByTypeUrl(_payState);
    var response = await http.get(url);
    if(response.statusCode == 200){
      return json.decode(response.body);
    }else{
      throw Exception("getOrderItemDataList method net error");
    }
  }

  Widget _getItemView(OrderItemData data){
    return Card(
      child: Container(
          margin: EdgeInsets.all(16.0),
          child: Row(
            children: <Widget>[
              Row(children: <Widget>[
                Image.network(data.cuisineImage,width: 90.0,height: 90.0,fit: BoxFit.cover ,),
                Container(child: Column(
                  children: <Widget>[
                    Text(data.cuisineName,style: TextStyle(fontSize: 16.0),textAlign: TextAlign.left,),
                    Text("￥" + data.cuisinePrice,style: TextStyle(color: Color.fromARGB(255, 38, 200, 139),fontSize: 16.0),textAlign: TextAlign.left),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  ),
                  height: 90.0,
                  margin: EdgeInsets.only(left: 8.0),
                  ),
                ],
              ),
              RaisedButton(onPressed: (){

                },
                child: Text("支付"),
                color: Colors.blue,
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
          ),
      )
     
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return
      FutureBuilder(
        future: _getOrderItemDataList(),
        builder: (BuildContext context,AsyncSnapshot snapshot){
          // ignore: missing_enum_constant_in_switch
          switch(snapshot.connectionState){
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(),
              );
              break;
            case ConnectionState.done:
              if(snapshot.hasData){
                List<dynamic> dataList = snapshot.data;
                List<OrderItemData> _dataSource = List();
                dataList.forEach((dynamic map){
                  _dataSource.add(OrderItemData.fromJson(map));
                });
                return ListView.builder(
                  itemCount: _dataSource.length,
                  itemBuilder: (buildContext,index) => GestureDetector(
                    child: _getItemView(_dataSource[index]),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>OrderDetailPage(
                        _dataSource[index].cuisineId,
                        _dataSource[index].cuisineImage,
                        _dataSource[index].cuisineName,
                        _dataSource[index].cuisinePrice,
                      )));
                    },
                  ),
                );
              }else{
                return Center(
                  child: Text("当前没有订单!"),
                );
              }
              break;
          }

        },
      );

  }

}


class OrderItemData{
/*  OrderItemData(@required cuisineImageUrl,@required cuisineTitle,@required cuisinePrice){
    this.cuisineImageUrl = cuisineImageUrl;
    this.cuisineTitle = cuisineTitle;
    this.cuisinePrice = cuisinePrice;
  }*/

 OrderItemData.fromJson(Map<String,dynamic> map)
      :cuisineId = int.parse(map["cuisine_id"]),
      cuisineImage = map["cuisine_image"],
      cuisineName = map["cuisine_name"],
       cuisinePrice = map["cuisine_price"],
       buyerId = int.parse(map["buyer_id"]),
       addressId = int.parse(map["address_id"]),
       payState = int.parse(map["pay_state"]),
       createTime = map["create_time"];
  
  String cuisineImage;
  String cuisineName;
  String cuisinePrice;
  int cuisineId;
  int buyerId;
  int addressId;
  int payState;
  String createTime;
}