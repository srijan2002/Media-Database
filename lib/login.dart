import 'dart:collection';
import 'dart:convert';
import 'dart:math';
import 'dart:ui';
import 'dart:core';
import 'package:flutter/material.dart';
import 'loading.dart';
import 'display.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sizer/sizer.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'models/sign_inState.dart';



class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String sign ="Login";
  bool isLoggedIn;
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

   Future initLogin() async{

     if( await _googleSignIn.isSignedIn()==true)
       await Future.delayed(Duration(milliseconds: 0)).then((value) =>
           Navigator.pushReplacementNamed(context, '/home'));
     

  }
  _login() async
  {
    try {
      await _googleSignIn.signIn();
      Firestore ob = Firestore();

      setState(() {
        log=Log(_googleSignIn.currentUser.id,_googleSignIn.currentUser.photoUrl,_googleSignIn.currentUser.displayName);
        isLoggedIn=true;
        print(log.sign);
      });
      ob.collection('users').document(_googleSignIn.currentUser.id).setData({
      },
          merge: true
      );
      DocumentReference ref= Firestore.instance.collection('users').document(_googleSignIn.currentUser.id);
      DocumentSnapshot doc =await ref.get();
      List tags =doc.data['Titles'];
      List tag = doc.data['Links'];

        ref.updateData({
          'Titles': FieldValue.arrayUnion([]),
          'Links': FieldValue.arrayUnion([])
        } );

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
      log=Log("","","");
    });
  }
  @override
  Widget build(BuildContext context) {
     initLogin();
      bool flag;
      return Sizer(
        builder: (context, orientation, deviceType) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(

        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 80, 0, 0),
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Kindly Sign-in to continue !",
                    style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'MontB',
                        color: Colors.white
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.0,),
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 30, 40, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton.icon(
                    // color: Colors.lightGreenAccent,
                    onPressed: () {
                        _login();
                    },
                    icon: Icon(Icons.login_outlined,
                      color: Colors.white70,),
                    style: ButtonStyle(

                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.0),
                                side: BorderSide(color: Colors.white70,
                                    width: 1.9)
                            )
                        )
                    ),
                    label: Text(
                      "$sign ",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17.0,
                          letterSpacing: 1.2,
                          fontFamily: 'Mont',
                          color: Colors.white

                      ),
                    ),
                  ),
                  
                ],
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
