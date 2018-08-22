import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';


class TabItemView extends StatefulWidget{
  @override
  TabItemState createState()  => TabItemState();

}

class TabItemState extends State<TabItemView>{

  List<TabItemData> _dataSource = List();


  Widget _getItemView(TabItemData data){
    return Card(
      child: Column(
        children: <Widget>[
          Image.network(data.foodImageUrl),
          Row(children: <Widget>[
            Container(
              child: Column(children: <Widget>[
                Text(data.foodTitle,style: TextStyle(fontSize: 16.0),textAlign: TextAlign.left,),
                Text("￥" + data.foodPrice,style: TextStyle(color: Color.fromARGB(255, 38, 200, 139),fontSize: 12.0),textAlign: TextAlign.left),
              ],
                crossAxisAlignment: CrossAxisAlignment.start,),
              margin: EdgeInsets.only(left: 16.0),
            ),

            IconButton(icon: Icon(Icons.shopping_cart,color: Colors.blue,),onPressed: null,),
          ],
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          ),
        ],
      ),
    );
  }

  Future _getFoods() async{
    String url = "http://yunhaipiaodi.gz01.bdysite.com/AppServer/php/get_foods.php";
    final response = await get(url);
    if(response.statusCode == 200){
      return json.decode(response.body);
    }else{
      throw Exception('failed to load foods');
    }
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return
      FutureBuilder(
          future: _getFoods(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if(!snapshot.hasData){
              return Center(
                child: Text("数据加载中..."),
              );
            }
            List datas = snapshot.data;
            datas.forEach((jsonObject){
              _dataSource.add(TabItemData.fromJson(jsonObject));
            });
            return ListView.builder(
                itemCount: datas.length,
                itemBuilder: (buildContext,index) => _getItemView(_dataSource[index]),
            );
          }
      );
  }

}


class TabItemData{

    String foodImageUrl;
    String foodTitle;
    String foodPrice;

    TabItemData(@required this.foodImageUrl,@required this.foodTitle,@required this.foodPrice);

    TabItemData.fromJson(Map<String,dynamic> json)
      :foodImageUrl=json["image_url"],
       foodTitle = json["name"],
       foodPrice = json["price"];

}