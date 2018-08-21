import 'package:flutter/material.dart';
import 'package:flutter_app/listItem/OrderItemView.dart';

class Orders extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    List<OrderItemData> _getDataSource(){
      List<OrderItemData> dataSource = List<OrderItemData>();
      dataSource.add(OrderItemData(
          "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1534305231&di=d562abad15ca34cb737899812041ac44&imgtype=jpg&er=1&src=http%3A%2F%2Fimg1.gtimg.com%2Fcq%2Fpics%2Fhv1%2F145%2F134%2F2188%2F142309015.jpg",
          "芝士鱿鱼",
          "25"));
      dataSource.add(OrderItemData(
          "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1534305231&di=d562abad15ca34cb737899812041ac44&imgtype=jpg&er=1&src=http%3A%2F%2Fimg1.gtimg.com%2Fcq%2Fpics%2Fhv1%2F145%2F134%2F2188%2F142309015.jpg",
          "芝士鱿鱼",
          "25"));
      dataSource.add(OrderItemData(
          "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1534305231&di=d562abad15ca34cb737899812041ac44&imgtype=jpg&er=1&src=http%3A%2F%2Fimg1.gtimg.com%2Fcq%2Fpics%2Fhv1%2F145%2F134%2F2188%2F142309015.jpg",
          "芝士鱿鱼",
          "25"));
      dataSource.add(OrderItemData(
          "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1534305231&di=d562abad15ca34cb737899812041ac44&imgtype=jpg&er=1&src=http%3A%2F%2Fimg1.gtimg.com%2Fcq%2Fpics%2Fhv1%2F145%2F134%2F2188%2F142309015.jpg",
          "芝士鱿鱼",
          "25"));
      dataSource.add(OrderItemData(
          "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1534305231&di=d562abad15ca34cb737899812041ac44&imgtype=jpg&er=1&src=http%3A%2F%2Fimg1.gtimg.com%2Fcq%2Fpics%2Fhv1%2F145%2F134%2F2188%2F142309015.jpg",
          "芝士鱿鱼",
          "25"));
      dataSource.add(OrderItemData(
          "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1534305231&di=d562abad15ca34cb737899812041ac44&imgtype=jpg&er=1&src=http%3A%2F%2Fimg1.gtimg.com%2Fcq%2Fpics%2Fhv1%2F145%2F134%2F2188%2F142309015.jpg",
          "芝士鱿鱼",
          "25"));
      dataSource.add(OrderItemData(
          "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1534305231&di=d562abad15ca34cb737899812041ac44&imgtype=jpg&er=1&src=http%3A%2F%2Fimg1.gtimg.com%2Fcq%2Fpics%2Fhv1%2F145%2F134%2F2188%2F142309015.jpg",
          "芝士鱿鱼",
          "25"));
      return dataSource;
    }
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text("我的订单",style: TextStyle(color: Colors.white),),
          centerTitle: true,
          bottom: TabBar(tabs: [
            Tab(text: "未完成",),
            Tab(text: "未评价",),
            Tab(text: "退款",),
          ]),
        ),
        body: TabBarView(children:[
          OrderItemView(_getDataSource()),
          OrderItemView(_getDataSource()),
          OrderItemView(_getDataSource()),
        ]),
      ),
    );
  }

}
