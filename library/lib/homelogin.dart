import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homepage/homepage.dart';
import 'package:http/http.dart' as http;

String userEmail;
final Color backgroundColor = Color(0xFF4A4A58);
final Color backgroundColor2 = Color(0x9A4A4A58);
Color black = Colors.white;
Color white = backgroundColor;

class HomeLogin extends StatefulWidget {
  @override
  Homelogin createState() => Homelogin();
}

class Homelogin extends State<HomeLogin> {
  final fullNameController = TextEditingController();

  double rotation = 0.15;
  bool isThirdLayer = false;
  bool isSecondLayer = false;
  double screenWidth, screenHeight;
  final Duration duration = Duration(milliseconds: 500);

  Future<void> _showMyDialog(textinfo) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: black,
          elevation: 10,
          title: Text(
            'Error',
            style: TextStyle(color: Colors.red),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  textinfo,
                  style: TextStyle(color: white),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            RaisedButton(
              color: black,
              hoverColor: black,
              focusColor: black,
              //autofocus: true,
              elevation: 14,
              child: Text(
                'Ok',
                style: TextStyle(
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

  @override
  Widget build(BuildContext) {
    Size size = MediaQuery.of(context).size;
    screenWidth = size.width;
    screenHeight = size.height;
    return Container(
      alignment: Alignment.center,
      child: Scaffold(
          backgroundColor: black,
          body: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(),
              child: Transform.rotate(
                angle: 0,
                child: Container(
                  child: Stack(
                    children: [secondLayer(), thirdLayer(), firstLayer()],
                  ),
                ),
              ))),
    );
  }

  StatefulWidget firstLayer() {
    return AnimatedPositioned(
      left: 490,
      right: 490,
      top: 130,
      bottom: 130,
      duration: duration,
      child: Container(
          height: 100,
          width: 50,
          child: Transform.rotate(
            angle: rotation,
            child: Material(
              borderRadius: BorderRadius.circular(10),
              color: black,
              elevation: 14,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Transform.rotate(
                      angle: -rotation,
                      child: SizedBox(
                        height: 32,
                        width: 200,
                        child: RaisedButton(
                          child: Text(
                            'Sign Up',
                            style: TextStyle(color: white),
                          ),
                          onPressed: () {
                            setState(() {
                              isSecondLayer = !isSecondLayer;
                              print(isSecondLayer);
                              if (isSecondLayer) {
                                rotation = 0;
                                isThirdLayer = false;
                              } else {
                                rotation = 0.15;
                              }
                            });
                          },
                          color: black,
                          elevation: 14,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Transform.rotate(
                      angle: -rotation,
                      child: SizedBox(
                        height: 32,
                        width: 200,
                        child: RaisedButton(
                          child: Text(
                            'Login',
                            style: TextStyle(color: white),
                          ),
                          onPressed: () {
                            setState(() {
                              isThirdLayer = !isThirdLayer;
                              if (isThirdLayer) {
                                rotation = 0;
                                isSecondLayer = false;
                              } else {
                                rotation = 0.15;
                              }
                            });
                          },
                          color: black,
                          elevation: 14,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Transform.rotate(
                      angle: -rotation,
                      child: SizedBox(
                        height: 32,
                        width: 200,
                        child: RaisedButton(
                          child: Text(
                            'day/night',
                            style: TextStyle(color: white),
                          ),
                          onPressed: () {
                            setState(() {
                              Color temp = white;
                              white = black;
                              black = temp;

                              print(white);
                              print(black);
                            });
                          },
                          color: black,
                          elevation: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }

  StatefulWidget secondLayer() {
    TextEditingController fullNameController = new TextEditingController();
    final emailController = new TextEditingController();
    final phoneController = new TextEditingController();
    final dobController = new TextEditingController();
    final passwordController = new TextEditingController();
    final confirmPasswordController = new TextEditingController();
    bool isFullNameValid = true;
    double a = 490, b = 490;
    if (isSecondLayer) {
      isThirdLayer = false;
    } else {
      a = 0;
      b = 0;
    }
    ;
    return AnimatedPositioned(
      left: isSecondLayer ? 160 : 490,
      right: isSecondLayer ? 790 : 490,
      top: isSecondLayer ? 50 : 130,
      bottom: isSecondLayer ? 50 : 130,
      duration: duration,
      child: Container(
        child: Transform.rotate(
          angle: 0,
          child: Material(
            borderRadius: BorderRadius.circular(10),
            color: black,
            animationDuration: duration,
            elevation: 14,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                child: Container(
                  padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 30),
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          'Sign Up',
                          style: TextStyle(color: white, fontSize: 22),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 40,
                        //width: 180,
                        child: Theme(
                          data: new ThemeData(
                            primaryColor: white,
                            primaryColorDark: white,
                          ),
                          child: new TextField(
                            controller: fullNameController,
                            style: TextStyle(color: white),
                            cursorColor: white,
                            decoration: InputDecoration(
                                errorText:
                                    isFullNameValid ? null : 'fill your name',
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: white)),
                                labelText: 'Full Name',
                                labelStyle: TextStyle(color: white)),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        height: 40,
                        //width: 180,
                        child: Theme(
                          data: new ThemeData(
                            primaryColor: white,
                            primaryColorDark: white,
                          ),
                          child: TextField(
                            controller: phoneController,
                            style: TextStyle(color: white),
                            cursorColor: white,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: white)),
                                labelText: 'Mobile Number',
                                labelStyle: TextStyle(color: white)),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        height: 40,
                        //width: 180,
                        child: Theme(
                          data: new ThemeData(
                            primaryColor: white,
                            primaryColorDark: white,
                          ),
                          child: TextField(
                            controller: emailController,
                            style: TextStyle(color: white),
                            cursorColor: white,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: white)),
                                labelText: 'Email',
                                labelStyle: TextStyle(color: white)),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        height: 40,
                        //width: 180,
                        child: Theme(
                          data: new ThemeData(
                            primaryColor: white,
                            primaryColorDark: white,
                          ),
                          child: TextField(
                            controller: dobController,
                            style: TextStyle(color: white),
                            cursorColor: white,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: white)),
                                labelText: 'Date of Birth',
                                labelStyle: TextStyle(color: white)),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        height: 40,
                        //width: 180,
                        child: Theme(
                          data: new ThemeData(
                            primaryColor: white,
                            primaryColorDark: white,
                          ),
                          child: TextField(
                            controller: passwordController,
                            style: TextStyle(color: white),
                            cursorColor: white,
                            obscureText: true,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: white)),
                                labelText: 'Password',
                                labelStyle: TextStyle(color: white)),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        height: 40,
                        //width: 180,
                        child: Theme(
                          data: new ThemeData(
                            primaryColor: white,
                            primaryColorDark: white,
                          ),
                          child: TextField(
                            style: TextStyle(color: white),
                            controller: confirmPasswordController,
                            cursorColor: white,
                            obscureText: true,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: white)),
                                labelText: 'Confirm Password',
                                labelStyle: TextStyle(color: white)),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      SizedBox(
                        height: 34,
                        width: 140,
                        child: RaisedButton(
                          color: black,
                          elevation: 14,
                          child: Text(
                            'Sign Up',
                            style: TextStyle(color: white),
                          ),
                          onPressed: () {
                            setState(() {
                              bool a = fullNameController.text.isNotEmpty;
                              bool b = emailController.text.isNotEmpty;
                              bool c = phoneController.text.isNotEmpty;
                              bool d = passwordController.text.isNotEmpty;
                              bool e =
                                  confirmPasswordController.text.isNotEmpty;
                              bool f = dobController.text.isNotEmpty;

                              if (a && b && c && d && e && f) {
                                if (passwordController.text ==
                                    confirmPasswordController.text) {
                                  String attach = '';
                                  String divider = '_-_-_';
                                  attach += fullNameController.text + divider;
                                  attach += emailController.text + divider;
                                  attach += phoneController.text + divider;
                                  attach += dobController.text + divider;
                                  attach += passwordController.text;
                                  http.get(
                                      'http://127.0.0.1:5000/signup/' + attach);
                                } else {
                                  return _showMyDialog('Password not match');
                                }
                              } else {
                                return _showMyDialog('fill all details');
                              }
                            });

                            print('inside');
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
      ),
    );
  }

  StatefulWidget thirdLayer() {
    final usernameController = new TextEditingController();
    final passwordController = new TextEditingController();
    if (isThirdLayer) {
      isSecondLayer = false;
    }
    return AnimatedPositioned(
      left: isThirdLayer ? 790 : 490,
      right: isThirdLayer ? 190 : 490,
      top: isThirdLayer ? 180 : 130,
      bottom: isThirdLayer ? 180 : 130,
      duration: duration,
      child: Container(
        child: Transform.rotate(
          angle: 0,
          child: Material(
            borderRadius: BorderRadius.circular(10),
            color: black,
            animationDuration: duration,
            elevation: 14,
            child: Center(
              child: Container(
                padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 40,
                    ),
                    SizedBox(
                      height: 40,
                      //width: 180,
                      child: Transform.rotate(
                        angle: 0,
                        child: Theme(
                          data: new ThemeData(
                            primaryColor: white,
                            primaryColorDark: white,
                          ),
                          child: TextField(
                            controller: usernameController,
                            cursorColor: white,
                            style: TextStyle(color: white),
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: white)),
                                labelText: 'Username',
                                labelStyle: TextStyle(color: white)),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 40,
                      //width: 180,
                      child: Transform.rotate(
                        angle: 0,
                        child: Theme(
                          data: new ThemeData(
                            primaryColor: white,
                            primaryColorDark: white,
                          ),
                          child: TextField(
                            obscureText: true,
                            controller: passwordController,
                            style: TextStyle(
                              color: white,
                            ),
                            cursorColor: white,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: white)),
                                labelText: 'Password',
                                labelStyle: TextStyle(color: white)),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Transform.rotate(
                      angle: 0,
                      child: SizedBox(
                        height: 34,
                        width: 140,
                        child: RaisedButton(
                          color: black,
                          elevation: 14,
                          child: Text(
                            'Login',
                            style: TextStyle(color: white),
                          ),
                          onPressed: () async {
                            //Future<String> response;
                            if (usernameController.text.isNotEmpty &&
                                passwordController.text.isNotEmpty) {
                              //UserEmail ex;
                              final response = await http.get(
                                  'http://127.0.0.1:5000/login/' +
                                      usernameController.text);
                              if (passwordController.text ==
                                  json.decode(response.body)['password']) {
                                final userEmail = usernameController.text;

                                UserEmail ex = UserEmail.getUser(userEmail);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            HomePage(user: ex)));
                              } else if (json
                                      .decode(response.body)["password"] ==
                                  'CreateUser') {
                                await _showMyDialog(
                                    "You are a new user, please signup!");
                              } else {
                                await _showMyDialog(
                                    'username/password incorrect');
                              }
                            } else {
                              await _showMyDialog('Username/password empty');
                            }
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(children: [
                      Text(
                        'if you are a new User please ',
                        style: TextStyle(color: white),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      InkWell(
                        child: Text(
                          'Sign Up',
                          style: TextStyle(color: white),
                        ),
                        onTap: () {
                          setState(() {
                            isThirdLayer = false;
                            isSecondLayer = true;
                          });
                        },
                      )
                    ]),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class UserEmail {
  String user;
  UserEmail({this.user});
  factory UserEmail.getUser(tmp) {
    return UserEmail(user: tmp);
  }
}
