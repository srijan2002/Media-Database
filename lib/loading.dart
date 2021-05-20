import 'dart:ui';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.blue.shade500,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.red, Colors.purpleAccent]
          )
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(30,90,50,0),
              child: Text(
                " LOADING ...",
                style: TextStyle(
                    fontFamily: 'Playfair',
                    fontWeight:FontWeight.bold,
                    color: Colors.blue,
                    fontStyle: FontStyle.italic,
                    fontSize: 32.0,
                    letterSpacing: 2.5
                ),
              ),
            ),
            SizedBox(height: 60.0,),
            Center(
              child: SpinKitFadingCube(
                color: Colors.white,
                size: 50.0,
              ),
            ),
            SizedBox(height: 230.0,),
            FlatButton.icon(
              onPressed: (){
                Navigator.pushReplacementNamed(context,'/home');
              },
              label: Text(""
                  "BACK",
                style: TextStyle(
                  fontSize: 20.0,
                  fontFamily: 'Playfair',
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic
                ),
              ),
              color: Colors.yellow,
              icon: Icon(Icons.arrow_back_rounded),
            )
          ],
        ),
      ),
    )
    ;
  }
}

