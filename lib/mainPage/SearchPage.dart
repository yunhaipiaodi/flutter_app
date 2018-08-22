import 'package:flutter/material.dart';
import 'package:flutter_app/tools/flutter_statusbarcolor.dart';
import 'package:flutter/services.dart';

class SearchPage extends StatefulWidget{
  @override
  // ignore: missing_return
  SearchState createState() => SearchState();


}

class SearchState extends State<StatefulWidget>{
  @override
  void initState(){
    super.initState();

    //change state bar color

  }

  Widget _getFoodItem(String foodName,bool highLight){
    return Container(
      height: 20.0,
      child: Text(foodName,style: TextStyle(color: highLight?Colors.white:Colors.black),),
      decoration: BoxDecoration(
        color: highLight?Colors.blue:Color.fromARGB(255, 246, 246,246),
        borderRadius: BorderRadius.all(Radius.circular(10.0))
      ),
      padding: EdgeInsets.only(left: 10.0,right: 10.0),
      margin: EdgeInsets.only(right: 8.0,top:8.0),
    );
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
                        decoration: InputDecoration.collapsed(hintText: '搜索你喜欢的美食吧!',
                          border: InputBorder.none,),
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
                  Container(
                    child: Text("取消",style: TextStyle(color: Colors.white,fontSize: 18.0),),
                    margin: EdgeInsets.only(right: 16.0),
                  ),

                ],
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              ),
              height: AppBar().preferredSize.height,
              color: Colors.blue,
            ),

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

            //commend foods
            Container(
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      _getFoodItem("满汉全席",true),
                      _getFoodItem("满汉全席",true),
                      _getFoodItem("满汉全席",true),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      _getFoodItem("夜宵",false),
                      _getFoodItem("红烧肉",false),
                      _getFoodItem("川味水煮鱼",false),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      _getFoodItem("家常粉蒸排骨",false),
                      _getFoodItem("西班牙蒜蓉大虾",false),
                    ],
                  ),
                ],
              ),
              margin: EdgeInsets.only(left: 16.0,right: 16.0,top:8.0),
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
          ],

        ),
          margin: EdgeInsets.only(top:MediaQuery.of(context).padding.top,),
          color: Colors.white,
        ),
        backgroundColor: Colors.blue,
      );
  }

}