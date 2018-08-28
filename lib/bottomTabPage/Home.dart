import 'package:flutter/material.dart';
import 'package:flutter_app/listItem/TabItemView.dart';

class Home extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return DefaultTabController(
        length: 5,
        child: Scaffold(
        appBar: new AppBar(
          leading: IconButton(icon: Icon(Icons.search,color: Colors.white,), onPressed: (){
            Navigator.pushNamed(context,'/search');
          }),
          title:const Text("拾味",style: TextStyle(color: Colors.white),),
          actions: <Widget>[
            IconButton(icon:Icon(IconData(0xe96b,fontFamily: "icomoon"),color: Colors.white,),onPressed: null,iconSize: 18.0,),
          ],
          centerTitle: true,
          bottom: TabBar(tabs: [
            Tab(text:"早餐"),
            Tab(text:"午餐"),
            Tab(text:"甜点"),
            Tab(text:"晚餐"),
            Tab(text:"夜宵"),
          ]),
        ),
        body: TabBarView(children:[
          TabItemView(1),
          TabItemView(2),
          TabItemView(3),
          TabItemView(4),
          TabItemView(5),
        ]),

      ),);

  }

}