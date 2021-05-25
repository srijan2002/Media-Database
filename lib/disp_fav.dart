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
      body: Container(
        decoration: BoxDecoration(
          gradient:LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [Color(0xFF14161B).withOpacity(0.89), Color(0xFF14161B), Color(0xFF1A1A2E), Colors.black87]),
        ),
            
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
              child: ListView.builder(
                itemCount: a.length,
                itemBuilder: (context,index){
                     return Padding(
                       padding: const EdgeInsets.fromLTRB(40, 5, 40, 5),
                       child: Container(
                         decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(30.0),
                           border: Border.all(width: 2.5,color: Color(0xFF9842CF)),
                           color: Color(0xFFD458F2).withOpacity(0.20),
                         ),
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
                                   fontFamily: 'Mont',
                                   fontSize: 17.0,
                                   letterSpacing: 1.0,
                                   color: Colors.white,
                                   fontWeight: FontWeight.w400

                                 ),
                               ),

                           ),

                         ),
                       ),
                     );
                     },
              ),
            ),
          ),
    );
  }
}
