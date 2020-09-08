
import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homepage/bookStorage.dart';
import 'package:homepage/bookfill.dart';
import 'package:homepage/bookpage.dart';
import 'package:homepage/dues.dart';
import 'package:homepage/homelogin.dart';
import 'package:homepage/http.dart';
import 'package:homepage/issueBook.dart';
import 'package:homepage/return.dart';
import 'package:homepage/speechrecognition.dart';
import 'package:http/http.dart' as http;

final Color backgroundColor = Color(0xFF4A4A58);
final Color backgroundColor2 = Color(0x9A4A4A58);
class UserDetails{
  String name;
  String email;
  String dob;
  String phone;
  UserDetails({this.name,this.email,this.dob,this.phone});

  factory UserDetails.get(json){
    return UserDetails(
      name: json['name'],
      email: json['email'],
      dob: json['dob'],
      phone: json['phone']
    );
  }
}

class HomePage extends StatefulWidget{
  UserEmail user;
  
  HomePage({ @required this.user}
  
  ) ;
  @override
  _HomePage createState() => _HomePage(user:user.user);
}
class _HomePage extends State<HomePage> with SingleTickerProviderStateMixin{
    String user;
    _HomePage({@required this.user});
    bool isCollapsed = false;
    bool settingsPressed = false;
    double screenWidth,screenHeight;
    final Duration duration = Duration(milliseconds: 600);
    AnimationController _controller;
    Animation<Offset> slideAnimation ;
    UserDetails details;
    bool quickgude = false;
    bool voiceSearch = false;
    bool genreSearch = false;
    bool bookGallery = false;
    //fetchUserData();
    @override
    void initState(){
    // TODO: implement initState
    super.initState();
    //fetchUserData();
    isCollapsed = false;
    settingsPressed = false;
    print('in init state');
    fetchAll(user);
  }
  void fetchAll(user) async{
    final response = await http.get('http://127.0.0.1:5000/getuser/'+user);
    details = UserDetails.get(json.decode(response.body));
    print(details.dob);
  }
  @override
  Widget build(BuildContext context){
      Size size = MediaQuery.of(context).size;
      screenWidth = size.width;
      screenHeight = size.height;

    return Scaffold(
      backgroundColor: black,
      body: Stack(
        children: <Widget>[
            dashBoard(context),
            mainPage(context),
            
            
        ]),
    );
  }
  Widget dashBoard(context){
    double c=-0.3*screenWidth,d=0.3*screenWidth;
        if(isCollapsed){
          c = 0;
          d = 0;
        }
        if(settingsPressed){
          c = 0;
          d = 0;
        }
    return AnimatedPositioned(
    
          duration: duration,
          left: c,
          right: d,
          child: Container(
          child: Padding(
          padding: const EdgeInsets.only(left: 60,right: 60,top: 100),
          child: Container(
            
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
              Align(
              alignment: Alignment.centerLeft,
              
              child: Container(
                height: 470,
                width: 350,
                child: Material(
                  
                  borderRadius: BorderRadius.circular(10),
                  elevation: 10,
                  color: black,
                   child: Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Column(
                      
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          
                          padding: EdgeInsets.only(left:70),
                        child: Column(
                            
                            children: <Widget>[ 
                              Image(image: NetworkImage('https://previews.123rf.com/images/yupiramos/yupiramos1609/yupiramos160912741/62358463-avatar-man-smiling-cartoon-with-beard-male-person-user-vector-illustration.jpg'),
                                height: 150,width: 150
                                 ),
                              Text(user,style: TextStyle(color: white),)
                            ]
                            
                            ),
                        ),SizedBox(height: 20,),
                        Text('Dashboard',style: TextStyle(color: white,fontSize: 26),),SizedBox(height:0,),
                        Divider(thickness: 0.2,color: white,),
                        Padding(
                          padding: const EdgeInsets.only(left:8.0),
                          child: Column(
                            children :<Widget>[
                          InkWell(child: Row(children:<Widget>[SizedBox(width: 2,),Icon(Icons.exit_to_app,color:white),SizedBox(width: 4,),Text('Issue',style: TextStyle(color: white,fontSize: 16),)]),
                              onTap: (){
                                Navigator.push(context, 
                                MaterialPageRoute(builder: (context)=> IssueBook())
                                );
                              },
                          ),SizedBox(height: 6,width: 0,),
                          InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute( builder: (context) => Return() ));
                            },
                            child: Row(children:<Widget>[Icon(Icons.keyboard_return,color:white),SizedBox(width: 4,),Text('Return',style: TextStyle(color: white,fontSize: 16),)])),SizedBox(height: 6,width: 0,),
                          InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Dues()));
                            },
                            child: Row(children:<Widget>[Icon(Icons.swap_vertical_circle,color:white),SizedBox(width: 4,),Text('pending',style: TextStyle(color: white,fontSize: 16),)])),SizedBox(height: 6,width: 0,),
                          InkWell(child: Row(children:<Widget>[Icon(Icons.add,color:white),SizedBox(width: 4,),Text('Add Books',style: TextStyle(color: white,fontSize: 16),)]),
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Bookfill()));
                            },
                          ),SizedBox(height: 6,width: 0,),
                          InkWell(child: Row(children:<Widget>[Icon(Icons.arrow_back,color:white),SizedBox(width: 4,),Text('Logout',style: TextStyle(color: white,fontSize: 16),)]),
                                  onTap:(){
                                    Navigator.push(context,
                                    MaterialPageRoute(builder: (context) => HomeLogin()));
                                  },),
                            ]
                            )
                        )
                      ]
                  ),
                   ),
                ),
              ),
              
            ),
            //SizedBox(height: 900,width:100,),
            Align(
            alignment: Alignment.centerRight,
            
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('General',style: TextStyle(color: white,fontSize: 22),),SizedBox(height: 6,),
                Text('Privacy',style: TextStyle(color: white,fontSize: 22),),SizedBox(height: 6,),
                Text('Accounts',style: TextStyle(color: white,fontSize: 22),),SizedBox(height: 6,),
                InkWell(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) =>RacksPageView()));
                  },
                  child :Text('BookRack',style: TextStyle(color: white,fontSize: 22),)),SizedBox(height: 6,),
                InkWell(child: Text('day/night mode',style: TextStyle(color: white,fontSize: 22),),
                onTap: (){setState(() {
                  Color temp = white;
                  white = black;
                  black = temp;
                });},),
              ]
            ),
            
          ),
            ],)),
          // child: Align(
          //   alignment: Alignment.centerLeft,
            
          //   child: Column(
          //     mainAxisSize: MainAxisSize.min,
          //     mainAxisAlignment: MainAxisAlignment.spaceAround,
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: <Widget>[
          //       Text('xxxxxx',style: TextStyle(color: Colors.white,fontSize: 22),),SizedBox(height: 6,),
          //       Text('xxxxxx',style: TextStyle(color: Colors.white,fontSize: 22),),SizedBox(height: 6,),
          //       Text('xxxxxx',style: TextStyle(color: Colors.white,fontSize: 22),),SizedBox(height: 6,),
          //       Text('xxxxxx',style: TextStyle(color: Colors.white,fontSize: 22),),SizedBox(height: 6,),
          //       Text('xxxxxx',style: TextStyle(color: Colors.white,fontSize: 22),),
          //     ]
          //   ),
            
          // ),
        ),
      ),
    );
    
  }
  Widget mainPage(context){
        double a=0,b=0,c=0,d=0;
        if(isCollapsed){
          a = 0.1*screenHeight;
          b = 0.1*screenHeight;
          c = 0.3*screenWidth;
          d = -0.3*screenWidth;
        }
        if(settingsPressed){
          a = 0.1*screenHeight;
          b = 0.1*screenHeight;
          c = -0.2*screenWidth;
          d = 0.2*screenWidth;
        }

      return AnimatedPositioned(
          duration: duration,
          top: a,
          bottom:b,
          left: c,
          right: d,
          
              child: Material(
                borderRadius: BorderRadius.circular(10),
            animationDuration: duration,
            elevation: 10,
            color: black,
            child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                physics: ClampingScrollPhysics(),
                 child: Container(
                 padding: const EdgeInsets.only(left: 20 ,right : 20, top:20),
                 child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: <Widget>[
                     Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           mainAxisSize: MainAxisSize.max,
                           children:[
                           InkWell(child: Icon(Icons.menu,color: white,),onTap: (){
                           setState(() {
                               isCollapsed = !isCollapsed;
                           });}),
                           Text('Main Page',style: TextStyle(color: white,fontSize: 18),),
                           InkWell(child: Icon(Icons.settings,color: white,),onTap: (){
                           setState(() {
                             settingsPressed = !settingsPressed;
                           });})
                           
                         ]
                     ),
                     Divider(color: white,thickness: 0.2,),
                     SizedBox(height: 30,),
                     Container(
                         height: 200,
                       child: PageView(
                           controller: PageController(
                             initialPage: 1,
                             viewportFraction: 0.5),
                           
                           scrollDirection: Axis.horizontal,
                           pageSnapping: true,
                           children: [
                            
                               Container(
                                   margin: const EdgeInsets.symmetric(horizontal:8),
                                   color: Colors.transparent,
                                   child: Image(image: NetworkImage('https://image.marriage.com/advice/wp-content/uploads/2018/12/14-1024x507.png'),
                                     ),
                               ),
                               Container(
                                   margin: const EdgeInsets.symmetric(horizontal:8),
                                   color: Colors.transparent,
                                   child: Image(image: NetworkImage('http://bilingualmonkeys.com/wp-content/uploads/2013/09/Quote-Book-is-a-gift.gif'),)
                               ),
                               Container(
                                   margin: const EdgeInsets.symmetric(horizontal:8),
                                   color: Colors.transparent,
                                   width: 20,
                                   child: Image(image: NetworkImage('https://1zl13gzmcsu3l9yq032yyf51-wpengine.netdna-ssl.com/wp-content/uploads/2018/02/CBrownQuote3-1068x561.jpg')),
                               ),
                               Container(
                                   margin: const EdgeInsets.symmetric(horizontal:8),
                                   color: Colors.yellow[50],
                                   width: 20,
                               ),
                           ],
                           ),
                     ), 
                     //SizedBox(height: 100,width: 100,),
                     
                     Row(
                        children: [
                          Container(
                         height: 350,
                         width: 300,
                         color: Colors.transparent,
                         child:Stack(children: [
                           bottomQuickGuide(),
                           topQuickGuide(),
                           
                         ],),
                       ),
                      
                       Container(
                         height: 350,
                         width: 300,
                         color: Colors.transparent,
                         child:Stack(children: [
                           bottomVoiceSearch(),
                           topVoiceSearch(),
                           
                         ],),
                       ),
                        Container(
                         height: 350,
                         width: 300,
                         color: Colors.transparent,
                         child:Stack(children: [
                           bottomGenreSearch(),
                           topGenreSearch(),
                           
                         ],),
                       ),
                        Container(
                         height: 350,
                         width: 300,
                         color: Colors.transparent,
                         child:Stack(children: [
                           bottomBookGallery(),
                           topBookGallery(),
                           
                         ],),
                       ),
                       
                       ]
                     )  
                 ],
                   ),
              ),
            ),
        ),
      );
  }
  Widget topQuickGuide(){
    return AnimatedPositioned(
      top:160,
      bottom: 40,
      left: 10,
      right :10,
      duration: Duration(milliseconds: 1000),
      child: Material(
        borderOnForeground: true,
      borderRadius: BorderRadius.circular(10),
      color: black,
      elevation: 14,
        child: FlatButton(
          child: Column(crossAxisAlignment: CrossAxisAlignment.center,children: <Widget>[
            SizedBox(height: 10,),
            Icon(Icons.play_arrow,color: white,size: 80,),
            Text('Quick Guide',style: TextStyle(color: white,fontSize: 20,fontWeight: FontWeight.w600),),
          ],),
          onPressed: (){setState(() {
          quickgude = !quickgude;
          print(quickgude);
        });},
        ),
        
        ),
    );
  }
  Widget bottomQuickGuide(){
    return AnimatedPositioned(
      top: quickgude ? 110 :160,
      bottom: quickgude ? 90 : 40,
      left: 10,
      right :10,

      duration: Duration(milliseconds: 1000),
      child: Material(
      borderRadius: BorderRadius.circular(10),
      color: black,
      elevation: 14,
      child: Container(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:[ 
            RaisedButton(
            elevation: 14,
            color: black,
            hoverColor: black,
            child: Text('Get Started',style: TextStyle(color: white),),
            onPressed: (){},
          ),]
        ),
      ),
        ),
    );
  }
  Widget topVoiceSearch(){
     return AnimatedPositioned(
      top:160,
      bottom: 40,
      left: 10,
      right :10,
      duration: Duration(milliseconds: 1000),
      child: Material(
        borderOnForeground: true,
      borderRadius: BorderRadius.circular(10),
      color: black,
      elevation: 14,
        child: FlatButton(
          child: Column(crossAxisAlignment: CrossAxisAlignment.center,children: <Widget>[
            SizedBox(height: 15,),
            Icon(Icons.mic,color: white,size: 70,),
            SizedBox(height: 5,),
            Text('Voice Search',style: TextStyle(color: white,fontSize: 20,fontWeight: FontWeight.w600),),
          ],),
          onPressed: (){setState(() {
          voiceSearch = !voiceSearch;
          //print(quickgude);
        });},
        ),
        
        ),
    );
  }
  Widget bottomVoiceSearch(){
    return AnimatedPositioned(
      top: voiceSearch ? 70 :160,
      bottom: voiceSearch ? 130 : 40,
      left: 10,
      right :10,

      duration: Duration(milliseconds: 1000),
      child: Material(
      borderRadius: BorderRadius.circular(10),
      color: black,
      elevation: 14,
      child: Container(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[ 
              Text('The genre of a book is searched based on speech',style: TextStyle(color: white,fontSize: 15),),
              Row(mainAxisAlignment: MainAxisAlignment.end,children: [
                RaisedButton(
              elevation: 14,
              color: black,
              hoverColor: black,
              child: Text('Try',style: TextStyle(color: white),),
              onPressed: (){
                Navigator.push(context,
                MaterialPageRoute(builder: (context) => Speechrecognition()));
              },
            ),
              ],),
              ]
          ),
        ),
      ),
        ),
    );
  }
  Widget topGenreSearch(){
    return AnimatedPositioned(
      top:160,
      bottom: 40,
      left: 10,
      right :10,
      duration: Duration(milliseconds: 1000),
      child: Material(
        borderOnForeground: true,
      borderRadius: BorderRadius.circular(10),
      color: black,
      elevation: 14,
        child: FlatButton(
          child: Column(crossAxisAlignment: CrossAxisAlignment.center,children: <Widget>[
            SizedBox(height: 15,),
            Icon(Icons.search,color: white,size: 70,),
            SizedBox(height: 5,),
            Text('Genre Search',style: TextStyle(color: white,fontSize: 20,fontWeight: FontWeight.w600),),
          ],),
          //child: Text('Genre Search',style: TextStyle(color: white,fontSize: 30),),
          onPressed: (){setState(() {
          genreSearch = !genreSearch;
          //print(quickgude);
        });},
        ),
        
        ),
    );
  }
  Widget bottomGenreSearch(){
    return AnimatedPositioned(
      top: genreSearch ? 70 :160,
      bottom: genreSearch ? 130 : 40,
      left: 10,
      right :10,

      duration: Duration(milliseconds: 1000),
      child: Material(
      borderRadius: BorderRadius.circular(10),
      color: black,
      elevation: 14,
      child: Container(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[ 
              Text('The genre of a book is searched based on BookName',style: TextStyle(color: white,fontSize: 15),),
              Row(mainAxisAlignment: MainAxisAlignment.end,children: [
                RaisedButton(
              elevation: 14,
              color: black,
              hoverColor: black,
              child: Text('Try',style: TextStyle(color: white),),
              onPressed: (){
                Navigator.push(context,
                MaterialPageRoute(builder: (context) => Http()));
              },
            ),
              ],),
              ]
          ),
        ),
      ),
        ),
    );
  }
  Widget topBookGallery(){
    return AnimatedPositioned(
      top:160,
      bottom: 40,
      left: 10,
      right :10,
      duration: Duration(milliseconds: 1000),
      child: Material(
        borderOnForeground: true,
      borderRadius: BorderRadius.circular(10),
      color: black,
      elevation: 14,
        child: FlatButton(
          child: Column(crossAxisAlignment: CrossAxisAlignment.center,children: <Widget>[
            SizedBox(height: 15,),
            Icon(Icons.image,color: white,size: 70,),
            SizedBox(height: 5,),
            Text('Book Gallery',style: TextStyle(color: white,fontSize: 20,fontWeight: FontWeight.w600),),
          ],),
          onPressed: (){setState(() {
          bookGallery = !bookGallery;
          //print(quickgude);
        });},
        ),
        
        ),
    );
  }
  Widget bottomBookGallery(){
    return AnimatedPositioned(
      top: bookGallery ? 70 :160,
      bottom: bookGallery ? 130 : 40,
      left: 10,
      right :10,

      duration: Duration(milliseconds: 1000),
      child: Material(
      borderRadius: BorderRadius.circular(10),
      color: black,
      elevation: 14,
      child: Container(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[ 
              Text('Gallery of Books',style: TextStyle(color: white,fontSize: 15),),
              Text('Search your Favourites here',style: TextStyle(color: white,fontSize: 15),),
              Row(mainAxisAlignment: MainAxisAlignment.end,children: [
                RaisedButton(
              elevation: 14,
              color: black,
              hoverColor: black,
              child: Text('Try',style: TextStyle(color: white),),
              onPressed: (){
                Navigator.push(context,
                MaterialPageRoute(builder: (context) => BookView()));
              },
            ),
              ],),
              ]
          ),
        ),
      ),
        ),
    );
  }
}
