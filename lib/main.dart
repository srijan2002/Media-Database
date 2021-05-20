import 'dart:collection';
import 'dart:convert';
import 'dart:ui';
import 'package:http/http.dart';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:media_db/favorites.dart';
import 'loading.dart';
import 'display.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'disp_fav.dart';
import 'error.dart';
String T;
 void main() async  {
  runApp(MaterialApp(

    routes: {
      '/':(context)=>Home(),
      '/home':(context)=>Home(),
      '/loading':(context)=>Loading(),
      '/display':(context)=>Display(),
      '/favorites':(context)=>Disp_Fav(),
      '/error':(context)=>Error()
    },

  ));
}
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isLoggedIn;
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email','https://www.googleapis.com/auth/contacts.readonly',]);

  initLogin() {
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) async {
      if (account != null) {
        isLoggedIn=true;
      } else {
        isLoggedIn=false;
      }
    });
    _googleSignIn.signInSilently();
  }
  _login(String X) async
  {
    try {
      await _googleSignIn.signIn();
      Firestore ob = Firestore();

      setState(() {
        isLoggedIn=true;

      });
      ob.collection('users').document(_googleSignIn.currentUser.id).setData({
      },
      merge: true
      );
    }
    catch(err){
      print(err);
    }
  }

  _logout() async
  {
    await _googleSignIn.signOut();
    setState(() {
      isLoggedIn=false;
    });
  }

  var n="";
  final TextEditingController t1= new TextEditingController(text: "");

  void getData() async{

    Navigator.pushNamed(context,'/loading');
    Response response= await get("https://www.omdbapi.com/?t=$n&apikey=a018d195");
    Map data= jsonDecode(response.body);
      String X=data['imdbRating']; String Y=data['Plot'];
      String Z=data['Year'];String A=data['Genre'];
      T = data['Title'];
      String F=data['Actors'];
      if(data['Response']=="True")
       Navigator.popAndPushNamed(context,'/display', arguments: {'imdbRating': X, 'Plot':Y, 'Year':Z,'Genre':A,'Title':T,'Actors':F,'Goog':_googleSignIn.currentUser.id,});
      else
        Navigator.pushReplacementNamed(context, '/error');
  }
  @override
  void initState(){
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    initLogin();

    return Scaffold(
      // backgroundColor: Colors.deepPurple[900],
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.deepPurple[900], Colors.deepOrange[400]]
          )
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8,90,8,0),
          child: Column(
            children: [
              Container(
                child: Text(
                  "THE MEDIA DATABASE",
                  style: TextStyle(
                      fontSize: 28,
                      fontFamily: 'Playfair',
                      fontWeight: FontWeight.bold,
                      color: Colors.cyanAccent,
                      letterSpacing: 1.5
                  ),
                ),
              ),
              SizedBox(
                height: 32.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FlatButton.icon(
                      onPressed: () {
                        if(isLoggedIn==true) {
                          setState(() {
                            n = t1.text;
                          });
                          getData();
                        }
                        else
                          {
                            showDialog(context: context, builder:(context){
                              return AlertDialog(
                                backgroundColor: Colors.yellow[100],
                                title: Column(
                                  children: [
                                    Text(
                                        "PLEASE SIGN-IN FIRST !",
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        fontFamily: 'Playfair',
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 2.0
                                      ),
                                    ),
                                    CloseButton(
                                      color: Colors.red,
                                      onPressed: (){
                                        Navigator.pop(context);
                                      },
                                    )
                                  ],
                                ),
                              );
                            }
                            );
                          }
                      },
                      icon: Icon(
                          Icons.search
                      ),
                      label: Text(
                        "SEARCH",
                        style: TextStyle(
                            fontFamily: 'Playfair',
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                            fontSize: 19.0,
                            fontStyle: FontStyle.italic,
                            color: Colors.black87

                        ),
                      ),
                      color:Colors.purpleAccent
                  ),
                  FlatButton.icon(
                      onPressed: ()
                      {
                        if(isLoggedIn==true) {
                          Navigator.pushNamed(context,'/favorites',arguments: {'Goog':_googleSignIn.currentUser.id,'Title':T});
                        }
                        else {
                          showDialog(context: context, builder: (context) {
                            return AlertDialog(
                              backgroundColor: Colors.yellow[100],
                              title: Column(
                                children: [
                                  Text(
                                    "PLEASE SIGN-IN FIRST !",
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        fontFamily: 'Playfair',
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 2.0
                                    ),
                                  ),
                                  CloseButton(
                                    color: Colors.red,
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  )
                                ],
                              ),
                            );
                          }
                          );
                        }
                      },
                      icon: Icon(
                          Icons.star
                      ),
                      label: Text(
                        "FAVORITES",
                        style: TextStyle(
                            fontFamily: 'Playfair',
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                            fontSize: 19.0,
                            fontStyle: FontStyle.italic,
                            color: Colors.white
                        ),
                      ),
                      color:Colors.blue.shade400
                  ),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                 children: [
                   FlatButton.icon(
                     color: Colors.lightGreenAccent,
                     onPressed: () {
                         _login(T);
                     },
                     icon: Icon(Icons.login_outlined),
                     label: Text(
                         "SIGN-IN",
                       style: TextStyle(
                         fontStyle: FontStyle.italic,
                         fontWeight: FontWeight.bold,
                         fontSize: 18.0,
                         letterSpacing: 1.5,
                         fontFamily: 'Playfair'
                       ),
                     ),
                   ),
                   FlatButton.icon(
                     color: Colors.white,
                     onPressed: (){
                       // if(isLoggedIn==true)
                       _logout();
                     },
                     icon: Icon(Icons.logout),
                     label: Text(
                         "SIGN-OUT",
                       style: TextStyle(
                           fontStyle: FontStyle.italic,
                           fontWeight: FontWeight.bold,
                           fontSize: 18.0,
                           letterSpacing: 1.5,
                           fontFamily: 'Playfair'
                       ),
                     ),
                   )
                 ],
               ),
              SizedBox(
                height: 20.0,
              ),
              TextField(
                keyboardType: TextInputType.name,
                decoration: InputDecoration(labelText: "Enter Movie/Series Name"),
                controller: t1,
                style: TextStyle(
                    fontSize: 21.0,
                    fontFamily: 'Playfair',
                    fontWeight: FontWeight.bold,
                    color: Colors.cyanAccent,
                    letterSpacing: 2.0,
                    fontStyle: FontStyle.italic
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
