import 'dart:convert';
import 'dart:ui';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:media_db/main.dart';
import 'main.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:media_db/favorites.dart';
import 'package:sizer/sizer.dart';
import 'models/data.dart';
import 'main.dart';
class Display extends StatefulWidget{
  @override
  _DisplayState createState() => _DisplayState();
}

class _DisplayState extends State<Display> {
  Map data = {};
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context)  {
    data = ModalRoute.of(context).settings.arguments;
    String url = data['url'];

    return Sizer(
        builder: (context, orientation, deviceType) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF14161B).withOpacity(0.89),
                  Color(0xFF14161B),
                  Color(0xFF1A1A2E),
                  Colors.black87
                ])
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 30, 10, 30),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(width: 2.5, color: Color(0xFF7913B7)),
            ),
            child: ListView(
              children: [
                  Center(
                    child: Container(
                      height:MediaQuery.of(context).size.height*0.55,
                      width: MediaQuery.of(context).size.width*0.65,
                      // decoration: BoxDecoration(
                      //   borderRadius: BorderRadius.circular(30.0),
                      //   border: Border.all(width: 2.5, color: Color(0xFF9842CF)),
                      //   color: Color(0xFFD458F2).withOpacity(0.20),
                      // ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(44),
                        child: Image(
                          image: NetworkImage(current.Poster),
                          height:MediaQuery.of(context).size.height*0.55,
                          width: MediaQuery.of(context).size.width*0.65,
                        ),
                      ),
                    ),
                  ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(90, 36, 90, 0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color(0xFFD458F2).withOpacity(0.15),
                        borderRadius: BorderRadius.circular(25.0),
                        border: Border.all(width: 2.1, color: Color(0xFF9842CF))
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                        child: Text(
                          "IMDb Rating",
                          style: TextStyle(
                              fontFamily: 'Mont',
                              fontWeight: FontWeight.w400,
                              // fontSize: 22.0,
                              fontSize: 16.sp,
                              color: Colors.white
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 6.0),
                Padding(
                  padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                  child: Center(
                    child: Text(
                      "${current.imdbRating}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontFamily: 'Mont',
                        fontWeight: FontWeight.w400,
                        letterSpacing: 1.3,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10.0,),
                Padding(
                  padding: const EdgeInsets.fromLTRB(120, 22, 120, 0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color(0xFFD458F2).withOpacity(0.15),
                        borderRadius: BorderRadius.circular(25.0),
                        border: Border.all(width: 2.1, color: Color(0xFF9842CF))
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                        child: Text(
                          "Plot",
                          style: TextStyle(
                              fontFamily: 'Mont',
                              fontWeight: FontWeight.w400,
                              // fontSize: 22.0,
                              fontSize: 16.sp,
                              color: Colors.white
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 0, 9, 0),
                  child: Center(
                    child: Text(
                      "${current.Plot}",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Mont',
                          letterSpacing: 1.1
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(125, 19, 125, 0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color(0xFFD458F2).withOpacity(0.15),
                        borderRadius: BorderRadius.circular(25.0),
                        border: Border.all(width: 2.1, color: Color(0xFF9842CF))
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                        child: Text(
                          "Year",
                          style: TextStyle(
                              fontFamily: 'Mont',
                              fontWeight: FontWeight.w400,
                              // fontSize: 22.0,
                              fontSize: 16.sp,
                              color: Colors.white
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8.0),
                Padding(
                  padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                  child: Center(
                    child: Text(
                      "${current.Year}",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 19.0,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Mont',
                          letterSpacing: 1.4
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(130, 30, 130, 0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color(0xFFD458F2).withOpacity(0.15),
                        borderRadius: BorderRadius.circular(25.0),
                        border: Border.all(width: 2.1, color: Color(0xFF9842CF))
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                        child: Text(
                          "Cast",
                          style: TextStyle(
                              fontFamily: 'Mont',
                              fontWeight: FontWeight.w400,
                              // fontSize: 22.0,
                              fontSize: 16.sp,
                              color: Colors.white
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 5, 5, 0),
                  child: Center(
                    child: Text(
                      "${current.Actors}",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Mont',
                          letterSpacing: 0.7
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(130, 30, 130, 0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color(0xFFD458F2).withOpacity(0.15),
                        borderRadius: BorderRadius.circular(25.0),
                        border: Border.all(width: 2.1, color: Color(0xFF9842CF))
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                        child: Text(
                          "Genre",
                          style: TextStyle(
                              fontFamily: 'Mont',
                              fontWeight: FontWeight.w400,
                              // fontSize: 22.0,
                              fontSize: 16.sp,
                              color: Colors.white
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                  child: Center(
                    child: Text(
                      "${current.Genre}",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Mont',
                          letterSpacing: 1.0
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton.icon(
                      onPressed: () {
                        // Navigator.pop(context);
                        Navigator.pushReplacementNamed(context,'/home');
                      },
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Color(
                              0xFFD458F2).withOpacity(0.2)),
                          shape: MaterialStateProperty.all<
                              RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                  side: BorderSide(
                                      color: Color(0xFF6803B4), width: 2.5)
                              )
                          )
                      ),
                      icon: Icon(
                        Icons.arrow_back,
                        color: Color(0xFFA941BA),
                      ),
                      label: Text(
                        "Back ",
                        style: TextStyle(
                            // fontSize: 16.5,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Mont',
                            letterSpacing: 1.3,
                            color: Colors.white
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 19.0,
                    ),
                    TextButton.icon(
                      onPressed: () {
                        Favorites b = Favorites(data['Goog'], current.Title,current.Poster);
                        b.Add();
                      },
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Color(
                              0xFFD458F2).withOpacity(0.2)),
                          shape: MaterialStateProperty.all<
                              RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                  side: BorderSide(
                                      color: Color(0xFF6803B4), width: 2.5)
                              )
                          )
                      ),
                      icon: Icon(
                        Icons.add,
                        color: Color(0xFFA941BA),
                      ),
                      label: Text(
                        "Add To Favorites ",
                        style: TextStyle(
                            // fontSize: 16.5,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Mont',
                            letterSpacing: 1.3,
                            color: Colors.white
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30.0,),
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

