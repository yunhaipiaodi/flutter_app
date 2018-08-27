import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SearchPage extends StatefulWidget{
  @override
  // ignore: missing_return
  SearchState createState() => SearchState();
}

class SearchState extends State<StatefulWidget>{

  String _searchKeyword = "";
  bool _searchBarFocus = false;
  TextEditingController controller = TextEditingController();
  FocusNode _focusNode = FocusNode();

  @override
  void initState(){
    super.initState();
    //change state bar color
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose(){
    super.dispose();
    _focusNode.removeListener(_onFocusChange);
  }

  _onFocusChange(){
    setState(() {
      _searchBarFocus = true;
    });
  }

  //create search tag
  Widget _getFoodItem(String foodName,bool highLight){
    return GestureDetector(
      onTap: (){
        setState(() {
          _searchKeyword = foodName;
          controller.text = foodName;
        });
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

  Future _getCommendKeywords() async{
    String url = "http://yunhaipiaodi.gz01.bdysite.com/AppServer/php/get_commend_search.php";
    var response = await http.get(url);
    if(response.statusCode == 200){
      return json.decode(response.body);
    }else{
      throw Exception("fails to get commend keywords");
    }
  }

  Future _searchCuisine(String keyword) async{
    String url = "http://yunhaipiaodi.gz01.bdysite.com/AppServer/php/search_cuisine.php?keyword=" + keyword;
    var response = await http.get(url);
    if(response.statusCode == 200){
      return json.decode(response.body);
    }else{
      throw Exception("fails to get commend keywords");
    }
  }

  List<Widget> _showCommendKeywords(List<String> keywords){

    List<Widget> widgets = List();
    for(int i = 0;i<keywords.length;i++){
      if(i<3){
        widgets.add(_getFoodItem(keywords[i],true));
      }else{
        widgets.add(_getFoodItem(keywords[i],false));
      }
    }
    return widgets;
  }

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

  Widget _getSearchAutoList(List<String> titles){
    return ListView.builder(
      itemCount: titles.length,
      itemBuilder: (buildContext,index) => Container(
        child: Text(titles[index]),
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color:Colors.grey))
        ),
      ),
    );
  }

  /*Widget _getSearchList(bool _searchBarFocus){
    if(_searchBarFocus){
      if(_searchKeyword.isEmpty){
        return FutureBuilder(
            future: _getCommendKeywords(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if(snapshot.hasData){
                List datas = snapshot.data;
                if(datas.length == 0){
                  return Center(
                    child: Text("抱歉,没有找到推荐美食!"),
                  );
                }
                List<String> keywords = List();
                datas.forEach((object){
                  keywords.add(object["commend_keyword"]);
                });
                return _getSearchAutoList(keywords);
              }else{
                return Center(
                  child: Text("正在查找中..."),
                );
              }
            },
        );
      }else{
        return FutureBuilder(
          future: _getCommendKeywords(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if(snapshot.hasData){
              List datas = snapshot.data;
              if(datas.length == 0){
                return Center(
                  child: Text("抱歉,没有找到推荐美食!"),
                );
              }
              List<String> keywords = List();
              datas.forEach((object){
                keywords.add(object["commend_keyword"]);
              });
              return _getSearchAutoList(keywords);
            }else{
              return Center(
                child: Text("正在查找中..."),
              );
            }
          },
        );
      }
    }else{
      //return null
      return Container();
    }
  }*/

  //get search body
  Widget _getSearchBody(bool isKeywordEmpty){
    if(_searchKeyword.isEmpty){
      return Column(children: <Widget>[
        //commend food title
        Container(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text("推荐美食",style: TextStyle(fontSize: 22.0,fontWeight: FontWeight.bold),),
                ],
              ),
            ],
          ),
          margin: EdgeInsets.only(top: 16.0,left: 16.0,right: 16.0,),
        ),

        //get commend foods keywords from network
        FutureBuilder(
          future:  _getCommendKeywords(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            //get commend keywords list
            if(snapshot.hasData){
              List datas = snapshot.data;
              if(datas.length == 0){
                return Center(
                  child: Text("抱歉,没有找到推荐美食!"),
                );
              }
              List<String> keywords = List();
              datas.forEach((object){
                keywords.add(object["commend_keyword"]);
              });
              return Container(
                child: Wrap(
                  children: _showCommendKeywords(keywords),
                ),
                margin: EdgeInsets.only(left: 16.0,right: 16.0,top:8.0),
                alignment: Alignment.topLeft,
              );
            }else{
              return Center(
                child: Text("正在查找中..."),
              );
            }
          },
        ),

        //history food title
        Container(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text("历史搜索",style: TextStyle(fontSize: 22.0,fontWeight: FontWeight.bold),),
                  IconButton(icon: Icon(Icons.delete),onPressed: null,),
                ],
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              ),
            ],
          ),
          margin: EdgeInsets.only(top: 16.0,left: 16.0,right: 16.0,),
        ),

        //history
        Container(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  _getFoodItem("萝卜牛腩",false),
                  _getFoodItem("鲍汁排骨饭",false),
                ],
              ),
            ],
          ),
          margin: EdgeInsets.only(left: 16.0,right: 16.0),
        ),
      ],);
    }else{
      return FutureBuilder(
        future: _searchCuisine(_searchKeyword),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if(snapshot.hasData){
            List datas = snapshot.data;
            if(datas.length == 0){
              return Center(
                child: Text("没有找到你想要的东西!"),
              );
            }
            List<TabItemData> _dataSource = List();
            datas.forEach((jsonObject){
              _dataSource.add(TabItemData.fromJson(jsonObject));
            });
            return Expanded(
              child: ListView.builder(
                itemCount: _dataSource.length,
                itemBuilder: (buildContext,index) => _getItemView(_dataSource[index]),
              ),
            );
          }else{
            return Center(
              child: Text("正在查找中..."),
            );
          }
        },
      );
    }
  }



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(child: Column(
        children: <Widget>[
          //top bar
          Container(
            child:Row(children: <Widget>[
              //search bar
              Container(
                width:280.0,
                height:36.0,
                child: Row(children: <Widget>[
                  IconButton(icon:Icon(Icons.search),onPressed: null,),
                  Expanded(child: TextField(
                    decoration: InputDecoration.collapsed(
                      hintText: '搜索你喜欢的美食吧!',
                      border: InputBorder.none,
                    ),
                    controller: controller,
                    focusNode: _focusNode,
                    onChanged: (keyword){
                      print("focus in input:"+ keyword);
                    },
                  ),
                  ),
                ],
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(18.0)),
                ),
                margin: EdgeInsets.only(left: 16.0),
              ),
              //cancel btn
              GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Container(
                  child: Text("取消",style: TextStyle(color: Colors.white,fontSize: 18.0),),
                  margin: EdgeInsets.only(right: 16.0),
                ),
              ),
            ],
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            ),
            height: AppBar().preferredSize.height,
            color: Colors.blue,
          ),

          _getSearchBody(_searchKeyword.isEmpty),
        ],

      ),
        margin: EdgeInsets.only(top:MediaQuery.of(context).padding.top,),
        color: Colors.white,
      ),
      backgroundColor: Colors.blue,
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