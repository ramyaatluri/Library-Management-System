import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:homepage/homelogin.dart';
import 'package:homepage/homepage.dart';
import 'package:homepage/bookClass.dart';
import 'package:http/http.dart' as http;

String filterGenre = 'Genre';
String filterLanguage = 'Language';
String filterprice = 'Price';
String filterPublisher = 'Publisher';
String filterAuthor = 'Author';
enum WhyFarther { harder, smarter, selfStarter, tradingCharter }

Future<futureBookDetails> fetchBookDetails() async {
  
  String whereclass = '';
  if (filterGenre != 'Genre') {
    whereclass += 'where genre = \'' + filterGenre + '\'';
  }
  if (filterLanguage != 'Language') {
    if (whereclass == '') {
      whereclass += 'where language = \'' + filterLanguage + '\'';
    } else {
      whereclass += 'and Language = \'' + filterLanguage + '\'';
    }
  }
  if (filterPublisher != 'Publisher') {
    if (whereclass == '') {
      whereclass += 'where publisher = \'' + filterPublisher + '\'';
    } else {
      whereclass += 'and publisher = \'' + filterPublisher + '\'';
    }
  }
  if (filterAuthor != 'Author') {
    if (whereclass == '') {
      whereclass += 'where author = \'' + filterAuthor + '\'';
    } else {
      whereclass += 'and author = \'' + filterAuthor + '\'';
    }
  }
  if (whereclass != '') {
    whereclass += ';';
  }
  //final response = await http.get('http://127.0.0.1:5000/database/insert/bookDetails');
  bookDetails temp;
  String divider = '_-_-_';
  final response = await http.get(
      'http://127.0.0.1:5000/database/insert/bookDetails' +
          divider +
          whereclass);
  if (response.statusCode == 200) {
    temp = bookDetails.fromJson(json.decode(response.body));
    print(temp);
    return futureBookDetails.from(temp);
  } else {
    throw Exception('Failed to load data');
  }
}

class BookView extends StatefulWidget {
  @override
  bookView createState() => bookView();
}

class bookView extends State<BookView> {
  int c = 0;
  List<String> cart = ['','',''];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: black,
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.home),color: white,onPressed: (){
          Navigator.of(context).pop();
        },),
        centerTitle: true,
        backgroundColor: black,
        title: Text(
          'Book Gallery',
          style: TextStyle(color: white),
        ),
      ),
      body: Container(
        child: Row(
          children: <Widget>[
            Container(
              width: 250,
              height: 600,
              child: Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 10, top: 40, bottom: 60),
                  child: leftContainer(context)),
            ),
            Container(
              width: 700,
              child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                      child: FutureBuilder(
                          future: fetchBookDetails(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData) {
                              return ListView.separated(
                                scrollDirection: Axis.vertical,
                                physics: ClampingScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index) {
                                  return _Container(
                                      context, snapshot.data, index);
                                },
                                separatorBuilder: (context, index) {
                                  return SizedBox(
                                    height: 20,
                                  );
                                },
                                itemCount: snapshot.data.length,
                              );
                            } else {
                              return Container(
                                child: Center(
                                  child: Text(
                                    'Loading..',
                                    style: TextStyle(color: white),
                                  ),
                                ),
                              );
                            }
                            //return Container(child:CircularProgressIndicator);
                          }),
                    )
                  ])),
            ),
            Container(
              color: Colors.transparent,
                child: Padding(
              padding: const EdgeInsets.only(top: 40.0, left: 10),
              child: Column(
                
                children: <Widget>[
                  Container(
                    height: 180,
                    width: 300,
                    child: rightTopContainer(context),
                    //color: Colors.transparent,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: 300,
                    width: 300,
                    child: rightBottomContainer(context),
                  )
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }

  StatefulWidget _Container(context, futureBookDetails data, int index) {
    String url = data.futureImageUrl[index].toString();
    String changeUrl = url.replaceAll('|', '/');
    String bookname = data.futureBookName[index];
    String bookGenre = data.futureGenre[index];
    String bookPublisher = data.futurePublisher[index];
    String bookAuthor = data.futureAuthor[index];
    String bookLanguage = data.futureLanguage[index];
    String bookPrice = data.futurePrice[index];
    bool starSelected = false;
    Color starColor = Colors.white;
    return Material(
      elevation: 6,
      color: black,
      borderRadius: BorderRadius.circular(10),
      child: Row(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            height: 150,
            //color: backgroundColor,
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
              child: Image(
                image: NetworkImage(changeUrl),
              ),
            ),
          ),
          SizedBox(
            width: 30,
          ),
          Container(
            height: 150,
            color: black,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 6),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      height: 36,
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10)),
                              //height: 20,
                              width: 420,
                              child: Text(
                                bookname,
                                style: TextStyle(
                                    color: white,
                                    fontSize: 21,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            //Container(width: 100,),
                            IconButton(
                              icon: Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 18,
                              ),
                              hoverColor: Colors.yellow,
                              onPressed: () {
                                print('tapped');
                                setState(() {
                                  starSelected = !starSelected;
                                  starColor = starSelected
                                      ? Colors.yellowAccent
                                      : Colors.white;
                                  print(starColor);
                                });
                              },
                            ),
                            popmenu(),
                            // IconButton(
                            //   icon: Icon(
                            //     Icons.more_vert,
                            //     color: white,
                            //     size: 18,
                            //   ),
                            //   color: Colors.transparent,
                            //   hoverColor: Colors.transparent,
                            //   onPressed: () {
                              
                            //     popmenu();
                            //   },
                            // )
                          ]),
                    ),
                    Row(children: [
                      Container(
                        width: 250,
                        child: Row(
                         children: [
                          Text(
                            'by ',
                            style: TextStyle(
                              
                                color: white,
                                fontWeight: FontWeight.w300),
                                overflow: TextOverflow.ellipsis,
                          ),
                        
                        Expanded(
                            child: Text(
                            bookAuthor,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: white,
                                fontSize: 13,
                                fontWeight: FontWeight.w400),
                          ),
                        )
                      ],
                        )),
                      Container(
                        width: 200,
                        child: Row(children: [
                        Text(
                          'genre :',
                          style: TextStyle(
                              color: white, fontWeight: FontWeight.w300),
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        Expanded(
                              child: Text(
                              bookGenre,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: white, fontWeight: FontWeight.w400),
                            ),
                          ),
                        ],),
                      )
                    ]),
                    SizedBox(
                      height: 3,
                    ),
                    Row(
                      children: [
                        Text(
                          'language :',
                          style: TextStyle(
                              color: white, fontWeight: FontWeight.w300),
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        Text(
                          bookLanguage,
                          style: TextStyle(
                              color: white, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Row(
                      children: [
                        Text(
                          'published by ',
                          style: TextStyle(
                              color: white, fontWeight: FontWeight.w300),
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        Text(
                          bookPublisher,
                          style: TextStyle(
                              color: white, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Text(
                          'price :',
                          style: TextStyle(
                              color: white, fontWeight: FontWeight.w300),
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        Text(
                          bookPrice + '.00',
                          style: TextStyle(
                              color: white, fontWeight: FontWeight.w400),
                        ),
                        Text(
                          'rs',
                          style: TextStyle(
                              color: white, fontWeight: FontWeight.w300),
                        ),
                        SizedBox(
                          width: 260,
                        ),
                        SizedBox(
                          height: 24,
                          width: 140,
                          child: RaisedButton(
                            color: black,
                            //hoverElevation: 4,
                            elevation: 14,
                            onPressed: () {
                              setState(() {
                                
                              
                              print(c);
                              if(c<3){
                                bool ch = true;
                                for(int i=0;i<=c;i++){
                                  
                                  if(cart[i] == bookname){
                                    ch = false;
                                    _showMyDialog('Already in cart');
                                  }
                                }
                                if(ch){ cart[c] = bookname;c++;}

                              }
                              else{
                                _showMyDialog('Cannot add More than 3');
                              }
                            });},
                            child: Text(
                              'Add to cart',
                              style: TextStyle(color: white),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget leftContainer(context) {
    return Material(
      elevation: 14,
      color: black,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        child: Column(children: <Widget>[
          Container(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 14,
                ),
                Text(
                  'Filters',
                  style: TextStyle(color: white, fontSize: 20),
                ),
                SizedBox(
                  height: 15,
                )
              ],
            ),
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(14.0, 30, 14.0, 0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 12,
                    ),
                    SizedBox(
                      height: 26,
                      width: 200,
                      child: RaisedButton(
                        //child: Text('Price',style: TextStyle(color: Colors.white),),
                        elevation: 14,
                        onPressed: () {},
                        hoverColor: black,
                        focusColor: black,

                        color: black,
                        child: DropdownButton<String>(
                          items: <String>[
                            'Roberto Bolano',
                            'Mary Shelly',
                            'Rendezvous',
                            'Chetan Bhagat'
                          ].map((String value) {
                            return new DropdownMenuItem<String>(
                              value: value,
                              child: SizedBox(
                                height: 26,
                                width: 152,
                                child: new RaisedButton(
                                  focusColor: black,
                                  //hoverColor: backgroundColor,
                                  color: black,
                                  elevation: 14,
                                  child: Text(
                                    value,
                                    style: TextStyle(color: white),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      filterAuthor = value;
                                      Navigator.of(context).pop();
                                    });
                                  },
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (_) {},
                          isDense: true,
                          hint: Text(
                            filterAuthor,
                            style: TextStyle(color: white),
                          ),
                          onTap: () {},
                          dropdownColor: black,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    SizedBox(
                      height: 26,
                      width: 200,
                      child: RaisedButton(
                        //child: Text('Price',style: TextStyle(color: Colors.white),),
                        elevation: 14,
                        onPressed: () {},
                        hoverColor: black,
                        focusColor: black,

                        color: black,
                        child: DropdownButton<String>(
                          items: <String>[
                            '500 - 1000',
                            '1000 - 2000',
                            '2000 and more',
                          ].map((String value) {
                            return new DropdownMenuItem<String>(
                              value: value,
                              child: SizedBox(
                                height: 26,
                                width: 152,
                                child: new RaisedButton(
                                  focusColor: black,
                                  //hoverColor: backgroundColor,
                                  color: black,
                                  elevation: 14,
                                  child: Text(
                                    value,
                                    style: TextStyle(color: white),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      filterprice = value;
                                      Navigator.of(context).pop();
                                    });
                                  },
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (_) {},
                          isDense: true,
                          hint: Text(
                            filterprice,
                            style: TextStyle(color: white),
                          ),
                          onTap: () {},
                          dropdownColor: black,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    SizedBox(
                      height: 26,
                      width: 200,
                      child: RaisedButton(
                        //child: Text('Price',style: TextStyle(color: Colors.white),),
                        elevation: 14,
                        onPressed: () {},
                        hoverColor: black,
                        focusColor: black,

                        color: black,
                        child: DropdownButton<String>(
                          items: <String>[
                            'English',
                            'Hindi',
                            'Telugu',
                          ].map((String value) {
                            return new DropdownMenuItem<String>(
                              value: value,
                              child: SizedBox(
                                height: 26,
                                width: 152,
                                child: new RaisedButton(
                                  focusColor: black,
                                  //hoverColor: backgroundColor,
                                  color: black,
                                  elevation: 14,
                                  child: Text(
                                    value,
                                    style: TextStyle(color: white),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      filterLanguage = value;
                                      Navigator.of(context).pop();
                                    });
                                  },
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (_) {},
                          isDense: true,
                          hint: Text(
                            filterLanguage,
                            style: TextStyle(color: white),
                          ),
                          onTap: () {},
                          dropdownColor: black,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    SizedBox(
                      height: 26,
                      width: 200,
                      child: RaisedButton(
                        //child: Text('Price',style: TextStyle(color: Colors.white),),
                        elevation: 14,
                        onPressed: () {},
                        hoverColor: black,
                        focusColor: black,

                        color: black,
                        child: DropdownButton<String>(
                          items: <String>[
                            'Publisher1',
                            'PUblish2',
                            'Publisher3',
                          ].map((String value) {
                            return new DropdownMenuItem<String>(
                              value: value,
                              child: SizedBox(
                                height: 26,
                                width: 152,
                                child: new RaisedButton(
                                  focusColor: black,
                                  //hoverColor: backgroundColor,
                                  color: black,
                                  elevation: 14,
                                  child: Text(
                                    value,
                                    style: TextStyle(color: white),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      filterPublisher = value;
                                      Navigator.of(context).pop();
                                    });
                                  },
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (_) {},
                          isDense: true,
                          hint: Text(
                            filterPublisher,
                            style: TextStyle(color: white),
                          ),
                          onTap: () {},
                          dropdownColor: black,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    SizedBox(
                      height: 26,
                      width: 200,
                      child: RaisedButton(
                        //child: Text('Price',style: TextStyle(color: Colors.white),),
                        elevation: 14,
                        onPressed: () {},
                        hoverColor: black,
                        focusColor: black,

                        color: black,
                        child: DropdownButton<String>(
                          items: <String>[
                            'Autobio',
                            'Fiction',
                            'Diary',
                            'Gothic',
                            'Horror',
                            'Drama'
                          ].map((String value) {
                            return new DropdownMenuItem<String>(
                              value: value,
                              child: SizedBox(
                                height: 26,
                                width: 152,
                                child: new RaisedButton(
                                  focusColor: black,
                                  //hoverColor: backgroundColor,
                                  color: black,
                                  elevation: 14,
                                  child: Text(
                                    value,
                                    style: TextStyle(color: white),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      filterGenre = value;
                                      Navigator.of(context).pop();
                                    });
                                  },
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (_) {},
                          isDense: true,
                          hint: Text(
                            filterGenre,
                            style: TextStyle(color: white),
                          ),
                          onTap: () {},
                          dropdownColor: black,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 90,
                    ),
                    SizedBox(
                      height: 26,
                      width: 160,
                      child: RaisedButton(
                        color: black,
                        elevation: 14,
                        child: Text(
                          'Reset',
                          style: TextStyle(color: white),
                        ),
                        onPressed: () {
                          setState(() {
                            filterAuthor = 'Author';
                            filterGenre = 'Genre';
                            filterPublisher = 'Publisher';
                            filterprice = 'Price';
                            filterLanguage = 'Language';
                          });
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  Widget rightTopContainer(context) {
    return SingleChildScrollView(
      
      physics: ClampingScrollPhysics(),
      scrollDirection: Axis.vertical,
      child: Material(
        borderRadius: BorderRadius.circular(10),
        color: black,
        elevation: 20,
        child: Column(
          children: [
            SizedBox(
              height: 5,
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                'Cart',
                style: TextStyle(color: white, fontSize: 20),
              ),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(children: <Widget>[
                  SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                    height: 40,
                    width: 240,
                    child: Material(
                      color: Colors.green[800],
                      elevation: 14,
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        padding: EdgeInsets.only(top:10,left:10),
                        child: Text(cart[0],style: TextStyle(color: Colors.white),overflow: TextOverflow.ellipsis,)),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                    height: 40,
                    width: 240,
                    child: Material(
                      color: Colors.green[800],
                      elevation: 14,
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        padding: EdgeInsets.only(top:10,left:10),
                        child: Text(cart[1],style: TextStyle(color: Colors.white),overflow: TextOverflow.ellipsis,)),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                    height: 40,
                    width: 240,
                    child: Material(
                      color: Colors.green[800],
                      elevation: 14,
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        padding: EdgeInsets.only(top:10,left:10),
                        child: Text(cart[2],style: TextStyle(color: Colors.white),overflow: TextOverflow.ellipsis,)),
                    ),
                  ),
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget rightBottomContainer(context) {
    return SingleChildScrollView(
      physics: ClampingScrollPhysics(),
      scrollDirection: Axis.vertical,
      //padding: EdgeInsets.fromLTRB(left, top, right, bottom),
      child: Material(
        elevation: 14,
        borderRadius: BorderRadius.circular(10),
        color: black,
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Container(
              child: Text(
                'Trending',
                style: TextStyle(color: white, fontSize: 20),
              ),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30, 20, 30, 4),
                child: Column(
                  children: [
                    SizedBox(
                      height: 60,
                      width: 400,
                      child: Material(
                        elevation: 14,
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 60,
                      width: 400,
                      child: Material(
                        elevation: 14,
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 60,
                      width: 400,
                      child: Material(
                        elevation: 14,
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 60,
                      width: 400,
                      child: Material(
                        elevation: 14,
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget popmenu(){
    Color tempblack = black;
    Color tempwhite = white;
  //print('pop');
  return Container(
    padding: EdgeInsets.only(top:9),
    color: black,
    child: PopupMenuButton<WhyFarther>(
      color: black,
      child:Icon(Icons.more_vert,color: white,size: 18,),
      elevation: 10,
    onSelected: (WhyFarther result) { setState(() { }); },
    itemBuilder: (BuildContext context) => <PopupMenuEntry<WhyFarther>>[
      const PopupMenuItem(
        child: Text('Add',style: TextStyle(color:Colors.black),),
      ),
      const PopupMenuItem<WhyFarther>(
        value: WhyFarther.smarter,
        child: Text('Delete',style: TextStyle(color: Colors.black),),
      ),
      const PopupMenuItem<WhyFarther>(
        value: WhyFarther.selfStarter,
        child: Text('Show',style: TextStyle(color: Colors.black),),
      ),
      const PopupMenuItem<WhyFarther>(
        value: WhyFarther.tradingCharter,
        child: Text('More',style: TextStyle(color: Colors.black),),
      )]),
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
          title: Text('Error',style: TextStyle(color:Colors.red),),
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
