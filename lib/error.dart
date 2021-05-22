import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui';
import 'dart:core';

class Error extends StatefulWidget {
  @override
  _ErrorState createState() => _ErrorState();
}
class _ErrorState extends State<Error> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.cyan[200], Colors.pink[300]]
            )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0,100,0,20),
              child: Center(
                child: Text(
                  "ERROR IN RESULT !",
                  style:TextStyle(
                    fontSize: 26.0,
                    fontFamily: 'Playfair',
                    color: Colors.blue[900],
                    fontWeight: FontWeight.bold
                  )
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0,20,0,60),
              child: Center(
                child: Text(
                    "INCORRECT SPELLING",
                    style:TextStyle(
                        fontSize: 17.0,
                        fontFamily: 'Playfair',
                      letterSpacing: 1.55,
                      color: Colors.indigoAccent[700],
                        fontWeight: FontWeight.bold
                    )
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(40,80,40,20),
             child: FlatButton.icon(
               icon: Icon(Icons.arrow_back),
               color: Colors.indigo,
               onPressed: (){
                 Navigator.popAndPushNamed(context, '/home');
               },
               label: Text(
                 "BACK",
                 style: TextStyle(
                   fontSize: 20.0,
                   fontStyle: FontStyle.italic,
                   color:Colors.cyanAccent
                 ),
               ),
             ),
            ),
          ],
        ),
      ),
    );
  }
}

