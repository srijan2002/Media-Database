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
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.yellow, Colors.purpleAccent]
          )
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(30,36,50,0),
              child: Text(
                "IMDB RATING",
                style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontFamily: 'Playfair',
                    fontWeight: FontWeight.bold,
                    fontSize: 28.0,
                    color: Colors.deepPurpleAccent
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
                      color: Colors.black87,
                      fontSize: 21.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Playfair',
                      letterSpacing: 2.0
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(28,13,40,0),
              child: Text(
                "PLOT",
                style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontFamily: 'Playfair',
                    fontWeight: FontWeight.bold,
                    fontSize: 28.0,
                    color: Colors.deepPurpleAccent
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
                      color: Colors.black87,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Playfair',
                      letterSpacing: 2.0
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30,5,50,0),
              child: Text(
                "YEAR",
                style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontFamily: 'PLayfair',
                    fontWeight: FontWeight.bold,
                    fontSize: 28.0,
                    color: Colors.deepPurpleAccent
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
                      color: Colors.black87,
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
                    fontStyle: FontStyle.italic,
                    fontFamily: 'PLayfair',
                    fontWeight: FontWeight.bold,
                    fontSize: 26.0,
                    color: Colors.deepPurpleAccent
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
                      color: Colors.black87,
                      fontSize: 16.5,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'PLayfair',
                    letterSpacing: 0.4
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30,10,50,0),
              child: Text(
                "GENRE",
                style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontFamily: 'PLayfair',
                    fontWeight: FontWeight.bold,
                    fontSize: 27.0,
                    color: Colors.deepPurpleAccent
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
                      color: Colors.black87,
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
                FlatButton.icon(
                  onPressed: ()  {
                    Navigator.pop(context,'/display');
                  },
                  color: Colors.blue.shade400,
                  icon: Icon(
                      Icons.arrow_back
                  ),
                  label: Text(
                    "BACK",
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'PLayfair',
                        fontStyle: FontStyle.italic,
                        letterSpacing: 1.3,
                        color: Colors.yellowAccent
                    ),
                  ),
                ),
                SizedBox(
                  width: 16.0,
                ),
                FlatButton.icon(
                  onPressed: () {
                    Favorites ob = Favorites(data['Goog'],T);
                    ob.Add();
                  },
                  color: Colors.deepPurpleAccent[400],
                  icon: Icon(
                      Icons.add
                  ),
                  label: Text(
                    "ADD TO FAVORITES",
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'PLayfair',
                        fontStyle: FontStyle.italic,
                        letterSpacing: 1.3,
                        color: Colors.cyanAccent
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

