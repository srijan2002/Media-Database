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
              colors: [Color(0xFF14161B).withOpacity(0.89), Color(0xFF14161B), Color(0xFF1A1A2E), Colors.black87])
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 90, 50, 0),
              child: Container(
                decoration: BoxDecoration(
                    color: Color(0xFFD458F2).withOpacity(0.15),
                    borderRadius: BorderRadius.circular(25.0),
                    border: Border.all(width: 2.1,color: Color(0xFF9842CF))
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(50,7,50,7),
                  child: Text(
                    " Loading ",
                    style: TextStyle(
                        fontFamily: 'Mont',
                        fontWeight:FontWeight.w400,
                        color: Colors.white,
                        fontSize: 26.0,
                        letterSpacing: 2.0
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 100.0,),
            Center(
              child: SpinKitFadingCube(
                color: Colors.white,
                size: 50.0,
              ),
            ),
          ],
        ),
      ),
    )
    ;
  }
}

