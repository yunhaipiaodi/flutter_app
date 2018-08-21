import 'package:flutter/material.dart';


class TabItemView extends StatelessWidget{

  List<TabItemData> _dataSource;

  TabItemView(List<TabItemData> _dataSource){
    this._dataSource = _dataSource;
  }

  Widget _getItemView(TabItemData data){
    return Card(
        child: Column(
          children: <Widget>[
            Image.network(data.foodImageUrl),
            Row(children: <Widget>[
              Container(
                  child: Column(children: <Widget>[
                    Text(data.foodTitle,style: TextStyle(fontSize: 16.0),textAlign: TextAlign.left,),
                    Text("￥" + data.foodPrice,style: TextStyle(color: Color.fromARGB(255, 38, 200, 139),fontSize: 12.0),textAlign: TextAlign.left),
                      ],
                    crossAxisAlignment: CrossAxisAlignment.start,),
                  margin: EdgeInsets.only(left: 16.0),
              ),

              IconButton(icon: Icon(Icons.shopping_cart,color: Colors.blue,),onPressed: null,),
            ],
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            ),
          ],
        ),
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


class TabItemData{
    TabItemData(@required foodImageUrl,@required foodTitle,@required foodPrice){
      this.foodImageUrl = foodImageUrl;
      this.foodTitle = foodTitle;
      this.foodPrice = foodPrice;
    }

    String foodImageUrl;
    String foodTitle;
    String foodPrice;
}