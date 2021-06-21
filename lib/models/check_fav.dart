import 'package:media_db/models/sign_inState.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'isFav.dart';
class Check{
  List a;
  Future check(String T)async{
    DocumentReference ref= Firestore.instance.collection('users').document(log.sign);
    DocumentSnapshot doc =await ref.get();
    fav=Fav(false);
      a=doc['Titles'];
    if(a.contains(T)==true)
      fav=Fav(true);
    else
      fav=Fav(false);


  }
}