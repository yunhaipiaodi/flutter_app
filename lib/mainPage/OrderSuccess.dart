import 'package:flutter/material.dart';

class OrderSuccess extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("订购成功"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text("您的订单成功了!",style: TextStyle(fontSize: 18.0,),),
            RaisedButton(
              child: Text("返回",style: TextStyle(color: Colors.white),),
              color: Colors.blue,
              onPressed: (){
                Navigator.pushNamed(context, '/');
              },
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ),
    );
  }

}