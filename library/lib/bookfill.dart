

//import 'dart:html';

import 'dart:convert';
import 'package:homepage/homelogin.dart';
import 'package:homepage/speechrecognition.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:homepage/dateformat.dart';
import 'package:http/http.dart' as http;
class SpeechtoText{
  // storing the retrieved data in to string
  final String speech;

  // constructot
  SpeechtoText({this.speech});
  //need to study about factory
  factory SpeechtoText.fromJson(Map<String, dynamic> json) 
  {
    return SpeechtoText
    (
      speech: json['speech'],
    );
  }
}

class Genre{
  final String genre;

  Genre({this.genre});

  factory Genre.fromJson(Map<String, dynamic> json) 
  {
    return Genre
    (
      genre: json['genre'],
    );
  }
}

class Bookfill extends StatefulWidget{
  @override
  Fillpage createState() => Fillpage();
}

class Fillpage extends State<Bookfill> {

  bool bookvalidate =  true;
  bool isbnvalidate =  true;
  bool genrevalidate =  true;
  bool publishervalidate =  true;
  bool authorvalidate =  true;
  bool pricevalidate =  true;
  bool quantityvalidate =  true;
  bool imageurlvalidate =  true;
  bool datevalidate =  true;
  bool languagevalidate = true;

  final bookname = TextEditingController();
  final isbn = TextEditingController();
  final genre = TextEditingController();
  final publisher = TextEditingController();
  final author = TextEditingController();
  final price = TextEditingController();
  final quantity = TextEditingController();
  final imageurl = TextEditingController();
  final  date = TextEditingController();
  final language = TextEditingController();

  @override
  void dispose() 
  {
    // TODO: implement dispose
    super.dispose();
    bookname.dispose();
    isbn.dispose();
    genre.dispose();
    publisher.dispose();
    author.dispose();
    price.dispose();
    quantity.dispose();
    imageurl.dispose();
  }
  Future<Genre> fetchAlbum(data) async 
  {
    Genre tmp;
    final response =await http.get('http://127.0.0.1:5000/genre/'+data);
    if (response.statusCode == 200) 
    {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      tmp = Genre.fromJson(json.decode(response.body));
      print(tmp.genre);
      genre.text = tmp.genre;
    } 
    else 
    {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load data');
    }
  }
  Future<SpeechtoText> fetchSpeech() async 
  {
    final response =await http.get('http://127.0.0.1:5000/audio/s');
    if (response.statusCode == 200) 
    {
      SpeechtoText tmp;
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print(response.body);
      tmp = SpeechtoText.fromJson(json.decode(response.body));
      bookname.text = tmp.speech;
      fetchAlbum(tmp.speech);
    } 
    else 
    {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load data');
    }
  }
  Future<void> _showMyDialog(text) async 
  {
    return showDialog<void>
    (
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) 
      {
        return AlertDialog
        (
          elevation: 10,
          
          title: Text('Fill Book Details'),
          content: SingleChildScrollView(
            
            child: ListBody(

              children: <Widget>[
                Text(text),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton
            (
              hoverColor: Colors.blue,
              focusColor: Colors.blue,
              //autofocus: true,
              child: Text
              (
                'Ok',
                style: TextStyle
                (
                  color: Colors.black,
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
  @override
  Widget build(BuildContext context) {
    
    return Material(
      elevation: 10,
      shadowColor: Colors.white24,
      color: Colors.white54,
      child: MaterialApp(
        home: Scaffold
        (
          
          backgroundColor: Colors.white70,
          appBar: AppBar
          (
            leading: IconButton(
              icon: Icon(Icons.home),
              color: Colors.white,
              onPressed: (){
                Navigator.of(context).pop();
              },
            ),
            centerTitle: true,
            title: Text
            (
              'Fill Book Details'
            ),
          ),
          body: new Container
          (
            padding: EdgeInsets.fromLTRB(80, 10, 80, 10),
            alignment: Alignment.center,
            margin: EdgeInsets.fromLTRB(130, 20, 130, 20),
            decoration: BoxDecoration
            (
              borderRadius: BorderRadius.circular(8.0),
              color: Colors.white,
              boxShadow: 
              [
                BoxShadow
                (
                  color: Colors.black38,
                  blurRadius: 3.0,
                  spreadRadius: 0.0,
                  offset: Offset(2.0, 2.0), // shadow direction: bottom right
                )
              ],
            ),
            child: SingleChildScrollView
            (
              child: new Column
              (
                children: 
                [
                  new Container
                  (
                    child: Text
                    (
                      'Enter Book Details',
                      style: TextStyle
                      (
                        fontSize: 30
                      ),
                    ),
                  ),
                  // first row
                  new Container
                  (
                    height: 100,
                    
                    child: Row
                    (
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: 
                      [
                        
                        Expanded
                        (
                          child: TextField
                          (
                            controller: bookname,
                            autofocus: true,
                            textAlign: TextAlign.left,
                            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
                            //controller: myController,

                            //cursor
                            // cursorColor: Colors.blue,
                            // cursorRadius: Radius.circular(16.0),
                            // cursorWidth: 6.0,

                            decoration: InputDecoration
                            (
                              //icon: Icon(Icons.print),
                              prefixIcon: Icon(Icons.book),
                              border: OutlineInputBorder(),
                              //hintText: 'Enter a book name',
                              labelText: 'Book name',
                              errorText: bookvalidate ? null : 'Value Can\'t Be Empty',
                            ),
                          ),
                        ),
                        Expanded
                        (
                          child: SizedBox
                          (
                            height: 10,
                            width: 10,
                          ),
                        )
                        ,
                        Expanded
                        (
                          child: TextField
                          (
                            controller: isbn,
                            autofocus: true,
                            textAlign: TextAlign.left,
                            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
                            //controller: myController,

                            //cursor
                            // cursorColor: Colors.blue,
                            // cursorRadius: Radius.circular(16.0),
                            // cursorWidth: 6.0,

                            decoration: InputDecoration
                            (
                              //icon: Icon(Icons.print),
                              //prefixIcon: Icon(Icons.book),
                              border: OutlineInputBorder(),
                              //hintText: 'Enter a book name',
                              labelText: 'ISBN',
                              errorText: isbnvalidate ?  null : 'Value Can\'t Be Empty',
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  // second row
                  new Container
                  (
                    child: Row
                    (
                      children: 
                      [
                        Expanded
                        (
                          child: TextField
                          (
                            controller: genre,
                            autofocus: true,
                            textAlign: TextAlign.left,
                            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
                            //controller: myController,

                            //cursor
                            // cursorColor: Colors.blue,
                            // cursorRadius: Radius.circular(16.0),
                            // cursorWidth: 6.0,

                            decoration: InputDecoration
                            (
                              //icon: Icon(Icons.print),
                              //prefixIcon: Icon(Icons.book),
                              border: OutlineInputBorder(),
                              //hintText: 'Enter a book name',
                              labelText: 'Genre',
                              errorText: genrevalidate ?  null : 'Value Can\'t Be Empty',
                            ),
                          ),

                        ),
                        Expanded
                        (
                          child : ButtonTheme
                          (
                            minWidth: 20,
                            //height: 60,
                            
                            child: RaisedButton.icon
                            (
                              
                              onPressed: ()
                              {
                                fetchSpeech();
                              },
                              icon: Icon
                              (
                                Icons.mic
                              ),
                              label: Text
                              (
                                'Voice Search'
                              ),

                              color: Colors.blue[100],
                              hoverColor: Colors.blue,
                              focusColor: Colors.blue,
                              //hoverElevation: 4,
                              //focusElevation: 4,
                              
                              
                            ),
                          ),
                        ),
                        Expanded
                        (
                          child: RaisedButton.icon
                          (
                            onPressed: ()
                            {
                              print('pressed');
                              if(bookname.text.isNotEmpty)
                              {
                                print('fetching');
                                fetchAlbum(bookname.text);
                              }
                            },
                            icon: Icon
                            (
                              Icons.search
                            ),
                            label: Text
                            (
                              'Search'
                            ),
                            color: Colors.blue[100],
                            hoverColor: Colors.blue,
                            focusColor: Colors.blue,
                            //hoverElevation: 4,
                            //focusElevation: 4,
                            
                            
                          ),
                        ),
                      ],
                    ),
                  ),
                  new Container
                  (
                    child:new SizedBox
                    (
                      height: 20,
                      width: 300,
                    )
                  ),
                  // 3rd row
                  new Container
                  (
                    child: Row
                    (
                      children: 
                      [
                        Expanded
                        (
                          child: TextField
                          (
                            controller: publisher,
                            autofocus: true,
                            textAlign: TextAlign.left,
                            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
                            //controller: myController,

                            //cursor
                            // cursorColor: Colors.blue,
                            // cursorRadius: Radius.circular(16.0),
                            // cursorWidth: 6.0,

                            decoration: InputDecoration
                            (
                              //icon: Icon(Icons.print),
                              //prefixIcon: Icon(Icons.book),
                              border: OutlineInputBorder(),
                              //hintText: 'Enter a book name',
                              labelText: 'Publisher',
                              errorText: publishervalidate ?  null : 'Value Can\'t Be Empty',
                            ),
                          ),
                        ),
                        Expanded
                        (
                          child: TextField
                          (
                            controller: language,
                            autofocus: true,
                            textAlign: TextAlign.left,
                            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
                            //controller: myController,

                            //cursor
                            // cursorColor: Colors.blue,
                            // cursorRadius: Radius.circular(16.0),
                            // cursorWidth: 6.0,

                            decoration: InputDecoration
                            (
                              //icon: Icon(Icons.print),
                              prefixIcon: Icon(Icons.language),
                              border: OutlineInputBorder(),
                              //hintText: 'Enter a book name',
                              labelText: 'Language',
                              errorText: languagevalidate ?  null : 'Value Can\'t Be Empty',
                            ),
                          ),
                        ),
                        Expanded
                        (
                          
                          child: BasicDateField(date:date),
                        )
                      ],
                    ),
                  ),
                  new Container
                  (
                    child: SizedBox
                    (
                      height: 20,
                      width: 300,
                    ),
                  ),
                  
                  //4th row
                  new Container
                  (
                    child: TextField
                    (
                      controller: imageurl,
                      autofocus: true,
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
                      //controller: myController,

                      //cursor
                      // cursorColor: Colors.blue,
                      // cursorRadius: Radius.circular(16.0),
                      // cursorWidth: 6.0,

                      decoration: InputDecoration
                      (
                        //icon: Icon(Icons.print),
                        prefixIcon: Icon(Icons.image),
                        border: OutlineInputBorder(),
                        //hintText: 'Enter a book name',
                        labelText: 'Image URL',
                        errorText: imageurlvalidate ?  null : 'Value Can\'t Be Empty',
                      ),

                    ),
                  ),
                  new Container
                  (
                    child : new SizedBox
                    (
                      height: 20,
                    )
                  ),
                  //5th row
                  new Container
                  (
                    child: Row
                    (
                      children: 
                      [
                        Expanded
                        (
                          child: TextField
                          (
                            controller: author,
                            autofocus: true,
                            textAlign: TextAlign.left,
                            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
                            //controller: myController,

                            //cursor
                            // cursorColor: Colors.blue,
                            // cursorRadius: Radius.circular(16.0),
                            // cursorWidth: 6.0,

                            decoration: InputDecoration
                            (
                              //icon: Icon(Icons.print),
                              prefixIcon: Icon(Icons.person),
                              border: OutlineInputBorder(),
                              //hintText: 'Enter a book name',
                              labelText: 'Author',
                              errorText: authorvalidate ?  null : 'Value Can\'t Be Empty',
                            ),
                          ),

                        ),
                        Expanded
                        (
                          child: TextField
                          (
                            controller: price,
                            autofocus: true,
                            textAlign: TextAlign.left,
                            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
                            //controller: myController,

                            //cursor
                            // cursorColor: Colors.blue,
                            // cursorRadius: Radius.circular(16.0),
                            // cursorWidth: 6.0,

                            decoration: InputDecoration
                            (
                              //icon: Icon(Icons.print),
                              prefixIcon: Icon(Icons.attach_money),
                              border: OutlineInputBorder(),
                              //hintText: 'Enter a book name',
                              labelText: 'Price',
                              errorText: pricevalidate ?  null : 'Value Can\'t Be Empty',
                            ),
                          ),

                        ),
                        Expanded
                        (
                          child: TextField
                          (
                            controller: quantity,
                            autofocus: true,
                            textAlign: TextAlign.left,
                            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
                            //controller: myController,

                            //cursor
                            // cursorColor: Colors.blue,
                            // cursorRadius: Radius.circular(16.0),
                            // cursorWidth: 6.0,

                            decoration: InputDecoration
                            (
                              //icon: Icon(Icons.print),
                              //prefixIcon: Icon(Icons.book),
                              border: OutlineInputBorder(),
                              //hintText: 'Enter a book name',
                              labelText: 'Quantity',
                              errorText: quantityvalidate ?  null : 'Value Can\'t Be Empty',
                            ),
                          ),

                        ),
                      ],
                    ),
                  ),
                  new Container
                  (
                    child: SizedBox
                    (
                      height: 40,
                    ),
                  ),
                  //6th row
                  new Container
                  (
                    child: Row
                    (
                      children: 
                      [
                        Expanded
                        (
                          child: SizedBox
                          (
                            width: 4,
                          )
                        ),
                        Expanded
                        (
                          child: SizedBox
                          (
                            width: 4,
                          )
                        ),
                        Expanded
                        (
                          child: SizedBox
                          (
                            width: 4,
                          )
                        ),
                        Expanded
                        (
                          child: RaisedButton
                          (
                            onPressed: () async
                            {
                              print(date.text+'jisahfd');
                              setState(() 
                              {
                                bookname.text.isNotEmpty ? bookvalidate = true : bookvalidate = false;
                                genre.text.isNotEmpty ? genrevalidate = true : genrevalidate = false;
                                isbn.text.isNotEmpty ? isbnvalidate = true : isbnvalidate = false;
                                publisher.text.isNotEmpty ? publishervalidate = true : publishervalidate = false;
                                author.text.isNotEmpty ? authorvalidate = true : authorvalidate = false;
                                price.text.isNotEmpty ? pricevalidate = true : pricevalidate = false;
                                quantity.text.isNotEmpty ? quantityvalidate = true : quantityvalidate = false;
                                imageurl.text.isNotEmpty ? imageurlvalidate = true : imageurlvalidate = false;
                                language.text.isNotEmpty ? languagevalidate = true : languagevalidate = false;
                              });
                              print(isbnvalidate);
                              if(bookvalidate && isbnvalidate && publishervalidate &&  imageurlvalidate && authorvalidate && pricevalidate && quantityvalidate )
                              {
                                String div = '_-_-_';
                                String tmp ;
                                tmp = imageurl.text.replaceAll('/', '|');
                                print(tmp);
                                String s =isbn.text+div+bookname.text+div+genre.text+div+language.text+div+price.text+div+publisher.text+div+tmp+div+quantity.text+div+author.text;
                                final response = await http.get('http://127.0.0.1:5000/database/insert/'+s);
                                
                                print('hello');
                                //fetchAlbum(bookname.text);
                                 _showMyDialog(response.body);
                              }
                              
                            },
                            child: Text
                            (
                              'Submit'
                            ),
                            color: Colors.blue[300],
                            hoverColor: Colors.blue[400],
                            focusColor: Colors.blue[400],
                            hoverElevation: 4,
                            focusElevation: 4,
                            
                            
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ),
          ),
      ),
    );
  }
}

class BasicDateField extends StatelessWidget {
  final format = DateFormat("yyyy-MM-dd");
  TextEditingController date;
  BasicDateField({Key key, @required this.date}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      
      //Text('Basic date field (${format.pattern})'),
      DateTimeField(
        controller: date,
        format: format,
        onShowPicker: (context, currentValue) {
          return showDatePicker(
              context: context,
              firstDate: DateTime(1900),
              initialDate: currentValue ?? DateTime.now(),
              lastDate: DateTime(2100));
        },
      ),
    ]);
  }
}

