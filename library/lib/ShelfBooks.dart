

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:homepage/homelogin.dart';
import 'package:homepage/bookStorage.dart';
import 'bookClass.dart';
import 'package:http/http.dart' as http;

Future<futureBookDetails> fetchBookDetails() async {
  
  String whereclass = '';
  
  //final response = await http.get('http://127.0.0.1:5000/database/insert/bookDetails');
  bookDetails temp;
  String divider = '_-_-_';
  final response = await http.get(
      'http://127.0.0.1:5000/database/racks/bookdetails/' + rackno.toString()+
          divider +
          shelfno.toString());
  //print(response.body);
  if (response.statusCode == 200) {
    temp = bookDetails.fromJson(json.decode(response.body));
    print(temp);
    return futureBookDetails.from(temp);
  } else {
    throw Exception('Failed to load data');
  }
}
class Shelfbooks extends StatefulWidget {
  @override
  _ShelfbooksState createState() => _ShelfbooksState();
}

class _ShelfbooksState extends State<Shelfbooks> {

  bool isclicked = false;
  futureBookDetails data1;
  int ind = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(rackno);
    print(shelfno);
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        
      home: Container(
    decoration: BoxDecoration(
      image: DecorationImage(
        image: NetworkImage('https://theawesomedaily.com/wp-content/uploads/2018/07/cool-backgrounds-feat-1-620x350.jpg')
        ,fit: BoxFit.cover

      )
    ),
    child: Stack(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                              child: Column(
                   children: [
                      Container(
          child: FloatingActionButton(
            backgroundColor: Colors.black.withOpacity(0.7),
            child: Icon(Icons.arrow_back),
            onPressed: (){
                Navigator.of(context).pop();
            },
          ),
        ),
                     FutureBuilder(
          future: fetchBookDetails(),
          builder: (context,data){
            if(!data.hasData){
                return SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                                    child: Container(
                    padding: EdgeInsets.only(top:250),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Center(
                        child: Theme(
                          data: ThemeData(
                            primaryColor: Colors.black,
                            accentColor: Colors.black.withOpacity(0.5)

                          ),
                             child: CircularProgressIndicator(

                          ),
                        ),
                      ),]
                    ),
                  ),
                );
            }
            return GridView.count(
                  primary: true,
                  scrollDirection: Axis.vertical,
                  childAspectRatio: 0.67,
                  crossAxisCount: 8,
                  // crossAxisSpacing: 3,
                  // mainAxisSpacing: 3,
                  shrinkWrap: true,
                  //crossAxisCount: 4,
                  children: List.generate(data.data.length, 
                  (index)  {
                    return _book(data.data,index);
                  }),
                  );
      
      
          },
          
        ),
        ]
                ),
              ),
        bookHover(data1,ind),
        ]
    ),
        ),
      );

  }
  Widget _book(data,index){
    return Container(
      
      color: Colors.transparent,
      padding: EdgeInsets.all(10),
      child: Material(
        borderRadius: BorderRadius.circular(10),
        elevation: 6,
        child: RaisedButton(
          color: Colors.transparent,
          padding: EdgeInsets.zero,
          elevation: 0,
          hoverElevation: 30,
          onPressed: (){
            setState(() {
              data1 = data;
              ind = index;
              isclicked = true;
            });
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: NetworkImage(data.futureImageUrl[index].replaceAll('|','/')),
                fit: BoxFit.cover
              )
            ),
          ),
        ),
      ),
    );
  }
  Widget bookHover(data,ind){
    print(data);
    if(data!= null) {
    return AnimatedPositioned(
      top: isclicked ?0 : 800 ,right: 0,left: 0,bottom: isclicked ? 0 : -800,
      duration: Duration(milliseconds: 300),
      curve: Curves.bounceInOut,
      child: Stack(
              children: [Container(
          color: Colors.black.withOpacity(0.7),
          child: Column(
            children: [
              
              Container(
                height: 347.3,
                color: Colors.transparent,
                
                ),
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage('https://cdn.trendhunterstatic.com/thumbs/cool-backgrounds.jpeg'),
                    fit: BoxFit.cover
                  ),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40))
                ),
                height: 310,
                width: 700,
                //color: Colors.greenAccent,
                padding: EdgeInsets.all(20),
                child: Material(
                  
                  color: Colors.transparent,
                  //elevation: 6,
                  child: Padding(
                    padding: const EdgeInsets.only(top:0),
                    child: Column(
                         children: [
                           Container(
                             height: 120,
                             child: Row(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               mainAxisAlignment: MainAxisAlignment.end,
                               children: [
                                 IconButton(
                                   onPressed: (){
                                     setState(() {
                                       isclicked = false;
                                     });
                                   },
                                   icon: Icon(Icons.close,color: Colors.white,),
                                 )
                               ],
                             ),
                           ),
                           Material(
                        //elevation: 8,
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black.withOpacity(0.4),
                        // child: RaisedButton(
                        //   onPressed: (){
                        //     setState(() {
                        //       isclicked = false;
                        //     });
                        //   },
                        // ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(children: [
                                Text('Book Name : ',
                                style: TextStyle(color: Colors.white,
                                fontWeight: FontWeight.w700
                                ),
                                
                                ),
                                Text(data.futureBookName[ind],
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w800
                                ,fontSize: 18
                              ),
                              )
                              ],),
                              Row(children: [
                                Text('Book Author : ',
                                style: TextStyle(color: Colors.white,
                                fontWeight: FontWeight.w700
                                ),
                                
                                ),
                                Text(data.futureAuthor[ind],
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w800
                                ,fontSize: 18
                              ),
                              )
                              ],),
                              Row(children: [
                                Text('Book Genre : ',
                                style: TextStyle(color: Colors.white,
                                fontWeight: FontWeight.w700
                                ),
                                
                                ),
                                Text(data.futureGenre[ind],
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w800
                                ,fontSize: 18
                              ),
                              )
                              ],),
                              Row(children: [
                                Text('Language : ',
                                style: TextStyle(color: Colors.white,
                                fontWeight: FontWeight.w700
                                ),
                                
                                ),
                                Text(data.futureLanguage[ind],
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w800
                                ,fontSize: 18
                              ),
                              )
                              ],),
                              Row(children: [
                                Text('Publisher : ',
                                style: TextStyle(color: Colors.white,
                                fontWeight: FontWeight.w700
                                ),
                                
                                ),
                                Text(data.futurePublisher[ind],
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w800
                                ,fontSize: 18
                              ),
                              )
                              ],)
                            ],
                          ),
                        ),
                      ),]
                    ),
                  ),
                ),
                )
            ],
          ),
        ),
        Positioned(
          
          top : 200,
          bottom: 200,
          left: 550,
          right: 550,
          child: Material(
            elevation: 10,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage(data.futureImageUrl[ind].replaceAll('|','/')),
                  fit: BoxFit.cover
                )
              ),
            ),
          ),
        )
        ]
      )
    );
    }
    else{
      return Container();
    }
  }
}