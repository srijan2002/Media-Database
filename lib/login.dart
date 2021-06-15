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
import 'package:sizer/sizer.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';



class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String sign ="Login";
  bool isLoggedIn;
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  initLogin() {
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) async {
      if (account != null) {
        setState(() {
          sign="Logout";
        });
        isLoggedIn=true;
      } else {
        setState(() {
          sign="Login";
        });
        isLoggedIn=false;
      }
    });
    _googleSignIn.signInSilently();
  }
  _login() async
  {
    try {
      await _googleSignIn.signIn();

      Firestore ob = Firestore();

      setState(() {
        isLoggedIn=true;
        sign="Logout";
      });
      ob.collection('users').document(_googleSignIn.currentUser.id).setData({
      },
          merge: true
      );
      Navigator.pushReplacementNamed(context, '/home');
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
      sign="Login";
    });
  }
  @override
  Widget build(BuildContext context) {
     initLogin();
      bool flag;

     if(isLoggedIn==true)
       flag=true;
     else
      flag=false;





    print(sign);
    return Sizer(
        builder: (context, orientation, deviceType) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient:LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [Color(0xFF14161B).withOpacity(0.89), Color(0xFF14161B), Color(0xFF1A1A2E), Colors.black87]),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 80, 0, 0),
              child: Container(
                decoration: BoxDecoration(
                    color: Color(0xFFD458F2).withOpacity(0.15),
                    borderRadius: BorderRadius.circular(25.0),
                    border: Border.all(width: 2.1,color: Color(0xFF9842CF))
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Kindly Sign-in to continue !",
                    style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Mont',
                        color: Colors.white
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 50.0,),
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 30, 40, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton.icon(
                    // color: Colors.lightGreenAccent,
                    onPressed: () {
                      if(sign=="Login") {
                        _login();

                      }
                      else {
                        _logout();
                      }
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
                      "$sign ",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 17.0,
                          letterSpacing: 1.2,
                          fontFamily: 'Mont',
                          color: Colors.white

                      ),
                    ),
                  ),
                  // TextButton.icon(
                  //   // color: Colors.white,
                  //   onPressed: (){
                  //
                  //     _logout();
                  //   },
                  //   icon: Icon(Icons.logout,
                  //     color: Color(0xFFA941BA),),
                  //   style: ButtonStyle(
                  //       backgroundColor: MaterialStateProperty.all(Color(0xFFD458F2).withOpacity(0.1)),
                  //       shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  //           RoundedRectangleBorder(
                  //               borderRadius: BorderRadius.circular(16.0),
                  //               side: BorderSide(color: Color(0xFF9842CF),
                  //                   width: 1.9
                  //               )
                  //           )
                  //       )
                  //   ),
                  //   label: Text(
                  //     "Sign-Out ",
                  //     style: TextStyle(
                  //         fontWeight: FontWeight.w400,
                  //         fontSize: 17.0,
                  //         letterSpacing: 1.2,
                  //         fontFamily: 'Mont',
                  //         color: Colors.white
                  //     ),
                  //   ),
                  // )
                ],
              ),
            ),
            Visibility(
              visible: flag,
              child: TextButton.icon(
                // color: Colors.lightGreenAccent,
                onPressed: () {
                  Navigator.pushReplacementNamed(context,'/home');
                },
                icon: Icon(Icons.arrow_back,
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
                  "Go to Home ",
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 17.0,
                      letterSpacing: 1.2,
                      fontFamily: 'Mont',
                      color: Colors.white

                  ),
                ),
              ),
            ),
          ],
        ),

      ),
    );
  }
  );
  }
}
