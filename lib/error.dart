import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui';
import 'dart:core';
import 'package:sizer/sizer.dart';

class Error extends StatefulWidget {
  @override
  _ErrorState createState() => _ErrorState();
}
class _ErrorState extends State<Error> {
  @override
  Widget build(BuildContext context) {
    return Sizer(
        builder: (context, orientation, deviceType) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(
          color: Colors.white,
          size: 50.0,

        ),
      ),
      backgroundColor: Colors.black,
      body: Container(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 35, 10, 20),
          child: Container(
            width: 100.w,
            height: 100.h,

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(70, 90, 70, 50),
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 7, 0, 7),
                      child: Center(
                        child: Text(
                            "Error In Result !",
                            style: TextStyle(
                                fontSize: 17.sp,
                                fontFamily: 'Mont',
                                color: Colors.white,
                                fontWeight: FontWeight.bold
                            )
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 7, 0, 7),
                      child: Center(
                        child: Text(
                            "Incorrect Spelling",
                            style: TextStyle(
                                fontSize: 14.sp,
                                fontFamily: 'Mont',
                                letterSpacing: 1.55,
                                color: Colors.white,
                                fontWeight: FontWeight.bold
                            )
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  );
  }
}

