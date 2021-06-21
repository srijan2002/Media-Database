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
      backgroundColor: Colors.black,
      body: Container(

        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 90, 50, 0),
              child: Container(

                child: Padding(
                  padding: const EdgeInsets.fromLTRB(50,7,50,7),
                  child: Text(
                    " Loading ",
                    style: TextStyle(
                        fontFamily: 'Mont',
                        fontWeight:FontWeight.bold,
                        color: Colors.white,
                        fontSize: 26.0,
                        letterSpacing: 1.5
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 70.0,),
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

