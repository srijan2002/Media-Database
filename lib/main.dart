import 'dart:collection';
import 'dart:convert';
import 'dart:ui';
import 'package:http/http.dart';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:media_db/favorites.dart';
import 'loading.dart';
import 'display.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'disp_fav.dart';
import 'error.dart';
import 'package:sizer/sizer.dart';
import 'login.dart';
String T;
 void main() async  {
  runApp(MaterialApp(

    routes: {
      '/':(context)=>Home(),
      '/home':(context)=>Home(),
      '/loading':(context)=>Loading(),
      '/display':(context)=>Display(),
      '/favorites':(context)=>Disp_Fav(),
      '/error':(context)=>Error(),
      '/login':(context)=>Login()
    },
    // initialRoute: '/login',

  ));
}
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isLoggedIn;
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email',]);

  initLogin() {
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) async {
      if (account != null) {
        isLoggedIn=true;
      } else {
        isLoggedIn=false;
      }
    });
    _googleSignIn.signInSilently();
  }
  _login(String X) async
  {
    try {
      await _googleSignIn.signIn();
      Firestore ob = Firestore();

      setState(() {
        isLoggedIn=true;

      });
      ob.collection('users').document(_googleSignIn.currentUser.id).setData({
      },
      merge: true
      );
    }
    catch(err){
      print(err);
    }
  }

  _logout() async
  {
    await _googleSignIn.signOut();
    setState(() {
      isLoggedIn=false;
    });
  }

  var n="";
  final TextEditingController t1= new TextEditingController(text: "");

  void getData() async{

    Navigator.pushNamed(context,'/loading');
    Response response= await get("https://www.omdbapi.com/?t=$n&apikey=a018d195");
    Map data= jsonDecode(response.body);
      String X=data['imdbRating']; String Y=data['Plot'];
      String Z=data['Year'];String A=data['Genre'];
      T = data['Title'];
      String F=data['Actors'];
      if(data['Response']=="True")
       Navigator.popAndPushNamed(context,'/display', arguments: {'imdbRating': X, 'Plot':Y, 'Year':Z,'Genre':A,'Title':T,'Actors':F,'Goog':_googleSignIn.currentUser.id,'Pic':data['Poster']});
      else
        Navigator.pushReplacementNamed(context, '/error');
  }
  @override
  void initState(){
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    initLogin();
    return Sizer(
        builder: (context, orientation, deviceType) {
    return Scaffold(
      // backgroundColor: Colors.black45,

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
          padding: const EdgeInsets.fromLTRB(8, 40, 8, 0),
          child: ListView(
              children: [
                Column(
                  children: [
                    Container(
                      child: Container(
                        decoration: BoxDecoration(
                            color: Color(0xFFD458F2).withOpacity(0.15),
                            borderRadius: BorderRadius.circular(22.0),
                            border: Border.all(width: 2.1, color: Color(
                                0xFF9842CF))
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(15, 5, 15, 8),
                          child: Text(
                            "The Media Database",
                            style: TextStyle(
                                fontSize: 24,
                                fontFamily: 'Mont',
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                                letterSpacing: 1.2
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [

                        TextButton.icon(
                          onPressed: () {
                            if (isLoggedIn == true) {
                              setState(() {
                                n = t1.text;
                              });
                              getData();
                            }
                            else {
                              showDialog(context: context, builder: (context) {
                                return AlertDialog(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12.sp))),
                                  backgroundColor: Color(0xFF752BA9),
                                  title: Column(
                                    children: [
                                      Text(
                                        "Please Sign-In First !",
                                        style: TextStyle(
                                            fontSize: 14.sp,
                                            fontFamily: 'Mont',
                                            fontWeight: FontWeight.w500,
                                            letterSpacing: 1,
                                            color: Color(0xFFFFFFFF)
                                        ),
                                      ),
                                      CloseButton(
                                        color: Color(0xFFFFFFFF),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      )
                                    ],
                                  ),
                                );
                              }
                              );
                            }
                          },

                          icon: Icon(
                            Icons.search,
                            color: Color(0xFFA941BA),
                          ),
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Color(
                                  0xFFD458F2).withOpacity(0.1)),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16.0),
                                      side: BorderSide(color: Color(0xFF9842CF),
                                          width: 1.9)
                                  )
                              )
                          ),
                          label: Text(
                            "Search ",
                            style: TextStyle(
                                fontFamily: 'Mont',
                                fontWeight: FontWeight.w400,
                                letterSpacing: 1.2,
                                fontSize: 17.0,
                                color: Colors.white

                            ),
                          ),
                          // colors:Colors.purpleAccent
                        ),

                        TextButton.icon(
                          onPressed: () {
                            if (isLoggedIn == true) {
                              Navigator.pushNamed(context, '/favorites',
                                  arguments: {
                                    'Goog': _googleSignIn.currentUser.id,
                                    'Title': T
                                  });
                            }
                            else {
                              showDialog(context: context, builder: (context) {
                                return AlertDialog(
                                  backgroundColor: Color(0xFF752BA9),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12.sp))),
                                  title: Column(
                                    children: [
                                      Text(
                                        "Please Sign-In First !",
                                        style: TextStyle(
                                            fontSize: 14.sp,
                                            fontFamily: 'Mont',
                                            fontWeight: FontWeight.w500,
                                            letterSpacing: 1,
                                            color: Color(0xFFFFFFFF)
                                        ),
                                      ),
                                      CloseButton(
                                        color: Color(0xFFFFFFFF),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      )
                                    ],
                                  ),
                                );
                              }
                              );
                            }
                          },
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Color(
                                  0xFFD458F2).withOpacity(0.1)),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16.0),
                                      side: BorderSide(color: Color(0xFF9842CF),
                                          width: 1.9)
                                  )
                              )
                          ),
                          icon: Icon(
                            Icons.star,
                            color: Color(0xFFA941BA),

                          ),
                          label: Text(
                            "Favorites ",
                            style: TextStyle(
                                fontFamily: 'Mont',
                                fontWeight: FontWeight.w400,
                                letterSpacing: 1.2,
                                fontSize: 17.0,
                                color: Colors.white
                            ),
                          ),
                          // color:Colors.blue.shade400
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton.icon(
                          // color: Colors.white,
                          onPressed: (){
                            // if(isLoggedIn==true)
                            Navigator.popAndPushNamed(context,'/login');
                          },
                          icon: Icon(Icons.login_outlined,
                            color: Color(0xFFA941BA),),
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Color(0xFFD458F2).withOpacity(0.1)),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16.0),
                                    side: BorderSide(color: Color(0xFF9842CF),
                                    width: 1.9
                                    )
                                  )
                              )
                          ),
                          label: Text(
                              "Login ",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 17.0,
                                letterSpacing: 1.2,
                                fontFamily: 'Mont',
                                color: Colors.white
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 40.0,
                    ),

                    TextField(
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                          hintText: (t1.text == "")
                              ? "Enter Movie/Series Name"
                              : "",
                          hintStyle: Theme
                              .of(context)
                              .textTheme
                              .caption
                              .copyWith(
                              color: Colors.purpleAccent,
                              fontSize: 19.0,
                              fontFamily: 'Mont'
                          )
                      ),
                      controller: t1,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontFamily: 'Mont',
                        fontWeight: FontWeight.w400,
                        color: Colors.purpleAccent,
                        letterSpacing: 1.8,
                      ),
                    ),
                    SizedBox(height: 60.0,),
                    Container(
                      decoration: BoxDecoration(
                          color: Color(0xFFD458F2).withOpacity(0.15),
                          borderRadius: BorderRadius.circular(25.0),
                          border: Border.all(width: 2.1,color: Color(0xFF9842CF))
                      ),
                      margin: new EdgeInsets.fromLTRB(0, 0, 60.w, 0),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Trending",
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Mont',
                            color: Colors.white
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0,),
                    Container(
                      height: 33.h,

                      child: ListView(
                        // This next line does the trick.
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          InkWell(
                            onTap: (){
                              n="Young Sheldon";
                              if(isLoggedIn==true)
                              getData();
                            },
                            child: Container(
                              width: 40.w,
                              child: ClipRRect(
                                child: Image.asset(
                                    'assets/ys.jpg'),
                                borderRadius: BorderRadius.circular(24),
                              ),
                            ),
                          ),
                          SizedBox(width: 2.w,),
                          InkWell(
                            onTap: (){
                              n="Attack on Titan";
                              if(isLoggedIn==true)
                                getData();
                            },
                            child: Container(
                              width: 40.w,
                              child: ClipRRect(
                                child: Image.asset(
                                    'assets/aot.jpg'),
                                borderRadius: BorderRadius.circular(24),
                              ),
                            ),
                          ),
                          SizedBox(width: 2.w,),
                          InkWell(
                            onTap: (){
                              n="Friends";
                              if(isLoggedIn==true)
                                getData();
                            },
                            child: Container(
                              width: 40.w,
                              child: ClipRRect(
                                child: Image.asset(
                                    'assets/fr.jpg'),
                                borderRadius: BorderRadius.circular(24),
                              ),
                            ),
                          ),
                          SizedBox(width: 2.w,),
                          InkWell(
                            onTap: (){
                              n="Army of the Dead";
                              if(isLoggedIn==true)
                                getData();
                            },
                            child: Container(
                              width: 40.w,
                              child: ClipRRect(
                                child: Image.asset(
                                    'assets/army.jpg'),
                                borderRadius: BorderRadius.circular(24),
                              ),
                            ),
                          ), SizedBox(width: 2.w,),
                          InkWell(
                            onTap: (){
                              n="Karnan";
                              if(isLoggedIn==true)
                                getData();
                            },
                            child: Container(
                              width: 40.w,
                              child: ClipRRect(
                                child: Image.asset(
                                    'assets/kar.jpg'),
                                borderRadius: BorderRadius.circular(24),
                              ),
                            ),
                          ),  SizedBox(width: 2.w,),
                          InkWell(
                            onTap: (){
                              n="The Mauritanian";
                              if(isLoggedIn==true)
                                getData();
                            },
                            child: Container(
                              width: 40.w,
                              child: ClipRRect(
                                child: Image.asset(
                                    'assets/mau.jpg'),
                                borderRadius: BorderRadius.circular(24),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height:30.0),
                    Container(
                      decoration: BoxDecoration(
                          color: Color(0xFFD458F2).withOpacity(0.15),
                          borderRadius: BorderRadius.circular(25.0),
                          border: Border.all(width: 2.1,color: Color(0xFF9842CF))
                      ),
                      margin: new EdgeInsets.fromLTRB(0, 0, 60.w, 0),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Popular",
                          style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Mont',
                              color: Colors.white
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0,),
                    Container(
                      height: 33.h,

                      child: ListView(
                        // This next line does the trick.
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          InkWell(
                            onTap: (){
                              n="Game of thrones";
                              if(isLoggedIn==true)
                                getData();
                            },
                            child: Container(
                              width: 160.0,
                              child: ClipRRect(
                                child: Image.asset(
                                    'assets/got.jpg'),
                                borderRadius: BorderRadius.circular(24),
                              ),
                            ),
                          ),
                          SizedBox(width: 2.w,),
                          InkWell(
                            onTap: (){
                              n="Money Heist";
                              if(isLoggedIn==true)
                                getData();
                            },
                            child: Container(
                              width: 40.w,
                              child: ClipRRect(
                                child: Image.asset(
                                    'assets/mon.jpg'),
                                borderRadius: BorderRadius.circular(24),
                              ),
                            ),
                          ),
                          SizedBox(width: 2.w,),InkWell(
                            onTap: (){
                              n="Queen's Gambit";
                              if(isLoggedIn==true)
                                getData();
                            },
                            child: Container(
                              width: 40.w,
                              child: ClipRRect(
                                child: Image.asset(
                                    'assets/que.jpg'),
                                borderRadius: BorderRadius.circular(24),
                              ),
                            ),
                          ),
                          SizedBox(width: 2.w,),
                          InkWell(
                            onTap: (){
                              n="Peaky Blinders";
                              if(isLoggedIn==true)
                                getData();
                            },
                            child: Container(
                              width: 40.w,
                              child: ClipRRect(
                                child: Image.asset(
                                    'assets/pea.jpg'),
                                borderRadius: BorderRadius.circular(24),
                              ),
                            ),
                          ),
                          SizedBox(width: 2.w,),
                          InkWell(
                            onTap: (){
                              n="Stranger Things";
                              if(isLoggedIn==true)
                                getData();
                            },
                            child: Container(
                              width: 40.w,
                              child: ClipRRect(
                                child: Image.asset(
                                    'assets/st.jpg'),
                                borderRadius: BorderRadius.circular(24),
                              ),
                            ),
                          ), SizedBox(width: 2.w,),
                          InkWell(
                            onTap: (){
                              n="Tenet";
                              if(isLoggedIn==true)
                                getData();
                            },
                            child: Container(
                              width: 40.w,
                              child: ClipRRect(
                                child: Image.asset(
                                    'assets/ten.jpg'),
                                borderRadius: BorderRadius.circular(24),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 30.0,),
                    Container(
                      decoration: BoxDecoration(
                          color: Color(0xFFD458F2).withOpacity(0.15),
                          borderRadius: BorderRadius.circular(25.0),
                          border: Border.all(width: 2.1,color: Color(0xFF9842CF))
                      ),
                      margin: new EdgeInsets.fromLTRB(0, 0, 60.w, 0),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Top Rated",
                          style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Mont',
                              color: Colors.white
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0,),
                    Container(
                      height: 33.h,

                      child: ListView(
                        // This next line does the trick.
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          InkWell(
                            onTap: (){
                              n="Breaking Bad";
                              if(isLoggedIn==true)
                                getData();
                            },
                            child: Container(
                              width: 40.w,
                              child: ClipRRect(
                                child: Image.asset(
                                    'assets/bre.jpg'),
                                borderRadius: BorderRadius.circular(24),
                              ),
                            ),
                          ),
                          SizedBox(width: 2.w,),
                          InkWell(
                            onTap: (){
                              n="Shawshank Redemption";
                              if(isLoggedIn==true)
                                getData();
                            },
                            child: Container(
                              width: 40.w,
                              child: ClipRRect(
                                child: Image.asset(
                                    'assets/shaw.jpg'),
                                borderRadius: BorderRadius.circular(24),
                              ),
                            ),
                          ), SizedBox(width: 2.w,),
                          InkWell(
                            onTap: (){
                              n="Rick And Morty";
                              if(isLoggedIn==true)
                                getData();
                            },
                            child: Container(
                              width: 40.w,
                              child: ClipRRect(
                                child: Image.asset(
                                    'assets/rick.jpg'),
                                borderRadius: BorderRadius.circular(24),
                              ),
                            ),
                          ), SizedBox(width: 2.w,),
                          InkWell(
                            onTap: (){
                              n="Inception";
                              if(isLoggedIn==true)
                                getData();
                            },
                            child: Container(
                              width: 40.w,
                              child: ClipRRect(
                                child: Image.asset(
                                    'assets/inc.jpg'),
                                borderRadius: BorderRadius.circular(24),
                              ),
                            ),
                          ), SizedBox(width: 2.w,),
                          InkWell(
                            onTap: (){
                              n="Chernobyl";
                              if(isLoggedIn==true)
                                getData();
                            },
                            child: Container(
                              width: 40.w,
                              child: ClipRRect(
                                child: Image.asset(
                                    'assets/che.jpg'),
                                borderRadius: BorderRadius.circular(24),
                              ),
                            ),
                          ), SizedBox(width: 2.w,),
                          InkWell(
                            onTap: (){
                              n="Sherlock";
                              if(isLoggedIn==true)
                                getData();
                            },
                            child: Container(
                              width: 40.w,
                              child: ClipRRect(
                                child: Image.asset(
                                    'assets/she.jpg'),
                                borderRadius: BorderRadius.circular(24),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.0,)
                  ],
                ),

              ]
          ),
        ),
      ),
    );
  }
  );
  }
}
