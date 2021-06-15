import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:collection';
import 'dart:convert';
import 'dart:ui';
import 'dart:core';
import 'package:flutter/material.dart';

class Favorites
{
  List a;
  String Goog;String T; String U;
  Favorites(String X,String Y,String Z){
    Goog=X;
    T=Y;
    U=Z;
}
    void Add() async
    {
      DocumentReference ref= Firestore.instance.collection('users').document(Goog);
      DocumentSnapshot doc =await ref.get();
      List tags =doc.data['Titles'];
      List tag = doc.data['Links'];
      if(T!=""){
        ref.updateData({
          'Titles': FieldValue.arrayUnion([T]),
          'Links': FieldValue.arrayUnion([U])
        } );}
    }
}