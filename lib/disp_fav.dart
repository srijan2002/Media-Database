import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';
import 'models/data.dart';
import 'dart:convert';
import 'models/sign_inState.dart';
import 'models/check_fav.dart';
 String G; List a=[""]; List b=[" "];

class Disp_Fav extends StatefulWidget {
  @override
  _Disp_FavState createState() => _Disp_FavState();
}

class _Disp_FavState extends State<Disp_Fav> {


  Map data ={};
  void getData(String n) async{


    Navigator.pushNamed(context,'/loading');
    String url=dotenv.env['MOVIE_API']+n+dotenv.env['API_KEY'];
    Response response= await get(url);
    Map data= jsonDecode(response.body);
    current = Data.fromJson(data);
    Check che = Check(); await che.check(current.Title);
      Navigator.pushReplacementNamed(context,'/display',  arguments: { 'url':url});

  }

  void Get() async
  {
    DocumentReference ref= Firestore.instance.collection('users').document(log.sign);
    DocumentSnapshot doc =await ref.get();
      setState(() {
        a=doc['Titles'];
        b=doc['Links'];
      });
      if(a=="")
        setState(() {
          a=["No Favorites Yet !"];
        });
  }
  void Del(String X) async
  {
    DocumentReference ref= Firestore.instance.collection('users').document(log.sign);
    DocumentSnapshot doc =await ref.get();
   ref.updateData({
      'Titles': FieldValue.arrayRemove([X]),
     'Links':FieldValue.arrayRemove([X])
    });
    setState(() {
      a=doc['Titles'];
      b=doc['Links'];
    });
    if(a==null)
      setState(() {
        a=["No Favorites Yet !"];
      });
  }

  @override
  void initState(){
    super.initState();
    ctrl.addListener(() {
      int next = ctrl.page.round();

      if(currentPage!=next){
        setState(() {
          currentPage=next;
        });
      }

    });
  }
  int currentPage =0;
  final PageController ctrl = PageController(viewportFraction: 0.70);
  @override
  Widget build(BuildContext context) {


     Get();

    return Sizer(
        builder: (context, orientation, deviceType) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(
          color: Colors.white,
          size: 50.0,

        ),
        title: Text(
          "Favorites",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            fontFamily: 'MontB'
          ),
        ),

      ),

      body:Container(
         color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0,0,0,0),
          child: Container(
            child: PageView.builder(
              controller: ctrl,
                scrollDirection: Axis.horizontal,
                       itemCount: a.length,
                      itemBuilder: (context, int ind) {
                       bool active = ind == currentPage;
                       final double top = active?30:70;
                       final double opacity=active?0.7:0;

                         return Padding(
                             padding: const EdgeInsets.fromLTRB(8,8,8,8),
                             child: InkWell(
                               onTap: (){
                                 getData(a[ind]);
                               },
                               onLongPress: (){
    showDialog(context: context, builder: (context) {
                          return AlertDialog(
                            backgroundColor: Colors.black54,
                            title: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceEvenly,
                                  children: [
                                    Text(
                                      "Delete",
                                      style: TextStyle(
                                        fontFamily: 'Mont',
                                        color: Colors.white70,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    FlatButton.icon(
                                      onPressed: () {
                                        Del(a[ind]);
                                        Del(b[ind]);
                                        Navigator.pop(context);
                                      },
                                      label: Text(""),
                                      icon: Icon(Icons.delete,color: Colors.white70,),
                                    )
                                  ],
                                ),
                                CloseButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  color: Colors.white70,
                                )
                              ],
                            ),
                          );
                        });
                               },
                               child: Container(
                                 width: 38.w,
                                 child: Column(
                                   mainAxisAlignment: MainAxisAlignment.center,
                                   children: [
                                     Padding(
                                       padding: const EdgeInsets.fromLTRB(0,0,0,0),
                                       child: AnimatedContainer(
                                         duration: Duration(milliseconds: 500),
                                           curve: Curves.easeOutQuint,
                                         decoration: BoxDecoration(
                                           boxShadow: [
                                             BoxShadow(
                                               color: Colors.white30.withOpacity(opacity),
                                               spreadRadius: 0.2,
                                               blurRadius: 25.sp,
                                               offset: Offset(0, 5), // changes position of shadow
                                             ),
                                           ],
                                         ),
                                         margin: EdgeInsets.only(top:top,bottom: 0,right: 20,left: 20),
                                         child: ClipRRect(
                                           child: Image.network('${b[ind]}',fit: BoxFit.cover,),
                                           borderRadius: BorderRadius.circular(25.sp),
                                         ),
                                       ),
                                     ),
                                     Padding(
                                       padding: const EdgeInsets.fromLTRB(0,10,0,0),
                                       child: Center(
                                         child: Text(
                                           "${a[ind]}",
                                           style: TextStyle(
                                             fontFamily: 'Mont',
                                             color: Colors.white,
                                             fontWeight: FontWeight.w600,
                                             fontSize: 11.sp,
                                             letterSpacing: 1.1
                                           ),
                                         ),
                                       ),
                                     )
                                   ],
                                 ),
                               ),
                             ),
                           );
                      }

            ),
          ),
        ),
      )
    );
  }
  );
  }
}
