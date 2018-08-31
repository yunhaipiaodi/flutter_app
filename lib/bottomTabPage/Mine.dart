import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/tools/Shared_preferences.dart';

class Mine extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    List<String> mineItems = [
      "我的订单",
      "我的钱包",
      "我的足迹",
      "联系客服",
      "服务中心",
      "关于我们",
    ];

    Future _getLoginState() async{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool hasLogin = await prefs.getBool("hasLogin");
      hasLogin = hasLogin == null?false:true;
      return hasLogin;
    }

    Widget _getUserInfoByLoginState(){
      return FutureBuilder(
        future: _getLoginState(),
        builder: (BuildContext context,AsyncSnapshot snapshot){
            if(snapshot.connectionState == ConnectionState.done){
              bool hasLogin = snapshot.data == null?false:true;
              if(hasLogin){
                return Container(child:
                Column(children: <Widget>[
                  CircleAvatar(
                    backgroundImage: NetworkImage("http://img4.duitang.com/uploads/item/201411/12/20141112115936_zYyEc.jpeg",),
                    radius: 36.0,
                  ),
                  Container(child:
                  Text("王尼玛",
                    style: TextStyle(color: Colors.white,fontSize: 20.0),
                  ),
                    margin: const EdgeInsets.only(top:8.0),
                  ),
                  Row(children: <Widget>[
                    Icon(Icons.location_on,color: Colors.white,),
                    Text("广州",
                      style: TextStyle(color: Colors.white,fontSize: 16.0),)
                  ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                ],
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                ),
                  height: 265.0,
                  width: MediaQuery.of(context).size.width,
                );
              }else{
                return Container(child:
                Column(children: <Widget>[
                  CircleAvatar(
                    backgroundImage: NetworkImage("http://img4.duitang.com/uploads/item/201411/12/20141112115936_zYyEc.jpeg",),
                    radius: 36.0,
                  ),
                  Container(
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.pushNamed(context,'/login');
                      },
                      child: Text("登陆",style: TextStyle(color: Colors.white),),
                      color: Color.fromARGB(255, 255, 152, 0),
                    ),
                    margin: EdgeInsets.only(top: 8.0),
                  ),

                ],
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                ),
                  height: 265.0,
                  width: MediaQuery.of(context).size.width,
                );
              }
            }
        },
      );
    }
    // TODO: implement build
    return Scaffold(
      body:Column(children: <Widget>[
        /**
         * 顶部栏
         * */
        Container(child:
          Stack(children: <Widget>[
            Container(child:Image.asset("images/meishi.jpg",fit: BoxFit.fill,),height:265.0,),
            Container(height:265.0,width: MediaQuery.of(context).size.width, 
                  color: Color.fromRGBO(0, 0, 0, 173.4),),
            Container(
                child: Row(children: <Widget>[
                        IconButton(icon: Icon(Icons.settings,color: Colors.white,), onPressed: null,),
                        ],
                        mainAxisAlignment: MainAxisAlignment.end,
                      ),
                margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                height: AppBar().preferredSize.height,
                width: MediaQuery.of(context).size.width,
            ),
            Container(child:_getUserInfoByLoginState(),
              height: 265.0,
              width: MediaQuery.of(context).size.width,
            ),
            ],
          ),
        ),

        /**
         * 底部操作列表
         * */
        Expanded(child:
        ListView.builder(
            itemCount: mineItems.length,
            itemBuilder: (buildContext,index) => _getMineItem(mineItems[index])),
        ),
      ],),
    );
  }

  Widget _getMineItem(String title){
    return
      Container(
        height: 37.5,
        margin: const EdgeInsets.only(top:16.0,left: 16.0,right: 8.0,),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey)),
        ),
        child:Row(
          children: <Widget>[
            Text(title,style: TextStyle(color: Colors.black,fontSize: 22.0),),
            IconButton(icon: Icon(Icons.navigate_next,),onPressed: null,),
          ],
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        ),
      );

  }
}