import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/mainPage/LoginPage.dart';
import 'package:flutter_app/mainPage/OrderDetailPage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DetailPage extends StatefulWidget{

  int cuisine_id;

  DetailPage(@required this.cuisine_id);

  @override
  DetailState createState() => DetailState();
}

class DetailState extends State<DetailPage>{

  Future<Map<String,dynamic>> _getCuisineById(int id) async{
    String url = "http://yunhaipiaodi.gz01.bdysite.com/AppServer/php/get_cuisine_by_id.php?cuisine_id=$id";
    var response = await http.get(url);
    if(response.statusCode == 200){
      return json.decode(response.body);
    }else{
     throw ("get cuisine by id error");
    }
  }

  Future<bool> _getLoginState() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool hasLogin = await prefs.getBool("hasLogin");
    hasLogin = hasLogin == null?false:hasLogin;
    return hasLogin;
  }

  Widget _getCommendItem(int index){
    return Container(
      child: Row(
        children: <Widget>[
          Container(
            child:CircleAvatar(backgroundImage: NetworkImage("http://a.hiphotos.baidu.com/zhidao/pic/item/21a4462309f79052782f28490ff3d7ca7bcbd591.jpg"),),
            margin: EdgeInsets.only(top:2.0),
          ),
          Expanded(
            child: Container(
              child: Column(
                children: <Widget>[
                  Container(
                    child:Row(children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text("梅川内酷",style: TextStyle(fontSize: 18.0,),),
                          Container(
                            child: Text("2018.08.29",style: TextStyle(fontSize: 12.0,color: Color.fromARGB(255, 158, 158, 158),),),
                            margin: EdgeInsets.only(top:8.0),
                          ),
                        ],
                        crossAxisAlignment: CrossAxisAlignment.start,
                      ),
                      IconButton(
                        icon:Icon(Icons.thumb_up,color: Colors.blue,),
                        onPressed: (){

                        },
                      ),

                    ],
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    ),
                    alignment: Alignment.topLeft,
                  ),

                  Container(
                    child:  Text(
                      "这个菜好辣，好爽;一口气吃了三碗饭；不能吃辣的还是别轻易尝试；店家服务很好，服务小哥很帅",
                    ),
                  ),

                ],
                crossAxisAlignment: CrossAxisAlignment.start,
              ),
              margin: EdgeInsets.only(left: 8.0),
            ),
          ),
        ],
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                color: Colors.grey,
                width: 1.0,
              )
          )
      ),
      margin: EdgeInsets.only(left: 8.0,right: 8.0),
      padding: EdgeInsets.only(top: 8.0,bottom: 8.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FutureBuilder(
        future: _getCuisineById(widget.cuisine_id),
        builder: (BuildContext context,AsyncSnapshot snapshot){
          // ignore: missing_enum_constant_in_switch
          switch(snapshot.connectionState){
            case ConnectionState.done:
              if(!snapshot.hasData){
                return  Scaffold(

                  body:  Center(
                    child: Text("没有数据!!!" ),
                  ),
                );
              }
              Map<String,dynamic> data = snapshot.data;
              CuisineData cuisineData = CuisineData.fromJson(data);
              return Scaffold(
                body: Column(
                  children: <Widget>[
                    //top cuisine image
                    Stack(
                      children: <Widget>[
                        Container(
                          child:  Image.network(
                            cuisineData.imageUrl,
                          ),
                        ),
                        Container(
                          child: IconButton(
                            icon: Icon(Icons.arrow_back,color: Colors.white,),
                            onPressed: (){
                                Navigator.pop(context);
                            },
                          ),
                          alignment: Alignment.topLeft,
                          margin: EdgeInsets.only(left: 8.0,top:MediaQuery.of(context).padding.top + 8.0),
                        ),
                      ],
                    ),

                    //detail information
                    Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            child:Text(cuisineData.name,style: TextStyle(fontSize: 28.0,color: Colors.black,fontWeight: FontWeight.bold,),textAlign: TextAlign.start,),
                            alignment: Alignment.topLeft,
                          ),

                          Container(
                            child: Text("月售 180 赞 20 好评度 100",style: TextStyle(fontSize: 12.0,),),
                            margin: EdgeInsets.only(top:8.0),
                            alignment: Alignment.topLeft,
                          ),
                          Container(
                            child: Text("￥" + cuisineData.price,style: TextStyle(fontSize: 24.0,color: Colors.blue),),
                            margin: EdgeInsets.only(top:8.0),
                            alignment: Alignment.topLeft,
                          ),

                          Row(
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Container(
                                    child: Text("商品描述",style: TextStyle(fontSize: 20.0,color: Colors.black),),
                                    margin: EdgeInsets.only(top:8.0),
                                    alignment: Alignment.topLeft,
                                  ),
                                  Container(
                                    child: Text(cuisineData.description == null?"暂无":cuisineData.description,style: TextStyle(fontSize: 12.0,),),
                                    margin: EdgeInsets.only(top:8.0),
                                    alignment: Alignment.topLeft,
                                  ),
                                ],
                                crossAxisAlignment: CrossAxisAlignment.start,
                              ),
                              RaisedButton(
                                onPressed: () {
                                  _getLoginState().then((bool hasLogin){
                                    if(hasLogin){
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => OrderDetailPage(
                                          widget.cuisine_id,
                                          cuisineData.imageUrl,
                                          cuisineData.name,
                                          cuisineData.price,
                                      )));
                                    }else{
                                      Navigator.pushNamed(context,'/login');
                                    }
                                  });

                                },
                                child: Text("下单",style: TextStyle(color: Colors.white),),
                                color: Color.fromARGB(255, 255, 152, 0),
                              ),
                            ],
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                          ),

                          Container(
                            child: Text("评论",style: TextStyle(fontSize: 20.0,color: Colors.black),),
                            margin: EdgeInsets.only(top:8.0),
                            alignment: Alignment.topLeft,
                          ),


                        ],
                      ),
                      margin: EdgeInsets.only(left: 8.0,top:8.0,right: 8.0),
                      alignment: Alignment.topLeft,
                    ),

                    //comment list
                    Expanded(
                      child: ListView.builder(
                        itemCount: 5,
                        itemBuilder: (BuildContext context,int index) => _getCommendItem(1),
                      ),
                    ),
                  ],
                ),
                bottomNavigationBar: Container(
                  child: Row(children: <Widget>[
                    IconButton(icon:Icon(Icons.thumb_up,color: Colors.white,),onPressed: (){

                    },),
                    Container(
                      width:300.0,
                      height:36.0,
                      child: Row(children: <Widget>[
                        Expanded(
                            child:Text(
                              "快来说说你的看法吧!",
                              style: TextStyle(color: Color.fromARGB(255, 158, 158, 158)),
                            ),
                        ),

                      ],
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(18.0)),
                      ),
                      padding: EdgeInsets.only(left: 16.0),
                      ),
                    ],
                  ),
                  color: Colors.blue,
                ),
              );
              break;
            case ConnectionState.waiting:
              return  Scaffold(
                body:  Center(
                  child: Text("载入中..."),
                ),
              );
              break;
            default:
              if(snapshot.hasError){
                return  Scaffold(
                  body:  Center(
                    child: Text("网络错误：" + snapshot.error),
                  ),
                );
              }
              break;
          }
        },
    );
  }
}

class CuisineData{
  int id;
  String name;
  String price;
  String imageUrl;
  String description;
  String createTime;

  CuisineData(@required this.id,@required this.name,@required this.price,@required this.imageUrl,@required this.description,@required this.createTime);

  CuisineData.fromJson(Map<String,dynamic> json):
      id = int.parse(json["id"]),
      name = json["name"],
      price = json["price"],
      imageUrl = json["image_url"],
      description = json["description"],
      createTime = json["create_time"];
}