import 'package:flutter/material.dart';


class OrderItemView extends StatelessWidget{

  List<OrderItemData> _dataSource;

  OrderItemView(List<OrderItemData> _dataSource){
    this._dataSource = _dataSource;
  }

  Widget _getItemView(OrderItemData data){
    return Card(
      child: Container(
          margin: EdgeInsets.all(16.0),
          child: Row(
            children: <Widget>[
              Row(children: <Widget>[
                Image.network(data.foodImageUrl,width: 90.0,height: 90.0,fit: BoxFit.cover ,),
                Container(child: Column(
                  children: <Widget>[
                    Text(data.foodTitle,style: TextStyle(fontSize: 16.0),textAlign: TextAlign.left,),
                    Text("￥" + data.foodPrice,style: TextStyle(color: Color.fromARGB(255, 38, 200, 139),fontSize: 16.0),textAlign: TextAlign.left),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  ),
                  height: 90.0,
                  margin: EdgeInsets.only(left: 8.0),
                  ),
                ],
              ),
              RaisedButton(onPressed: (){

                },
                child: Text("支付"),
                color: Colors.blue,
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
          ),
      )
     
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView.builder(
      itemCount: _dataSource.length,
      itemBuilder: (buildContext,index) => _getItemView(_dataSource[index]),
    );
  }

}


class OrderItemData{
  OrderItemData(@required foodImageUrl,@required foodTitle,@required foodPrice){
    this.foodImageUrl = foodImageUrl;
    this.foodTitle = foodTitle;
    this.foodPrice = foodPrice;
  }

  String foodImageUrl;
  String foodTitle;
  String foodPrice;
}