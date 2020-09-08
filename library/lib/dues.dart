

import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:homepage/homelogin.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
class Dues extends StatefulWidget {
  @override
  _DuesState createState() => _DuesState();
}

class _DuesState extends State<Dues> {

  Future<Duelogs> temp;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    temp = fetchAllDues();

  }

  Future<Duelogs> fetchAllDues() async{
    final response = await http.get('http://127.0.0.1:5000/dues/');

    if(response.statusCode == 200){
      print(response.body);
      return Duelogs.get(json.decode(response.body));
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      appBar: AppBar(
        backgroundColor: black,
        leading: IconButton(
          onPressed: (){
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.home,color: white,),
        ),
      ),

      body: SingleChildScrollView(
        
        scrollDirection: Axis.vertical,
        physics: ClampingScrollPhysics(),
        padding: EdgeInsets.only(left:250,right:250,bottom: 20,top: 20),
        child: FutureBuilder(
          
          future: temp,
          builder: (context,data){
            return ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: ClampingScrollPhysics(),
              itemBuilder: (context,index){
                return simplelog(data.data.bid[index],data.data.cid[index],data.data.due[index]);
              }, 
              separatorBuilder: (context,index){
                return SizedBox(height: 20,);
              }, 
              itemCount: data.data.bid.length);
          },
        ),
      ),
    );
  }

  Widget simplelog(bid,cid,due){

    return Container(
      height: 80,
      child: Material(
        color: black,
        elevation: 6,
        borderRadius: BorderRadius.circular(10),
        
        child: Padding(
          padding: const EdgeInsets.only(left: 20,right: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(children: [
                          Text('Book id : ', style: TextStyle(color: white,fontWeight: FontWeight.w400),),
                          Text(bid, style: TextStyle(color: white,fontWeight: FontWeight.w600),),
                        ],),
                        SizedBox(height: 10,),
                        Row(children: [
                          Text('Issued to : ', style: TextStyle(color: white,fontWeight: FontWeight.w400),),
                          Text(cid, style: TextStyle(color: white,fontWeight: FontWeight.w500),),
                        ],),
              
              
            ],),
            Row(
            
            children: [
                        Text('Due for ', style: TextStyle(color: white,fontWeight: FontWeight.w400),),
                        Text(due + ' days', style: TextStyle(color: white,fontWeight: FontWeight.w500),),
                      ],),
                  ]
          ),
        ),
      ),
    );
  }
}



class Duelogs{
  List<String> bid;
  List<String> cid;
  List<String> due;

  Duelogs({this.bid,this.cid,this.due});

  factory Duelogs.get(json){
    String seperator = '_-_-_';
    return Duelogs(
      bid: json['bid'].split(seperator).toList(),
      cid: json['cid'].split(seperator).toList(),
      due: json['due'].split(seperator).toList(),

    );
  }

}