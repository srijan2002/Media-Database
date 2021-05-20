import 'package:flutter/material.dart';
import 'favorites.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
 String G; List a=[""];

class Disp_Fav extends StatefulWidget {
  @override
  _Disp_FavState createState() => _Disp_FavState();
}

class _Disp_FavState extends State<Disp_Fav> {
  Map data ={};

  void Get() async
  {
    DocumentReference ref= Firestore.instance.collection('users').document(G);
    DocumentSnapshot doc =await ref.get();
      setState(() {
        a=doc['Titles'];
      });
      if(a==null)
        setState(() {
          a=["No favorites Yet !"];
        });
  }
  void Del(String X) async
  {
    DocumentReference ref= Firestore.instance.collection('users').document(G);
    DocumentSnapshot doc =await ref.get();
   ref.updateData({
      'Titles': FieldValue.arrayRemove([X])
    });
    setState(() {
      a=doc['Titles'];
    });
    if(a==null)
      setState(() {
        a=["No favorites Yet !"];
      });
  }

  @override
  void initState(){
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context).settings.arguments;
    setState(() {
      G=data['Goog'];
    });
    Get();

    return Scaffold(
      backgroundColor: Colors.lightBlue[400],
      appBar: AppBar(
        backgroundColor:Colors.red,
        title: Text(
            "FAVORITES",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'Playfair',
            color: Colors.deepPurpleAccent,
            fontSize: 26.0,
            letterSpacing: 2.0
          ),
        ),
        centerTitle: true,
      ),
      body:
          ListView.builder(
            itemCount: a.length,
            itemBuilder: (context,index){
                 return Card(
                   color: Colors.lightBlue[100],
                   child: ListTile(
                    onTap: (){
                      showDialog(context: context, builder:(context)
                      {
                        return AlertDialog(
                          backgroundColor: Colors.deepOrange[100],
                          title: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                      "DELETE",
                                    style: TextStyle(
                                      fontFamily: 'Playfair',
                                    ),
                                  ),
                                  FlatButton.icon(
                                    onPressed: () {
                                      Del(a[index]);
                                    },
                                    label: Text(""),
                                    icon: Icon(Icons.delete),
                                  )
                                ],
                              ),
                              CloseButton(
                                onPressed: (){
                                  Navigator.pop(context);
                                },
                                color: Colors.blueAccent,
                              )
                            ],
                          ),
                        );
                      });
                    },
                     title: Center(
                       child: Text(
                           a[index],
                         style: TextStyle(
                           fontFamily: 'Playfair',
                           fontSize: 18.0,
                           letterSpacing: 1.5,
                           fontStyle: FontStyle.italic
                         ),
                       ),
                     ),
                   ),
                 );
                 },
          ),
    );
  }
}
