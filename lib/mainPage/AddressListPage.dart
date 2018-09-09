import 'package:flutter/material.dart';

class AddressListPage extends StatefulWidget{
  @override
  AddressState createState() => AddressState();
}

class AddressState extends State<AddressListPage>{

  Widget _buildAddressListItem(int index){
    return Container(
      child: ListTile(
        leading: Radio(value: null, groupValue: null, onChanged: null),
        title: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text("许文迪",style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold),),
                Text("15918426146",style: TextStyle(fontSize: 14.0,),),
                Container(
                  height: 12.0,
                  child: Text("默认",style: TextStyle(color: Colors.white,fontSize: 10.0),),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(6.0)),
                    color: Colors.red,
                  ),
                  padding: EdgeInsets.only(left: 6.0,right: 6.0),
                  margin: EdgeInsets.only(right: 4.0,top:4.0),
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            ),
            Container(
              child: Text("广东省广州市天河区 元岗路310号自编3栋c213单元",style: TextStyle(fontSize: 12.0),),
              width: 200.0,
            ),
          ],
        ),
        trailing: IconButton(icon: Icon(Icons.edit,color: Colors.blue,), onPressed: (){}),
      ),
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color:Colors.grey))),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: (){
              Navigator.pop(context);
            }
        ),
        title: Text("地址管理"),
        centerTitle: true,
      ),
      body:
      Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (BuildContext context,int index) => _buildAddressListItem(index),
            ),
          ),

          Container(
            child:  RaisedButton(
              color:Colors.blue,
              child: Row(
                children: <Widget>[
                  Text("+ 新建收货地址",style: TextStyle(fontSize: 18.0,color: Colors.white),),
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
              onPressed: (){
                  Navigator.pushNamed(context, '/add_address');
              },
            ),
            margin: EdgeInsets.only(top:16.0,left: 16.0,right: 16.0),
          ),
        ],
      ),
    );
  }

}