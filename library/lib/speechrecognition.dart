import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
//import 'package:speech_recognition/speech_recognition.dart';

Future<Genre> fetchAlbum(data) async 
{
  final response =await http.get('http://127.0.0.1:5000/genre/'+data);
  if (response.statusCode == 200) 
  {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Genre.fromJson(json.decode(response.body));
  } 
  else 
  {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load data');
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
// class for getting recognized data
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
// Future of data recieved
Future<SpeechtoText> fetchSpeech() async 
{
  final response =await http.get('http://127.0.0.1:5000/audio/s');
  if (response.statusCode == 200) 
  {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    print(response.body);
    return SpeechtoText.fromJson(json.decode(response.body));
  } 
  else 
  {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load data');
  }
}

class Speechrecognition extends StatefulWidget
{
  @override
  Page createState() => Page();
}
class Page extends State<Speechrecognition>
{
  Future<Genre> futuregenre;
  Future<SpeechtoText> futurespeech;
  bool datarecieved = false;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp
    (
      home: Scaffold
      (
        appBar: AppBar
        (
          // page name
          leading: IconButton
          (
            icon: Icon(Icons.home,color:Colors.white),
            onPressed:(){ Navigator.of(context).pop();},
          ),
          title: Text('Speech to Text',style: TextStyle(color: Colors.white),),
          // black color
          backgroundColor: Colors.black,
        ),
        backgroundColor: Colors.black12,
        body: new Container
        (
          padding: EdgeInsets.all(80),
          alignment: Alignment.center,
          margin: EdgeInsets.all(80),
          decoration: BoxDecoration
          (
            borderRadius: BorderRadius.circular(8.0),
            color: Colors.white,
            boxShadow: 
            [
              BoxShadow
              (
                  color: Colors.blue,
                  blurRadius: 3.0,
                  spreadRadius: 0.0,
                  offset: Offset(2.0, 2.0), // shadow direction: bottom right
              )
            ],
          ),
          child: new Column
          (
            children: 
            [
              new SizedBox
              (
                  height: 20,
                  width: 300,
              ),

              new Container
              (
                
                alignment: Alignment.center,
                height: 100,
                width: 200,
                decoration: BoxDecoration
                (
                  
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.white,
                  boxShadow: 
                  [
                    BoxShadow
                    (
                      
                        color: Colors.black,
                        blurRadius: 3.0,
                        spreadRadius: 0.0,
                        offset: Offset(2.0, 2.0), // shadow direction: bottom right
                    )
                  ],
                ),
                child: IconButton
                (
                  
                  alignment: Alignment.center,
                  color: Colors.black87,
                  hoverColor: Colors.black38,
                  focusColor: Colors.black12,
                  icon: Icon
                  (
                    Icons.mic,
                    size: 50,
                    color: Colors.black87,
                    
                  ),
                  

                  onPressed:()
                  {
                    futurespeech = fetchSpeech();
                    // Navigator.push
                    // (
                    //   context,
                    //   MaterialPageRoute
                    //   (
                    //     builder: (context) => ThirdWidget(futurespeech: futurespeech,),
                    //   ),
                    // );
                    datarecieved = true;
                    print(datarecieved);
                  }
                   ,
                ),
              ),
              new SizedBox
              (
                
                height: 100,
                width: 300,
                
              ),
              new Container
              (
                alignment: Alignment.center,
                child: RaisedButton
                (
                  onPressed: ()
                  {
                    Navigator.push
                    (
                      context,
                      MaterialPageRoute
                      (
                        builder: (context) => ThirdWidget(futurespeech: futurespeech,),
                      ),
                    );
                  },
                  child: Text
                  (
                    'Show Data',
                    style: TextStyle
                    (
                      fontSize: 20,
                      color: Colors.black
                    ),
                  ),
                  focusColor: Colors.blue[50],
                  hoverColor: Colors.blue[100],
                  splashColor: Colors.blue[200],
                  color: Colors.blue[200],
                  focusElevation: 100,
                  hoverElevation: 10,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class ThirdWidget extends StatelessWidget 
{ 
  String data;
  Future<Genre> futuregenre;
  Future<SpeechtoText> futurespeech;
  ThirdWidget({Key key, @required this.futurespeech, Future<Genre> futuregenre}) : super(key: key);
  @override
  Widget build(BuildContext ctxt) 
  {
    return new MaterialApp
    (
      home : Scaffold
      (
          appBar: AppBar
          (
              title: Text('Genre'),
          ),

          body : new Container
          (
            padding: EdgeInsets.all(80),
            alignment: Alignment.center,
            margin: EdgeInsets.all(60),
            decoration: BoxDecoration
            (
              borderRadius: BorderRadius.circular(8.0),
              color: Colors.white,
              boxShadow: 
              [
                BoxShadow
                (
                    color: Colors.blue,
                    blurRadius: 3.0,
                    spreadRadius: 0.0,
                    offset: Offset(2.0, 2.0), // shadow direction: bottom right
                )
              ],
            ),
            child : new Column
            (
                children: 
                [
                  new Container
                  (
                    constraints: BoxConstraints.expand
                    (
                      height: Theme.of(ctxt).textTheme.headline4.fontSize * 1.1 + 130.0,
                    ),
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(8.0),
                    color: Colors.blue[600],
                    //alignment: Alignment.center,
                    child: FutureBuilder<SpeechtoText>
                    (
                      future: futurespeech,
                      builder: (context, snapshot) 
                      {
                          if (snapshot.hasData) 
                          {
                            print(snapshot.data.speech);
                            data = snapshot.data.speech;
                            return Text
                            (
                              snapshot.data.speech,
                              style: TextStyle
                              (
                                color: Colors.white,
                                fontSize: 30,
                                //fontStyle: FontStyle.italic

                              )
                              
                            );
                          } 
                          else if (snapshot.hasError) 
                          {
                            return Text("${snapshot.error}");
                          }
                      print(snapshot.data.speech);
                      return CircularProgressIndicator();
                      },
                      //transform: Matrix4.rotationZ(0.1)
                    ),

                  ),
                  new Container
                  (
                    child: SizedBox
                    (
                      height: 40,
                      width: 300,
                    ),
                  ),
                  new Container
                  (
                    child :IconButton
                    (
                      icon: Icon
                      (
                        Icons.arrow_back
                      ),
                      onPressed: () 
                      {
                        Navigator.of(ctxt).pop();
                      }   
                    )
                  ),
                  new Container
                  (
                    alignment: Alignment.bottomRight,
                    child: RaisedButton
                    (
                      child: Text
                      (
                        'Get Genre',
                        style: TextStyle
                        (
                          fontSize: 24
                        ),
                      ),
                      hoverColor: Colors.blue[200],
                      hoverElevation: 10,
                      focusColor: Colors.blue[100],
                      focusElevation: 10,

                      onPressed: ()
                      {
                        futuregenre = fetchAlbum(data);
                        Navigator.push
                        (
                          ctxt,
                          MaterialPageRoute
                          (
                            builder: (ctxt) => Fourthwidget(futuregenre: futuregenre,),
                          ),
                        );

                      },
                    ),
                  )
                ],
            )
          )
      )
    );     
  }
}
class Fourthwidget extends StatelessWidget 
{ 
  Future<Genre> futuregenre;
  Fourthwidget({Key key, @required this.futuregenre}) : super(key: key);
  @override
  Widget build(BuildContext ctxt) 
  {
    return new MaterialApp
    (
      home : Scaffold
      (
          appBar: AppBar
          (
              title: Text('Genre'),
          ),

          body : new Container
          (
            padding: EdgeInsets.all(80),
            alignment: Alignment.center,
            margin: EdgeInsets.all(60),
            decoration: BoxDecoration
            (
              borderRadius: BorderRadius.circular(8.0),
              color: Colors.white,
              boxShadow: 
              [
                BoxShadow
                (
                    color: Colors.blue,
                    blurRadius: 3.0,
                    spreadRadius: 0.0,
                    offset: Offset(2.0, 2.0), // shadow direction: bottom right
                )
              ],
            ),
            child : new Column
            (
                children: 
                [
                  new Container
                  (
                    constraints: BoxConstraints.expand
                    (
                      height: Theme.of(ctxt).textTheme.headline4.fontSize * 1.1 + 130.0,
                    ),
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(8.0),
                    color: Colors.blue[600],
                    //alignment: Alignment.center,
                    child: FutureBuilder<Genre>
                    (
                      future: futuregenre,
                      builder: (context, snapshot) 
                      {
                          if (snapshot.hasData) 
                          {
                            print(snapshot.data.genre+'hfjh');
                            return Text
                            (
                              snapshot.data.genre,
                              style: TextStyle
                              (
                                color: Colors.white,
                                fontSize: 30,
                                //fontStyle: FontStyle.italic

                              )
                              
                            );
                          } 
                          else if (snapshot.hasError) 
                          {
                            return Text("${snapshot.error}");
                          }
                      //print(snapshot.data);
                      return CircularProgressIndicator();
                      },
                      //transform: Matrix4.rotationZ(0.1)
                    ),

                  ),
                  new Container
                  (
                    child: SizedBox
                    (
                      height: 40,
                      width: 300,
                    ),
                  ),
                  new Container
                  (
                    child :IconButton
                    (
                      icon: Icon
                      (
                        Icons.arrow_back
                      ),
                      onPressed: () 
                      {
                        Navigator.of(ctxt).pop();
                      }   
                    )
                  ),
                ],
            )
          )
      )
    );     
  }
}