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
      // backgroundColor: Colors.black45,

      body:  Container(
        decoration: BoxDecoration(
          gradient:LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [Color(0xFF14161B).withOpacity(0.89), Color(0xFF14161B), Color(0xFF1A1A2E), Colors.black87]),
        ),

        child: Padding(
            padding: const EdgeInsets.fromLTRB(8,90,8,0),
            child: Column(
              children: [
                Container(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFD458F2).withOpacity(0.15),
                      borderRadius: BorderRadius.circular(22.0),
                     border: Border.all(width: 2.1,color: Color(0xFF9842CF))
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15, 5, 15, 8),
                      child: Text(
                        "The Media Database",
                        style: TextStyle(
                            fontSize: 24,
                            fontFamily: 'Mont',
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                            letterSpacing: 1.2
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [

                    TextButton.icon(
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
                                            fontSize: 17.0,
                                            fontFamily: 'Mont',
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 1.5,
                                            color: Colors.black45
                                          ),
                                        ),
                                        CloseButton(
                                          color: Colors.red[400],
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
                              Icons.search,
                            color: Color(0xFFA941BA),
                          ),
                        style: ButtonStyle(
                         backgroundColor: MaterialStateProperty.all(Color(0xFFD458F2).withOpacity(0.1)),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0),
                                side: BorderSide(color:Color(0xFF9842CF),
                                    width: 1.9)
                            )
                          )
                        ),
                          label: Text(
                            "Search ",
                            style: TextStyle(
                                fontFamily: 'Mont',
                                fontWeight: FontWeight.w400,
                                letterSpacing: 1.2,
                                fontSize: 17.0,
                                color: Colors.white

                            ),
                          ),
                          // colors:Colors.purpleAccent
                      ),

                    TextButton.icon(
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
                                          fontSize: 17.0,
                                          fontFamily: 'Playfair',
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1.5,
                                           color: Colors.black45
                                      ),
                                    ),
                                    CloseButton(
                                      color: Colors.white,
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
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Color(0xFFD458F2).withOpacity(0.1)),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16.0),
                                    side: BorderSide(color: Color(0xFF9842CF),
                                        width: 1.9)
                                )
                            )
                        ),
                        icon: Icon(
                            Icons.star,
                          color: Color(0xFFA941BA),

                        ),
                        label: Text(
                          "Favorites ",
                          style: TextStyle(
                              fontFamily: 'Mont',
                              fontWeight: FontWeight.w400,
                              letterSpacing: 1.2,
                              fontSize: 17.0,
                              color: Colors.white
                          ),
                        ),
                        // color:Colors.blue.shade400
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                   children: [
                     TextButton.icon(
                       // color: Colors.lightGreenAccent,
                       onPressed: () {
                           _login(T);
                       },
                       icon: Icon(Icons.login_outlined,
                         color: Color(0xFFA941BA),),
                       style: ButtonStyle(
                           backgroundColor: MaterialStateProperty.all(Color(0xFFD458F2).withOpacity(0.1)),
                           shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                               RoundedRectangleBorder(
                                   borderRadius: BorderRadius.circular(16.0),
                                   side: BorderSide(color: Color(0xFF9842CF),
                                       width: 1.9)
                               )
                           )
                       ),
                       label: Text(
                           "Sign-In ",
                         style: TextStyle(
                           fontWeight: FontWeight.w400,
                           fontSize: 17.0,
                           letterSpacing: 1.2,
                           fontFamily: 'Mont',
                           color: Colors.white

                         ),
                       ),
                     ),
                     TextButton.icon(
                       // color: Colors.white,
                       onPressed: (){
                         // if(isLoggedIn==true)
                         _logout();
                       },
                       icon: Icon(Icons.logout,
                         color: Color(0xFFA941BA),),
                       style: ButtonStyle(
                           backgroundColor: MaterialStateProperty.all(Color(0xFFD458F2).withOpacity(0.1)),
                           shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                               RoundedRectangleBorder(
                                   borderRadius: BorderRadius.circular(16.0),
                                 side: BorderSide(color: Color(0xFF9842CF),
                                 width: 1.9
                                 )
                               )
                           )
                       ),
                       label: Text(
                           "Sign-Out ",
                         style: TextStyle(
                             fontWeight: FontWeight.w400,
                             fontSize: 17.0,
                             letterSpacing: 1.2,
                             fontFamily: 'Mont',
                             color: Colors.white
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
                  decoration: InputDecoration(
                  hintText: (t1.text=="")?"Enter Movie/Series Name":"" ,
                    hintStyle: Theme.of(context).textTheme.caption.copyWith(
                      color: Colors.purpleAccent,
                      fontSize: 19.0
                    )
                  ),
                  controller: t1,
                  style: TextStyle(
                      fontSize: 20.0,
                      fontFamily: 'Mont',
                      fontWeight: FontWeight.w400,
                      color: Colors.purpleAccent,
                      letterSpacing: 1.8,
                  ),
                )
              ],
            ),
          ),
      ),
    );
  }
}
