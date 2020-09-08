

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homepage/ShelfBooks.dart';

import 'homelogin.dart';

int rackno = 1;
int shelfno = 1;

class BookStorage extends StatefulWidget {
  @override
  _BookStorageState createState() => _BookStorageState();
}

class _BookStorageState extends State<BookStorage> {
  @override
  Widget build(BuildContext context) {

    final racks = new TextEditingController();
    final selfs = new TextEditingController();
    final count = new TextEditingController();
    
    return Scaffold(
      

      appBar:AppBar(
        backgroundColor: Colors.black,

        leading: IconButton(
          icon: Icon(Icons.home),
        ),

      ),

      body: Material(
        
        child: Padding(

          padding: const EdgeInsets.only(left : 400,right : 400),
          child: Column(
            
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: racks,

                decoration: InputDecoration(
                labelText: 'Racks '

                ),
              ),

              TextField(
                controller: selfs,
                decoration: InputDecoration(
                  labelText: 'selfs'
                ),
                
              ),
              TextField(
                controller: count,
                decoration: InputDecoration(
                  labelText: 'count'
                ),
                
              ),
              RaisedButton(
                elevation: 6,
                onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => RacksPageView()));
                },
                child: Text('Get'),
              )
            ],
          ),
        ),

      ),
    );
  }
}

class RacksPageView extends StatefulWidget {
  @override
  _RacksPageViewState createState() => _RacksPageViewState();
}

class _RacksPageViewState extends State<RacksPageView> {
  int racknumber = 1;
  bool isclicked = false;
  bool isSearch = true;
  final pagecount = new TextEditingController();
  List<String> genres = ['','Fiction','Novel','Thriller','Mystery','Fantasy','Suspense','Horror','Biography','Children','Magical',''];
  List<String> genreImages = ['',
    'https://static.telegraphindia.com/library/THE_TELEGRAPH/image/2019/7/0b14c9c9-63b9-482a-a66d-c81be41ae79f.jpg',
    'https://usercontent1.hubstatic.com/13042594_f520.jpg',
    'https://www.dailydot.com/wp-content/uploads/1e6/91/a97d759507a0c3858ec73efaebbfe175-800x400.jpg',
    'https://marketing.prowritingaid.com/Mystery%20books.jpg',
    'https://cdn.pixabay.com/photo/2018/01/12/10/19/fantasy-3077928_960_720.jpg',
    'https://images-cdn.reedsy.com/discovery/post/48/featured_image/medium_ab34e22e3863779512294835cf6f6b133bfb5838.jpg',
    'https://i.ytimg.com/vi/aw8h0GQyamo/maxresdefault.jpg',
    ''
  ];
  final controller = new PageController(
    viewportFraction: 0.2,
  );
  @override
  Widget build(BuildContext context) {
    bool isSearch = true;
    int pagenumber = 3;
    
    return Scaffold(


      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(0.7),
      ),
       body: Container(
         decoration: BoxDecoration(
           image: DecorationImage(
             image: NetworkImage('https://images.hdqwalls.com/download/blur-blue-gradient-cool-background-sp-2048x1152.jpg') 
             ,fit: BoxFit.cover
             )
         ),
         child: Stack(children: [
           
           rackspage(),
           selfpage(),
           searchbar(),
           
         ],),
       ),
    );
  }

  Widget rackspage(){
    int pagenumber = 3;
    @required Curve curve;
    return Padding(
      padding: const EdgeInsets.only(top:50),
      child: PageView.builder(
            allowImplicitScrolling: true,
            scrollDirection: Axis.horizontal,
            controller: controller,
            itemCount: 6,
            itemBuilder: (context,index){
              index += 1;
              return Container(
                color: Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20,80,20,50),
                  child: Material(
                    borderRadius: BorderRadius.circular(10),
                    elevation: 7,
                    child: RaisedButton(
                      padding: EdgeInsets.zero,
                      hoverElevation: 20,
                      onPressed: (){

                        
                        setState(() {
                          
                          racknumber = index;
                          isclicked = true;
                          isSearch = false;
                        });
                      },
                      color: Colors.transparent,

                      child: Stack(children: [
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              
                              fit: BoxFit.cover,
                              image: NetworkImage(genreImages[index])
                            )
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage('https://ya-webdesign.com/transparent250_/css-png-shadow-6.png')
                            )
                            
                          ),
                          child: Center(
                            child: Text(genres[index],style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 10,
                              fontFamily: 'Console'
                              ),),
                          ),
                        ),
                        Container(

                          width: double.infinity,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              
                              image: NetworkImage('https://ya-webdesign.com/transparent250_/shadow-png-13.png')
                            )
                            
                          ),
                          child: Text(
                            'Rack No : '+(index).toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                            fontFamily: 'Console'
                            
                            ),),
                        ),
                        ]
                      ),
                    ),
                  ),
                ),
              );
            },
        ),
    );
  }

  Widget selfpage(){
    return AnimatedPositioned(
      top: isclicked ? 0 : 700,
      right: 0,
      left: 0,
      bottom: isclicked ?0 : -700,
      curve: Curves.bounceInOut,
      duration: Duration(milliseconds: 700),
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.black.withOpacity(0.3),
            child: Icon(Icons.arrow_back),
            onPressed: (){
              setState(() {
                isSearch = true;
                isclicked = false;
              });

            }
            ,
          ),
        backgroundColor: Colors.transparent.withOpacity(0.7),
        body: Stack(
          children: [
            
              AnimatedPositioned(
                left: 0,
                top: 300,
                right: 0,
                bottom: 0,
                duration: Duration(milliseconds: 700),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(80),

                    image: DecorationImage(
                      
                      image: NetworkImage(
                        genreImages[racknumber]
                        
                        ),
                      fit: BoxFit.cover
                      
                    )
                  ),
                  child: Material(
                    color: Colors.transparent.withOpacity(0.5),
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(80),topRight:Radius.circular(80)),
                    elevation: 100,
                    child: Padding(
                      padding: const EdgeInsets.only(left:20,right: 20),
                      child: selfpageview(),
                    ),
                  ),
                ),
              ),
              AnimatedPositioned(
                left: 400,
                top: 240,
                right: 400,
                bottom: 240,
                duration: Duration(milliseconds: 300),
                child: Container(
                  //color: Colors.transparent,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      
                      image: NetworkImage('https://images.hdqwalls.com/download/blur-blue-gradient-cool-background-sp-2048x1152.jpg'),
                      fit: BoxFit.cover
                      
                    )
                  ),
                  child: Material(

                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                    elevation: 16,
                    child: Center(child: Text(

                      genres[racknumber]+' Rack'.toString(),
                      style: TextStyle(
                        shadows: [
                          Shadow(
                            color: Colors.black87,
                            offset: Offset(2,2)
                          )
                        ],
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 8
                      ),
                      )
                      
                      ),
                  ),
                ), 
              ),

            ]
        ),
      ) ,
    );
  }
  Widget selfpageview(){
    return PageView.builder(
      controller: PageController(
        viewportFraction: 0.15,
      ),
      scrollDirection: Axis.horizontal,
      itemBuilder: (context,index){
        index += 1;
        return Container(
          height: 5,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10)
          ),
          padding: const EdgeInsets.fromLTRB(40,90,40,20),
          child: RaisedButton(
            color:Colors.black.withOpacity(0.2),
            hoverElevation: 14,
            onPressed: (){
              setState(() {
                rackno = racknumber;
              shelfno = index;
              });
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => Shelfbooks()));
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                
                Text('Shelf No',
                style: TextStyle(
                  color: Colors.white
                  ,fontWeight: FontWeight.w700,
                  fontSize: 14
                ),)

                ,Text((index).toString(),
                style: TextStyle(color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: 72
                ),
                )
              ],
            ),
          ),
        );
      
      },
      itemCount: 20,
      );
  }

  Widget searchbar(){

    return AnimatedPositioned(
      top: 5,
      bottom: 460,
      left: isSearch ? 200 : -600,
      right: isSearch ? 200 : 1000,
      duration: Duration(milliseconds: 700),
      child: Align(
        child: SizedBox(
          //levation: 10,
          //borderRadius: BorderRadius.circular(10),
          height: 50,
          width: 150,
          child: Padding(
            padding: const EdgeInsets.all(5),
            // child: TextField(
            //                obscureText: true,
            //                //controller: passwordController,
            //                style: TextStyle(color: white,),
            //              cursorColor: white,
                           
            //              decoration: InputDecoration(
                         
            //                border: OutlineInputBorder(

            //                  borderSide: BorderSide(
            //                    color: white
            //                  )
            //                ),
            //                labelText: 'Password',
            //                labelStyle: TextStyle(color: white)
            //              ) ,
            //            ),
            //schild: TextField(),
            child: CupertinoTextField(
              controller: pagecount,
              suffix: IconButton(
                onPressed: (){
                  setState(() {
                    controller.animateToPage(
                      int.parse(pagecount.text)
                      , duration: Duration(milliseconds: 800),
                       curve: Curves.bounceOut);
                  });
                },
                icon: Icon(Icons.search),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class RackShelf{
  int rack;
  int shelf;

}