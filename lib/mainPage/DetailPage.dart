import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget{

  DetailPage();

  @override
  DetailState createState() => DetailState();
}


class DetailState extends State<DetailPage>{

  Widget _getCommendItem(int index){
    return Container(
      child: Row(
        children: <Widget>[
          CircleAvatar(backgroundImage: NetworkImage("http://a.hiphotos.baidu.com/zhidao/pic/item/21a4462309f79052782f28490ff3d7ca7bcbd591.jpg"),),
          Container(
            child: Column(
              children: <Widget>[
                Row(children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text("梅川内酷",style: TextStyle(fontSize: 16.0,color: Colors.black),),
                      Container(
                        child: Text("2018.08.29",style: TextStyle(fontSize: 12.0,),),
                        margin: EdgeInsets.only(top:8.0),
                      ),
                    ],
                  ),
                  IconButton(icon:Icon(Icons.thumb_up),onPressed: null,),
                ],
                ),
                Text("这个菜好辣，好爽;一口气吃了三碗饭；不能吃辣的还是别轻易尝试；店家服务很好，服务小哥很帅",style: TextStyle(fontSize: 12.0,color: Colors.black),),
              ],
            ),
            margin: EdgeInsets.only(left: 16.0),
          ),
        ],
      ),
      margin: EdgeInsets.only(top:16.0),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                color: Colors.grey,
                width: 1.0,
              )
          )
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Column(
        children: <Widget>[
          //top cuisine image
          Stack(
            children: <Widget>[
              Container(
                child:  Image.network(
                  'http://imgsrc.baidu.com/imgad/pic/item/4ec2d5628535e5dd8a5881f87cc6a7efce1b62a4.jpg',
                  fit: BoxFit.fill,
                ),
                height: 265.0,
              ),
              Container(
                child: IconButton(icon: Icon(Icons.arrow_back,color: Colors.white,), onPressed: null),
                height: 265.0,
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(left: 16.0,top:MediaQuery.of(context).padding.top + 8.0),
              ),
            ],
          ),
          //detail information
          Container(
            child: Column(
              children: <Widget>[
                Text("好辣的鸡",style: TextStyle(fontSize: 28.0,color: Colors.black,fontWeight: FontWeight.bold),),
                Container(
                  child: Text("月售 180 赞 20 好评度 100",style: TextStyle(fontSize: 12.0,),),
                  margin: EdgeInsets.only(top:8.0),
                ),
                Container(
                  child: Text("￥20.0",style: TextStyle(fontSize: 24.0,color: Colors.blue),),
                  margin: EdgeInsets.only(top:16.0),
                ),
                Container(
                  child: Text("商品描述",style: TextStyle(fontSize: 20.0,color: Colors.black),),
                  margin: EdgeInsets.only(top:16.0),
                ),
                Container(
                  child: Text("暂无商品描述",style: TextStyle(fontSize: 12.0,),),
                  margin: EdgeInsets.only(top:8.0),
                ),
                Container(
                  child: Text("评论",style: TextStyle(fontSize: 20.0,color: Colors.black),),
                  margin: EdgeInsets.only(top:16.0),
                ),
                
                //comment list
                Expanded(
                  child: ListView.builder(
                      itemCount: 5,
                      itemBuilder: (BuildContext context,int index) => _getCommendItem(index),
                  ),
                )
              ],
            ),
            margin: EdgeInsets.only(left: 16.0,top:16.0,right: 16.0),
          ),
        ],
      ),
    );
  }

}