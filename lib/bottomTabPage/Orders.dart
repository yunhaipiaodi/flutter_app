import 'package:flutter/material.dart';
import 'package:flutter_app/listItem/OrderItemView.dart';

class Orders extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text("我的订单",style: TextStyle(color: Colors.white),),
          centerTitle: true,
          bottom: TabBar(tabs: [
            Tab(text: "待支付",),
            Tab(text: "未评价",),
            Tab(text: "退款",),
          ]),
        ),
        body: TabBarView(children:[
          OrderItemView(1),
          OrderItemView(2),
          OrderItemView(3),
        ]),
      ),
    );
  }

}
