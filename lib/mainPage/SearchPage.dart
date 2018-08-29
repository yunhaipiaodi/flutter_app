import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_app/tools/SqfliteHelp.dart';
import 'package:sqflite/sqflite.dart';


class SearchPage extends StatefulWidget{
  @override
  // ignore: missing_return
  SearchState createState() => SearchState();
}

class SearchState extends State<StatefulWidget>{

  String _searchKeyword = "";
  bool _isSearching = false;
  bool _searchBarFocus = false;
  TextEditingController controller = TextEditingController();
  FocusNode _focusNode = FocusNode();
  Database _db;

  @override
  void initState(){
    super.initState();
    //change state bar color
    _focusNode.addListener(_onFocusChange);

  }

  @override
  void dispose(){
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    _closeDatabase();
    super.dispose();
  }

  /*
  * init database for storage search record
  * */


  /*
  * close database
  * */
  _closeDatabase() async{
    if(_db != null){
      await _db.close();
    }
  }

  _insertSearchHistory(String historyKeyword)async{
    //delete historyKeyword first
    String deleteSql = "DELETE FROM SEARCH_HISTORY WHERE SEARCH_KEYWORD = '$historyKeyword'";
    await SqfliteHelp.delete(deleteSql);
    //insert historyKeyword
    String insertSql = "INSERT INTO SEARCH_HISTORY (SEARCH_KEYWORD,CREATE_TIME) VALUES ('$historyKeyword',time())";
    await SqfliteHelp.insert(insertSql);
  }

  Future<List<Map>> _getSearchHistoryList() async{
    String querySql = "SELECT * FROM SEARCH_HISTORY ORDER BY CREATE_TIME DESC";
    return SqfliteHelp.query(querySql);
  }

  //TextField Focus Listener
  _onFocusChange(){
    setState(() {
      _searchBarFocus = _focusNode.hasFocus;
    });
  }

  //create search tag
  Widget _getFoodItem(String foodName,bool highLight){
    return GestureDetector(
      onTap: (){
        setState(() {
          _searchKeyword = foodName;
          controller.text = foodName;
          _isSearching = true;
          _insertSearchHistory(foodName);
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

  /**
   * get commend key; eg:no keywords;
   * */
  Future _getCommendKeywords() async{
    String url = "http://yunhaipiaodi.gz01.bdysite.com/AppServer/php/get_commend_search.php";
    var response = await http.get(url);
    if(response.statusCode == 200){
      return json.decode(response.body);
    }else{
      throw Exception("fails to get commend keywords");
    }
  }

  /*
  * get search result
  * */
  Future _searchCuisine(String keyword) async{
    String url = "http://yunhaipiaodi.gz01.bdysite.com/AppServer/php/search_cuisine.php?keyword=" + keyword;
    var response = await http.get(url);
    if(response.statusCode == 200){
      return json.decode(response.body);
    }else{
      throw Exception("fails to get commend keywords");
    }
  }

  /*
  * construct commend keyword list
  * */
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

  /*
  * construct history keyword list
  * */
  List<Widget> _showHistoryKeywords(List<String> keywords){
    List<Widget> widgets = List();
    keywords.forEach((String keyword){
      widgets.add(_getFoodItem(keyword,false));
    });
    return widgets;
  }

  /*
  * construct search result list item
  * */
  Widget _getSearchResultItemView(TabItemData data){
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

  /*
  * construct search auto list item text
  * */
  Widget _initSearchAutoListItemText(String title){
    if(_searchKeyword.length == 0){  //no need to change color
      return Text(title,style: TextStyle(fontSize: 20.0),);
    }else{
      int start = title.indexOf(_searchKeyword);
      String firstTitle = "";
      String lastTitle = "";
      if(start> 0 ){        //keyword not in front of title,should split first string
        firstTitle = title.substring(0,start);
      }
      if((firstTitle.length + _searchKeyword.length) < title.length){
          //keyword not at last of title,should split last string
        lastTitle = title.substring(firstTitle.length + _searchKeyword.length,title.length);
      }

      return RichText(
        text: TextSpan(
          text:firstTitle,
          style: TextStyle(fontSize: 20.0,color: Colors.black),
          children: <TextSpan>[
            TextSpan(
              text:_searchKeyword,
              style: TextStyle(color: Colors.blue,fontSize: 20.0),
            ),
            TextSpan(
              text:lastTitle,
              style: TextStyle(fontSize: 20.0,color: Colors.black),
            ),
          ],
        ),
      );
    }
  }

  /*
  * construct Search Auto list
  * */
  Widget _initSearchAutoList(List<String> titles){
    return Expanded(
      child: ListView.builder(
        itemCount: titles.length,
        itemBuilder: (buildContext,index) => GestureDetector(
          onTap: (){
            setState(() {
              controller.text = titles[index];
              _searchKeyword = titles[index];
              _isSearching = true;
              _insertSearchHistory(titles[index]);
              FocusScope.of(context).requestFocus(FocusNode());
            });
          },
          child: Container(
            child: Container(
              child: _initSearchAutoListItemText(titles[index]),
              margin: EdgeInsets.only(left: 16.0,top:8.0,bottom: 8.0),
            ),
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color:Colors.grey))
            ),
          ),
        ),
      ),
    );
  }

  /*
  * Search Auto complete list
  * */
  Widget _getAutoCompleteSearchList(){
    if(_searchKeyword.isEmpty){
      return FutureBuilder(
        future: _getCommendKeywords(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          // ignore: missing_enum_constant_in_switch
          switch(snapshot.connectionState){
            case ConnectionState.waiting:
              return Center(
                child: Text("正在查找中..."),
              );
              break;
            case ConnectionState.done:
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
                return  _initSearchAutoList(keywords);
                }else{
                return Center(
                  child: Text("抱歉,没有找到推荐美食!"),
                );
              }
            break;
            default:
              if(snapshot.hasError){
                return Center(
                  child: Text("查询错误:" + snapshot.error),
                );
              }
              break;
          }
        },
      );
    }else{
      return FutureBuilder(
        future:  _searchCuisine(_searchKeyword),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
          // ignore: missing_enum_constant_in_switch
          switch(snapshot.connectionState){
            case ConnectionState.done:
              if(snapshot.hasData){
                List datas = snapshot.data;
                if(datas.length == 0){
                  return Center(
                    child: Text("抱歉,没有找到推荐美食!"),
                  );
                }
                List<String> keywords = List();
                datas.forEach((object){
                  keywords.add(object["name"]);
                });
                return  _initSearchAutoList(keywords);
              }else{
                return Center(
                  child: Text("抱歉,没有找到推荐美食!"),
                );
              }
              break;
            case ConnectionState.waiting:
              return Text("正在查找中...");
              break;
            default:
              if(snapshot.hasError){
                return Center(
                  child: Text("查询错误:" + snapshot.error),
                );
              }
              break;
          }

        },
      );
    }
  }

  //get search body
  Widget _getSearchBody(){
    if(_isSearching){
      return FutureBuilder(
        future: _searchCuisine(_searchKeyword),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          // ignore: missing_enum_constant_in_switch
          switch(snapshot.connectionState){
            case ConnectionState.waiting:
              return Center(
                child: Text("正在查找中..."),
              );
              break;
            case ConnectionState.done:
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
                    itemBuilder: (buildContext,index) => _getSearchResultItemView(_dataSource[index]),
                  ),
                );
              }else{
                return Center(
                  child: Text("没有找到你想要的东西!"),
                );
              }
              break;
            default:
              if(snapshot.hasError){
                return Center(
                  child: Text("查询错误:" + snapshot.error),
                );
              }
              break;
          }
        },
      );
    }else{
      if(_searchBarFocus){
        return _getAutoCompleteSearchList();
      }else{
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
              switch(snapshot.connectionState){
                case ConnectionState.waiting:
                  return Center(
                    child: Text("正在查找中..."),
                  );
                  break;
                case ConnectionState.done:
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
                      child: Text("抱歉,没有找到推荐美食!"),
                    );
                  }
                  break;
                default:
                  if(snapshot.hasError){
                    return Center(
                      child: Text("查询错误:" + snapshot.error),
                    );
                  }
                  break;
              }
            },
          ),

          //history food title
          Container(
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text("搜索历史",style: TextStyle(fontSize: 22.0,fontWeight: FontWeight.bold),),
                  ],
                ),
              ],
            ),
            margin: EdgeInsets.only(top: 16.0,left: 16.0,right: 16.0,),
          ),


          //history
          FutureBuilder(
            future: _getSearchHistoryList(),
            builder: (BuildContext context,AsyncSnapshot snapshot){
              // ignore: missing_enum_constant_in_switch
              switch(snapshot.connectionState){
                case ConnectionState.waiting:
                  return Center(
                    child: Text("正在查找中..."),
                  );
                  break;
                case ConnectionState.done:
                  if(snapshot.hasData){
                    List<Map> results = snapshot.data;
                    if(results.length == 0){
                      return Center(
                        child: Text("没有历史查询"),
                      );
                    }
                    List<String> keywords = List();
                    results.forEach((Map map){
                      keywords.add(map["SEARCH_KEYWORD"]);
                    });
                    return Container(
                      child: Wrap(
                        children: _showHistoryKeywords(keywords),
                      ),
                      margin: EdgeInsets.only(left: 16.0,right: 16.0,top:8.0),
                      alignment: Alignment.topLeft,
                    );
                  }else{
                    return Center(
                      child: Text("没有历史查询"),
                    );
                  }
                  break;
                default:
                  if(snapshot.hasError){
                    return Center(
                      child: Text("查询错误:" + snapshot.error),
                    );
                  }
                  break;
              }
            },
          ),
        ],);
      }
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
                      setState(() {
                        _isSearching = false;
                        _searchKeyword = keyword;
                      });
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
                  if(_isSearching || _searchBarFocus){
                    FocusScope.of(context).requestFocus(FocusNode());
                   setState(() {
                     _isSearching = false;
                     _searchKeyword = "";
                     controller.text = "";
                   });
                  }else{
                    Navigator.pop(context);
                  }
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

          _getSearchBody(),
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