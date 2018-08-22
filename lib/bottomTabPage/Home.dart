import 'package:flutter/material.dart';
import 'package:flutter_app/listItem/TabItemView.dart';

class Home extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    List<TabItemData> _getDataSource(){
      List<TabItemData> dataSource = List<TabItemData>();
      dataSource.add(TabItemData(
          "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1534305231&di=d562abad15ca34cb737899812041ac44&imgtype=jpg&er=1&src=http%3A%2F%2Fimg1.gtimg.com%2Fcq%2Fpics%2Fhv1%2F145%2F134%2F2188%2F142309015.jpg",
          "芝士鱿鱼",
          "25"));
      dataSource.add(TabItemData(
          "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1534305231&di=d562abad15ca34cb737899812041ac44&imgtype=jpg&er=1&src=http%3A%2F%2Fimg1.gtimg.com%2Fcq%2Fpics%2Fhv1%2F145%2F134%2F2188%2F142309015.jpg",
          "芝士鱿鱼",
          "25"));
      dataSource.add(TabItemData(
          "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1534305231&di=d562abad15ca34cb737899812041ac44&imgtype=jpg&er=1&src=http%3A%2F%2Fimg1.gtimg.com%2Fcq%2Fpics%2Fhv1%2F145%2F134%2F2188%2F142309015.jpg",
          "芝士鱿鱼",
          "25"));
      dataSource.add(TabItemData(
          "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1534305231&di=d562abad15ca34cb737899812041ac44&imgtype=jpg&er=1&src=http%3A%2F%2Fimg1.gtimg.com%2Fcq%2Fpics%2Fhv1%2F145%2F134%2F2188%2F142309015.jpg",
          "芝士鱿鱼",
          "25"));
      dataSource.add(TabItemData(
          "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1534305231&di=d562abad15ca34cb737899812041ac44&imgtype=jpg&er=1&src=http%3A%2F%2Fimg1.gtimg.com%2Fcq%2Fpics%2Fhv1%2F145%2F134%2F2188%2F142309015.jpg",
          "芝士鱿鱼",
          "25"));
      dataSource.add(TabItemData(
          "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1534305231&di=d562abad15ca34cb737899812041ac44&imgtype=jpg&er=1&src=http%3A%2F%2Fimg1.gtimg.com%2Fcq%2Fpics%2Fhv1%2F145%2F134%2F2188%2F142309015.jpg",
          "芝士鱿鱼",
          "25"));
      dataSource.add(TabItemData(
          "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1534305231&di=d562abad15ca34cb737899812041ac44&imgtype=jpg&er=1&src=http%3A%2F%2Fimg1.gtimg.com%2Fcq%2Fpics%2Fhv1%2F145%2F134%2F2188%2F142309015.jpg",
          "芝士鱿鱼",
          "25"));
      return dataSource;
    }

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
          TabItemView(),
          TabItemView(),
          TabItemView(),
          TabItemView(),
          TabItemView(),
        ]),

      ),);

  }

}