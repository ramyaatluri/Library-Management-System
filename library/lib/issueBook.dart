

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homepage/homelogin.dart';
import 'package:homepage/homepage.dart';
import 'package:http/http.dart' as http;

class IssueBook extends StatefulWidget{

  @override
  Issuebook createState() => Issuebook();
}

class Issuebook extends State<IssueBook>{

  Future<CustomersData> customersData;
  Future<BookStatus> bookstatus;
  bool isname = true;
  bool isphone = true;
  bool isrollno = true;
  bool isIssueBook = false;
  bool isIssuedBook = false;
  bool isLogs = false;
  bool isCustomer = false;
  bool isAddCostumer = false;

  final bookid = new TextEditingController();
  final customerid = new TextEditingController();
  bool isbookid = true;
  bool iscustomerid = true;
  @override
  void initState() {
    super.initState();
    customersData = getData();
    bookstatus = getBookData();

  }

  Future<CustomersData> getData() async{
    final  response = await http.get('http://127.0.0.1:5000/getcustomers/');

    if(response.statusCode== 200){
      return CustomersData.get(json.decode(response.body));
    }

  }
  Future<BookStatus> getBookData() async{
    final response = await http.get('http://127.0.0.1:5000/getbookstatus/');
    if (response.statusCode == 200){
      return BookStatus.get(json.decode(response.body));
    }
  }
  final name = new TextEditingController();
    final phone = new TextEditingController();
    final rollno = new TextEditingController();
  @override
  Widget build(BuildContext context){
    return Material(
      color: black,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: black,
          leading: IconButton(icon: Icon(Icons.home,color: white,),
          onPressed: (){
            Navigator.of(context).pop();
          },
          ),
          centerTitle: true,
          title: Text('Book Issue',style: TextStyle(color: white),),
          
        ),
        body: Container(
          color: black,
          padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
          child: Material(
            color: Colors.transparent,
            elevation: 14,
            child: Material(
              borderRadius: BorderRadius.circular(10),
              elevation: 14,
              color: black,
              child: Row(
                
                children: [
                  Container(height: 1000,width: 250,color:
                   Colors.transparent,
                   child:leftContainer(),
                   ),
                  Container(height: 1000,width: 740,color: Colors.transparent,
                  child: mainContainer(),),
                  Container(height: 1000,width: 250,color: Colors.transparent,
                  child: rightContainer(),),
                ],
              ),
            ),
          ),),
      ),
    );
  }

  Widget leftContainer(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 150,
            child: RaisedButton(
            elevation: 14,
            onPressed: (){setState(() {
              isIssueBook = false;
                isIssuedBook = !isIssuedBook;
                isLogs = false;
                isCustomer = false;
                isAddCostumer = false;
            });},
            color: black,
            child: Text('Issued',style: TextStyle(color: white),),
          ),
        ),
        SizedBox(
          width: 150,
            child: RaisedButton(
            elevation: 14,
            onPressed: (){
              setState(() {
                isIssueBook = !isIssueBook;
                isIssuedBook = false;
                isLogs = false;
                isCustomer = false;
                isAddCostumer = false;
              });
            },
            color: black,
            child: Text('Issue',style: TextStyle(color: white),),
          ),
        ),
        SizedBox(
          width: 150,
            child: RaisedButton(
            elevation: 14,
            onPressed: (){setState(() {
              isIssueBook = false;
                isIssuedBook = false;
                isLogs = false;
                isCustomer = !isCustomer;
                isAddCostumer = false;
            });},
            color: black,
            child: Text('Customers',style: TextStyle(color: white),),
          ),
        ),
        SizedBox(
          width: 150,
            child: RaisedButton(
            elevation: 14,
            onPressed: (){setState(() {
              isIssueBook = false;
                isIssuedBook = false;
                isLogs = !isLogs;
                isCustomer = false;
                isAddCostumer = false;
            });},
            color: black,
            child: Text('Logs',style: TextStyle(color: white),),
          ),
        ),
        SizedBox(
          height: 50,
        ),
        SizedBox(
          width: 150,
            child: RaisedButton(
            elevation: 14,
            onPressed: (){setState(() {
              isIssueBook = false;
                isIssuedBook = false;
                isLogs = false;
                isCustomer = false;
                isAddCostumer = !isAddCostumer;
            });},
            color: black,
            child: Text('Add Customer',style: TextStyle(color: white),),
          ),
        )
      ],);
  }
  StatefulWidget mainContainer(){
    return Material(
      color: black,
          child: Stack(children: [
        bottomDesignRight(),
        bottomDesignLeft(),
        issuedBookLayer(),
        issueBookLayer(),
         logsLayer(),
        customersLayer(),
        addCosumrLayer(),

      ],),
    );
  }
  Widget rightContainer(){}

  Widget issuedBookLayer(){
    return AnimatedPositioned(
      top: isIssuedBook ? 40 : -540,
      bottom: isIssuedBook ? 40 : 580,
      left: 40,
      right: 40,
      duration: Duration(milliseconds: 800),
      child: Material(
        color: black,
        borderRadius: BorderRadius.circular(10),
        elevation: 14,
        child: Container(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
          height: 500,
          width: 500,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.center,
               mainAxisAlignment: MainAxisAlignment.start,
               children:[
                FutureBuilder(
                future: bookstatus,
                builder:(context,snapdata) {
                  if (snapdata.hasData){
                    return ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context,index){
                        return ListTile(
                          title: Text(snapdata.data.bookid[index],style: TextStyle(color: white),),
                          subtitle: Text('Issued to :'+snapdata.data.customerid[index],style: TextStyle(color: white),),
                          trailing: 
                            Text(snapdata.data.date[index],style: TextStyle(color: white),)
                         
                        );
                      }, 
                      separatorBuilder: 
                      (context,index){
                        return Divider(thickness: 1);
                      }, 
                      itemCount: snapdata.data.bookid.length);
                  }
                  return CircularProgressIndicator(
                    strokeWidth: 2,
                  );
                
                },),]
             ),
          ),
        )
        ),
    );
  }
  StatefulWidget issueBookLayer(){

     return AnimatedPositioned(
      top: isIssueBook ? 40: 580,
      bottom: isIssueBook ? 40:-540,
      left: 40,
      right: 40,
      duration: Duration(milliseconds: 800),
      child: Material(
        color: black,
        borderRadius: BorderRadius.circular(10),
        elevation: 14,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(100,40,100,40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Theme(
                data: ThemeData(primaryColor: white),
                child: TextField(
                  controller: bookid,
                  cursorColor: white,
                  style: TextStyle(color: white),
                  decoration: InputDecoration(
                    labelText: 'Book Id / ISBN',
                    labelStyle: TextStyle(color: white,),
                    errorText: isbookid ? null : 'Mandatory field',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: white)
                    )
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Theme(
                data: ThemeData(primaryColor: white),
                child: TextField(
                  controller: customerid,
                  cursorColor: white,
                  style: TextStyle(color: white),
                  decoration: InputDecoration(
                    labelText: 'Student Id',
                    labelStyle: TextStyle(color: white,),
                    errorText: iscustomerid ? null : 'Mandatory field',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: white)
                    )
                  ),
                ),
              ),
              SizedBox(
                height: 60,
              ),
              SizedBox(
                height: 40,
                width: 200,
                child: RaisedButton(
                  elevation: 10,
                  color: black,
                  child: Text('Issue',style: TextStyle(color: white),),
                  onPressed: (){
                    res(s) async{
                    final response= await http.get('http://127.0.0.1:5000/bookstatus/'+s);
                    if (response.body=="done"){
                        _showMyDialog('Issued');

                    }
                    else{
                      _showMyDialog(response.body);
                    }
                    }
                    setState(() {
                      isbookid = bookid.text.isNotEmpty;
                      iscustomerid = customerid.text.isNotEmpty;
                      if(isbookid && iscustomerid){
                        String s = bookid.text+'_-_-_'+customerid.text;
                        //initState();
                        res(s);
                      }
                    });
                  },
                ),
              )
            ],
            ),
        ),
      ),
    );
  }
  Widget logsLayer(){
     return AnimatedPositioned(
      top: 40,
      bottom: 40,
      left: isLogs ? 40 :800,
      right: isLogs ? 40 : -720,
      duration: Duration(milliseconds: 800),
      child: Material(
        color: black,
        borderRadius: BorderRadius.circular(10),
        elevation: 14,
        child: Container(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
          height: 500,
          width: 500,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.center,
               mainAxisAlignment: MainAxisAlignment.start,
               children:[
                FutureBuilder(
                future: bookstatus,
                builder:(context,snapdata) {
                  if (snapdata.hasData){
                    return ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context,index){
                        return Text(
                          'Book id : '+snapdata.data.bookid[index]+' is issued to : '+snapdata.data.customerid[index]+' on '+snapdata.data.date[index],
                          style: TextStyle(color: white),
                          overflow: TextOverflow.ellipsis,
                        );
                         
                        
                      }, 
                      separatorBuilder: 
                      (context,index){
                        return Divider(thickness: 1);
                      }, 
                      itemCount: snapdata.data.bookid.length);
                  }
                  return CircularProgressIndicator(
                    strokeWidth: 2,
                  );
                
                },),]
             ),
          ),
        )
      ),
    );
  }
  Widget customersLayer(){
     return AnimatedPositioned(
      top: 40,
      bottom: 40,
      left: isCustomer ? 40: -720,
      right: isCustomer ? 40: 800,
      duration: Duration(milliseconds: 800),
      child: Material(
        color: black,
        borderRadius: BorderRadius.circular(10),
        elevation: 14,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
               height: 400,
               width: 600,
                 child: FutureBuilder(
                   future: customersData,
                   builder: (context,snapshot){
                     if(snapshot.hasData){
                       return SingleChildScrollView(
                         scrollDirection: Axis.vertical,
                         physics: ClampingScrollPhysics(),
                           child: ListView.separated(
                            shrinkWrap: true, 
                           itemBuilder: (context,index){
                            return ListTile(
                               title: Text(snapshot.data.name[index],style: TextStyle(color: white),),
                               subtitle: Text(snapshot.data.phone[index],style: TextStyle(color: white),),
                               contentPadding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                               leading: Icon(Icons.person,color: white,size: 20,),
                               trailing: Text(snapshot.data.rollno[index],style: TextStyle(color: white),),

                             );
                           }, 
                           separatorBuilder: (context,ind){
                            return Divider(height: 0.05,color: white,thickness: 0.3,);
                           }, 
                           itemCount: snapshot.data.name.length),
                       );
                     }
                     return CircularProgressIndicator(
                       strokeWidth: 5,
                       backgroundColor: black,
                       
                     );
                   },
                 ),
               )
            ],
          ),
        ),
      ),
    );
  }
  StatefulWidget addCosumrLayer(){
    
     return AnimatedPositioned(
      top: isAddCostumer ? 40 : -540,
      bottom: isAddCostumer ? 40: 580,
      left: isAddCostumer ?40 :-720,
      right: isAddCostumer ?40 : 800,
      duration: Duration(milliseconds: 800),
      child: Material(
        color: black,
        borderRadius: BorderRadius.circular(10),
        elevation: 14,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(160,60,160,60),
          child: Material(
            color: black,
            elevation: 14,
            borderRadius: BorderRadius.circular(10),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(40,40,40,10),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Theme( data: ThemeData(primaryColor: white,primaryColorDark: white),
                       child: TextField(
                         controller: name,
                        cursorColor: white,
                        style: TextStyle(color: white),
                        decoration: InputDecoration(
                          labelText: 'Name',
                          labelStyle: TextStyle(color: white),
                          errorText: isname ? null : 'fill this detail',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: white),
                            borderRadius: BorderRadius.circular(10)
                            )
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Theme( data: ThemeData(primaryColor: white,primaryColorDark: white),
                       child: TextField(
                         controller: rollno,
                        cursorColor: white,
                        style: TextStyle(color: white),
                        decoration: InputDecoration(
                          labelText: 'Roll Number',
                          labelStyle: TextStyle(color: white),
                          errorText: isrollno ? null : 'fill this detail',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: white),
                            borderRadius: BorderRadius.circular(10)
                          )
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Theme( data: ThemeData(primaryColor: white,primaryColorDark: white),
                       child: TextField(
                         controller: phone,
                        cursorColor: white,
                        style: TextStyle(color: white),
                        decoration: InputDecoration(
                          labelText: 'Phone Number',
                          labelStyle: TextStyle(color: white),
                          errorText:  isphone ? null : 'fill this detail',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: white),
                            borderRadius: BorderRadius.circular(10)
                          )
                        ),
                      ),
                    ),
                    SizedBox(height: 30,),
                    SizedBox(
                        height: 50,
                        width: 160,
                        child: RaisedButton(
                        color: black,
                        elevation: 14,
                        child: Text('Register',style: TextStyle(color: white),),
                        onPressed: () async {
                          print(isname);
                          res(s) async{
                            final response=await http.get('http://127.0.0.1:5000/addcustomer/'+s);
                            if (response.body=='Already')
                            {
                              _showMyDialog("User already exists!");
                            }
                            else{_showMyDialog('User Added');}
                          }
                          setState(() {
                           // print(isname);
                          isname = name.text.isNotEmpty;
                          print(name.text.isNotEmpty);
                          isrollno = rollno.text.isNotEmpty;
                          isphone = phone.text.isNotEmpty;
                          if (isname && isrollno && isphone) {
                            String d = '_-_-_';
                            String s = name.text+d+rollno.text+d+phone.text;
                            res(s);
                            
                            //initState();
                          }
                          //print(isphone);
                        }
                        );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget bottomDesignRight(){
    return AnimatedPositioned(
      top: 40,
      bottom: 40,
      left: 40,
      right: 40,
      duration: Duration(milliseconds: 300),
      child: Transform.rotate(
        angle: 0.05,
        child: Material(
          color: black,
          borderRadius: BorderRadius.circular(10),
          elevation: 14,
        ),
      ),
    );
  }
  Widget bottomDesignLeft(){
    return AnimatedPositioned(
      top: 40,
      bottom: 40,
      left: 40,
      right: 40,
      duration: Duration(milliseconds: 300),
      child: Transform.rotate(
          angle: -0.05,
          child: Material(
          color: black,
          borderRadius: BorderRadius.circular(10),
          elevation: 14,
        ),
      ),
    );
  }

  Future<void> _showMyDialog(textinfo) async {
    return showDialog<void>
    (
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) 
      {
        return AlertDialog
        (
          backgroundColor: black,
          elevation: 10,
          title: Text('Submission',style: TextStyle(color:white),),
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

class CustomersData {
  List<String> name;
  List<String> rollno;
  List<String> phone;
  int length;
  CustomersData({this.name,this.rollno,this.phone,this.length});

  factory CustomersData.get(json){
    return CustomersData(
      name: json['name'].split('_-_-_'),
      rollno: json['rollno'].split('_-_-_'),
      phone: json['phone'].split('_-_-_'),
      length: json['name'].split('_-_-_').length,
    );
  }
}

class BookStatus{
  List<String> bookid;
  List<String> customerid;
  List<String> date;

  BookStatus({this.bookid,this.customerid,this.date});

  factory BookStatus.get(json){
    return BookStatus(
      bookid: json['bookid'].split('_-_-_'),
      customerid:json['customerid'].split('_-_-_'),
      date: json['date'].split('_-_-_')
    );
  }
}