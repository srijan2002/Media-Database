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
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [
                Color(0xFF14161B).withOpacity(0.89),
                Color(0xFF14161B),
                Color(0xFF1A1A2E),
                Colors.black87
              ]),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 35, 10, 20),
          child: Container(
            width: 100.w,
            height: 100.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(width: 2.5, color: Color(0xFF7913B7)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(70, 90, 70, 50),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color(0xFFD458F2).withOpacity(0.15),
                        borderRadius: BorderRadius.circular(25.0),
                        border: Border.all(width: 2.1, color: Color(0xFF9842CF))
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 7, 0, 7),
                      child: Center(
                        child: Text(
                            "Error In Result !",
                            style: TextStyle(
                                fontSize: 15.sp,
                                fontFamily: 'Mont',
                                color: Colors.white,
                                fontWeight: FontWeight.w400
                            )
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color(0xFFD458F2).withOpacity(0.5),
                        borderRadius: BorderRadius.circular(25.0),
                        border: Border.all(width: 3.0, color: Color(0xFF4D0596))
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 7, 0, 7),
                      child: Center(
                        child: Text(
                            "Incorrect Spelling",
                            style: TextStyle(
                                fontSize: 13.sp,
                                fontFamily: 'Mont',
                                letterSpacing: 1.55,
                                color: Colors.white,
                                fontWeight: FontWeight.w400
                            )
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(90, 80, 100, 20),
                  child: TextButton.icon(
                    icon: Icon(Icons.arrow_back, color: Color(0xFFA941BA),),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Color(0xFFD458F2).withOpacity(0.1)),
                        shape: MaterialStateProperty.all<
                            RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.0),
                                side: BorderSide(color: Color(0xFF9842CF),
                                    width: 1.9
                                )
                            )
                        )
                    ),
                    onPressed: () {
                      Navigator.popAndPushNamed(context, '/home');
                    },
                    label: Text(
                      "Back ",
                      style: TextStyle(
                          fontSize: 13.sp,
                          color: Colors.white,
                          fontFamily: 'Mont',
                          fontWeight: FontWeight.w400
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

