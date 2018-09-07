import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class OrderDetailPage extends StatefulWidget{
  @override
  OrderDetailState createState() => OrderDetailState();
}

class OrderDetailState extends State<OrderDetailPage>{

  int _selectValue = 0;

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
        title: Text("填写订单"),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: <Widget>[

            //receiver message
            Container(
              child: Row(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text("文迪",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18.0),),
                          Container(
                            child: Text("159****1876",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18.0),),
                            margin: const EdgeInsets.only(left: 16.0),
                          ),
                        ],
                        mainAxisAlignment: MainAxisAlignment.start,
                      ),
                      Row(
                        children: <Widget>[
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
                          Container(
                            child: Text("广东省广州市天河区 元岗路310号自编3栋c213单元",style: TextStyle(fontSize: 12.0),),
                            margin: const EdgeInsets.only(left: 16.0),
                            width: 220.0,
                          ),
                        ],
                        mainAxisAlignment: MainAxisAlignment.start,
                      ),
                    ],
                    crossAxisAlignment: CrossAxisAlignment.start,
                  ),

                  IconButton(
                    icon: Icon(Icons.arrow_forward_ios,color: Colors.grey,),
                    onPressed: (){

                    },
                  ),

                ],
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              ),
              padding: EdgeInsets.only(left: 16.0,top:16.0,bottom: 16.0,),
              color: Colors.white,
            ),

            //cuisine
            Container(
              child: Row(
                children: <Widget>[
                  Image.network(
                    "http://yunhaipiaodi.gz01.bdysite.com/AppServer/cuisine_img/5b7e1610f3629.jpg",
                    width: 80.0,
                    height: 45.0,
                  ),

                 Column(
                   children: <Widget>[
                     Text("攸县香干",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18.0),),
                     Text("￥56",style: TextStyle(color: Colors.blue,),),
                   ],
                   crossAxisAlignment: CrossAxisAlignment.end,
                 ),
                ],
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              ),
              padding: EdgeInsets.only(left: 16.0,top: 8.0,right: 16.0,bottom: 8.0,),
              margin: EdgeInsets.only(top:16.0),
              color: Colors.white,
            ),

            //pay mode
            Container(
              child:Row(
                children: <Widget>[
                  Text("支付方式",style: TextStyle(fontSize: 18.0),),
                ],
              ),
              padding: EdgeInsets.only(left: 16.0,top: 8.0,right: 16.0,bottom: 8.0,),
              margin: EdgeInsets.only(top:16.0),
              color: Colors.white,
            ),
            Divider(
              color: Color.fromARGB(255, 143, 143, 143),
              height: 1.0,
            ),
            Container(
              child: ListTile(
                leading: Icon(FontAwesomeIcons.weixin,color: Colors.blue,),
                title: Text("微信支付"),
                selected: _selectValue == 0?true:false,
                trailing: Radio(
                  value: 0,
                  groupValue: _selectValue,
                  onChanged: (int value){
                    setState(() {
                      _selectValue = value;
                    });
                  },
                ),
              ),
              color: Colors.white,
            ),
            Divider(
              color: Color.fromARGB(255, 143, 143, 143),
              height: 1.0,
            ),
            Container(
              child: ListTile(
                leading: Icon(IconData(0xe802, fontFamily: "ali"),color: Colors.blue,),
                title: Text("支付宝"),
                selected: _selectValue == 1?true:false,
                trailing: Radio(
                  value: 1,
                  groupValue: _selectValue,
                  onChanged: (int value){
                    setState(() {
                      _selectValue = value;
                    });
                  },
                ),
              ),
              color: Colors.white,
            ),
            Divider(
              color: Color.fromARGB(255, 143, 143, 143),
              height: 1.0,
            ),
            Container(
              child: ListTile(
                leading: Icon(FontAwesomeIcons.creditCard,color: Colors.blue,),
                title: Text("银行卡"),
                selected: _selectValue == 2?true:false,
                trailing: Radio(
                  value: 2,
                  groupValue: _selectValue,
                  onChanged: (int value){
                    setState(() {
                      _selectValue = value;
                    });
                  },
                ),
              ),
              color: Colors.white,
            ),
            Divider(
              color: Color.fromARGB(255, 143, 143, 143),
              height: 1.0,
            ),

            Container(
              child: RaisedButton(
                color: Colors.blue,
                child: Row(
                  children: <Widget>[
                    Text("提交订单",style: TextStyle(color: Colors.white,fontSize: 18.0),),
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
                onPressed: (){

                },
              ),
              padding: const EdgeInsets.only(left: 16.0,right: 16.0),
              margin: const EdgeInsets.only(top:100.0),
            ),
          ],
        ),
        color: Color.fromARGB(255, 243, 241, 244),
      )
    );
  }

}