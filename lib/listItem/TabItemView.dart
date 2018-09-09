import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/mainPage/DetailPage.dart';
import 'package:http/http.dart';


class TabItemView extends StatefulWidget{

  int type = 0;

  @override
  TabItemState createState()  => TabItemState(type);

  TabItemView(this.type);

}

class TabItemState extends State<TabItemView>{

  List<TabItemData> _dataSource = List();

  int type = 0;

  TabItemState(this.type);

  Widget _getItemView(TabItemData data){
    return Card(
      child: Column(
        children: <Widget>[
          GestureDetector(
            child: Image.network(data.foodImageUrl),
            onTap: (){
              Navigator.push(
                  context, MaterialPageRoute(
                builder: (context) => DetailPage(data.foodId),
              )
              );
            },
          ),

          Row(children: <Widget>[
            Container(
              child: Column(children: <Widget>[
                Text(data.foodTitle,style: TextStyle(fontSize: 16.0),textAlign: TextAlign.left,),
                Text("￥" + data.foodPrice,style: TextStyle(color: Color.fromARGB(255, 38, 200, 139),fontSize: 12.0),textAlign: TextAlign.left),
              ],
                crossAxisAlignment: CrossAxisAlignment.start,),
              margin: EdgeInsets.only(left: 16.0),
            ),

            //IconButton(icon: Icon(Icons.shopping_cart,color: Colors.blue,),onPressed: null,),
          ],
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          ),
        ],
      ),
    );
  }

  Future _getFoods() async{
    String url = "http://yunhaipiaodi.gz01.bdysite.com/AppServer/php/get_foods_by_type.php?type=" + type.toString();
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
            switch(snapshot.connectionState){
              case ConnectionState.waiting:
                return Center(
                  child: Text("数据加载中..."),
                );
                break;
              case ConnectionState.done:
                if(!snapshot.hasData){
                  return Center(
                    child: Text("当前没有数据"),
                  );
                }
                List datas = snapshot.data;
                if(datas.length == 0){
                  return Center(
                    child: Text("当前没有数据"),
                  );
                }
                datas.forEach((jsonObject){
                  _dataSource.add(TabItemData.fromJson(jsonObject));
                });
                return ListView.builder(
                  itemCount: datas.length,
                  itemBuilder: (buildContext,index) => _getItemView(_dataSource[index]),
                );
                break;
              default:
                if(snapshot.hasError){
                  return Center(
                    child: Text("查询错误:" + snapshot.error),
                  );
                }
                break;
            }
          }
      );
  }
}

class TabItemData{

    int foodId;
    String foodImageUrl;
    String foodTitle;
    String foodPrice;

    TabItemData(@required this.foodId,@required this.foodImageUrl,@required this.foodTitle,@required this.foodPrice);

    TabItemData.fromJson(Map<String,dynamic> json)
      :foodId = int.parse(json["id"]),
       foodImageUrl=json["image_url"],
       foodTitle = json["name"],
       foodPrice = json["price"];

}