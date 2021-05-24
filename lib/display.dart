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
  Widget build(BuildContext context) {
    data = ModalRoute.of(context).settings.arguments;
    String K =data['imdbRating'];
    String L = data['Plot'];
    String M= data['Year'];
    String N= data['Genre'];
    String A=data['Actors'];
     String T= data['Title'];

    return Scaffold(
      backgroundColor: Colors.purple[900],
      body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(30,36,50,0),
              child: Text(
                "IMDB RATING",
                style: TextStyle(
                    fontFamily: 'Playfair',
                    fontWeight: FontWeight.bold,
                    fontSize: 28.0,
                    color: Colors.red.shade400
                ),
              ),
            ),
            SizedBox(height: 4.5),
            Padding(
              padding: const EdgeInsets.fromLTRB(40,0,50,0),
              child: Center(
                child: Text(
                  "$K",
                  style: TextStyle(
                      color: Colors.cyan[100],
                      fontSize: 20.0,
                      fontFamily: 'Playfair',
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(28,13,40,0),
              child: Text(
                "PLOT",
                style: TextStyle(
                    fontFamily: 'Playfair',
                    fontWeight: FontWeight.bold,
                    fontSize: 28.0,
                    color: Colors.red.shade400
                ),
              ),
            ),
            SizedBox(height: 12.0),
            Padding(
              padding: const EdgeInsets.fromLTRB(23,0,9,0),
              child: Center(
                child: Text(
                  "$L",
                  style: TextStyle(
                      color: Colors.cyan[100],
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Playfair',
                      letterSpacing: 1.4
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30,5,50,0),
              child: Text(
                "YEAR",
                style: TextStyle(
                    fontFamily: 'PLayfair',
                    fontWeight: FontWeight.bold,
                    fontSize: 28.0,
                    color: Colors.red.shade400
                ),
              ),
            ),
            SizedBox(height: 4.0),
            Padding(
              padding: const EdgeInsets.fromLTRB(40,0,50,0),
              child: Center(
                child: Text(
                  "$M",
                  style: TextStyle(
                      color: Colors.cyan[100],
                      fontSize: 19.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'PLayfair',
                      letterSpacing: 2.0
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30,10,50,0),
              child: Text(
                "CAST",
                style: TextStyle(
                    fontFamily: 'PLayfair',
                    fontWeight: FontWeight.bold,
                    fontSize: 26.0,
                    color: Colors.red.shade400
                ),
              ),
            ),
            SizedBox(height: 6.5),
            Padding(
              padding: const EdgeInsets.fromLTRB(20,0,15,0),
              child: Center(
                child: Text(
                  "$A",
                  style: TextStyle(
                      color: Colors.cyan[100],
                      fontSize: 16.5,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'PLayfair',
                    letterSpacing: 0.9
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30,10,50,0),
              child: Text(
                "GENRE",
                style: TextStyle(
                    fontFamily: 'PLayfair',
                    fontWeight: FontWeight.bold,
                    fontSize: 27.0,
                    color: Colors.red.shade400
                ),
              ),
            ),
            SizedBox(height: 4.5),
            Padding(
              padding: const EdgeInsets.fromLTRB(25,0,25,0),
              child: Center(
                child: Text(
                  "$N",
                  style: TextStyle(
                      color: Colors.cyan[100],
                      fontSize: 17.5,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'PLayfair',
                      letterSpacing: 1.0
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 25.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton.icon(
                  onPressed: ()  {
                    Navigator.popAndPushNamed(context,'/home');
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              side: BorderSide(color:Colors.deepOrange)
                          )
                      )
                  ),
                  icon: Icon(
                      Icons.arrow_back,
                    color: Colors.red,
                  ),
                  label: Text(
                    "BACK",
                    style: TextStyle(
                        fontSize: 15.5,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'PLayfair',
                        letterSpacing: 1.3,
                        color: Colors.red
                    ),
                  ),
                ),
                SizedBox(
                  width: 16.0,
                ),
                TextButton.icon(
                  onPressed: () {
                    Favorites ob = Favorites(data['Goog'],T);
                    ob.Add();
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              side: BorderSide(color:Colors.deepOrange)
                          )
                      )
                  ),
                  icon: Icon(
                      Icons.add,
                    color: Colors.red,
                  ),
                  label: Text(
                    "ADD TO FAVORITES",
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'PLayfair',
                        letterSpacing: 1.3,
                        color: Colors.red
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
    );
  }
}

