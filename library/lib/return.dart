
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:homepage/homelogin.dart';


import 'package:http/http.dart' as http;
class Return extends StatefulWidget {
  @override
  _ReturnState createState() => _ReturnState();
}

class _ReturnState extends State<Return> {
  Color greentemp = Colors.greenAccent;
  Color whitetemp = black;
  final controller = TextEditingController();
  Future<ReturnInfo> temp;
  ReturnInfo temp2;
  Future<ReturnInfo> getStatus(bookid) async{
    String statement = 'http://127.0.0.1:5000/bookreturn/'+bookid;
    final response = await http.get(statement);
    if(response.statusCode == 200)
    {
      temp2 = ReturnInfo.get(json.decode(response.body));
      if(temp2.status){
       _showMyDialog('Returned with no dues');
      }
      else{
        _showMyDialog('is Due for '+temp2.days.toString()+' days');
      }
    }
    else{
      _showMyDialog('Unknown Error Occured');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      appBar: AppBar(
        backgroundColor: black,
        leading: IconButton(
          icon: Icon(Icons.home),
          color: white,
          onPressed: (){
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        color: black,
        padding: EdgeInsets.all(20),
        child: Material(
          color: black,
          elevation: 8,
          borderRadius: BorderRadius.circular(10),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(400, 180, 400, 180),
            child: Material(
              color: black,
              elevation: 8,
              borderRadius: BorderRadius.circular(10),
                child: Padding(
                  padding: const EdgeInsets.only(left:30,right:30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                  
                    children: [
                      Theme(
                        data: ThemeData(
                          primaryColor: white
                        ),
                        child: TextField(
                          controller: controller,
                          style: TextStyle(
                            color: white
                          ),
                          decoration: InputDecoration(
                            labelText: 'Book Id',
                            labelStyle: TextStyle(color: white),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      SizedBox(height: 15,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                        Text('Fines ?',style: TextStyle(color: white),),
                        SizedBox(width: 10,),
                        SizedBox(
                          child: Row(
                            children: [
                              FlatButton(
                                color: greentemp,
                                child: Text('Yes',style: TextStyle(color: whitetemp),),
                                onPressed: (){
                                  setState(() {
                                    greentemp = Colors.greenAccent;
                                    whitetemp = black;
                                  });
                                },
                              ),
                              FlatButton(
                                color: whitetemp,
                                child: Text('No',style: TextStyle(color: greentemp),),
                                onPressed: (){
                                  setState(() {
                                    greentemp = black;
                                    whitetemp = Colors.greenAccent;
                                  });
                                },
                              )

                            ],
                          ),
                        )
                      ],),
                      SizedBox(height: 15,),
                      SizedBox(
                        height: 30,
                        width: 130,
                        child: RaisedButton(
                          onPressed: () async{
                            if(controller.text.isNotEmpty){
                              await getStatus(controller.text);
                            }
                            else{
                              _showMyDialog('Enter Book id');
                            }
                          },
                          elevation: 6,
                          color: black,
                          child: Text('Return',style: TextStyle(color: white),),
                        ),
                      )
                  ],),
                ),
            ),
          ),

        ),

      ),
    );
  }
  Future<void> _showMyDialog(textinfo) async {
    return showDialog<void>
    (
      barrierDismissible: false, // user must tap button!
      context: context,
      builder: (BuildContext context) 
      {
        return AlertDialog
        (
          backgroundColor: black,
          elevation: 10,
          title: Text('Status',style: TextStyle(color:Colors.red),),
          content: SingleChildScrollView(
            
            child: ListBody(

              children: <Widget>[
                Text(textinfo,style: TextStyle(color: white),),
              ],
            ),
          ),
          actions: <Widget>[
            RaisedButton
            (
              color: black,
              hoverColor: black,
              focusColor: black,
              //autofocus: true,
              elevation: 14,
              child: Text
              (
                'Ok',
                style: TextStyle
                (
                  color: white,
                  //backgroundColor: Colors.blue[100]
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class ReturnInfo {
  int days;
  bool status;

  ReturnInfo({this.days,this.status});

  factory ReturnInfo.get(json){
    return ReturnInfo(
      days: json['days'],
      status: json['status']
    );
  }

  
}