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


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    List<String> foodTitles = [
      "",
    ];

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

            //commend food list
            Expanded(
              child: SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                ),
                delegate: SliverChildBuilderDelegate(
                    (buildContext,index) => Container(
                      child: Text(""),
                    ),
                ),
              ),
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