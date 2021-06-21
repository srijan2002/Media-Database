import 'dart:convert';
import 'dart:ui';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:media_db/main.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:media_db/favorites.dart';
import 'package:sizer/sizer.dart';
import 'models/data.dart';
import 'main.dart';
import 'package:readmore/readmore.dart';
import 'models/sign_inState.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'models/isFav.dart';
class Display extends StatefulWidget{
  @override
  _DisplayState createState() => _DisplayState();
}

class _DisplayState extends State<Display> {
  Map data = {};var n="";
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  @override
  void initState(){
    super.initState();
  }

  void getData() async{


    Navigator.pushNamed(context,'/loading');
    String url=dotenv.env['MOVIE_API']+n+dotenv.env['API_KEY'];
    Response response= await get(url);
    Map data= jsonDecode(response.body);
    current = Data.fromJson(data);
    if(data['Response']=="True")
      Navigator.pushReplacementNamed(context,'/display',);
    else
      Navigator.pushReplacementNamed(context, '/error');
  }
  @override
  Widget build(BuildContext context)  {

    String GEN;
    if(current.Genre.indexOf(',')!=-1)
      GEN=current.Genre.substring(0,current.Genre.indexOf(','));
    else
      GEN=current.Genre;

    return Sizer(
        builder: (context, orientation, deviceType) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(

          child: Container(
            child: ListView(
              children: [
                Stack(
                  children: [
                    Container(
                    child:Image.network(current.Poster,width: 100.w,fit: BoxFit.fill,height: 60.h,)),
                   Container(

                     margin: const EdgeInsets.fromLTRB(20, 30, 30, 0),
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         IconButton(
                           iconSize: 20.sp,
                             icon: Icon(Icons.arrow_back_outlined,color: Colors.white,size: 25.sp,),
                           onPressed: (){
                               Navigator.pop(context);
                           },
                         ),

                        new IconButton(
                           icon: Icon(Icons.favorite, color: (fav.isf)?Colors.red:Colors.white),
                           iconSize: 20.sp,
                           onPressed: (){
                             setState(() {
                               fav=Fav(true);
                             });


                             Favorites b = Favorites(log.sign, current.Title,current.Poster);
                             b.Add();
                           },
                         ),
                       ],
                     ),
                   )
                 ]
                ),
                  SizedBox(height: 20.0,),
                 Container(
                   alignment: Alignment.center,
                     child: Text(
                         "${current.Title}",
                       style: TextStyle(
                         fontSize: 18.sp,
                         fontFamily: 'MontB',
                         color: Color(0xFFEFEFEF)
                       ),
                     )
                 ),
                SizedBox(height: 20.0,),
                 Padding(
                   padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                     children: [
                       Text(
                         "${current.Runtime}",
                         style: TextStyle(
                           fontWeight: FontWeight.bold,
                           fontSize: 13.sp,
                           fontFamily: 'Mont',
                           color: Colors.white
                         ),
                       ),
                       Text(
                         "${GEN}",
                         style: TextStyle(
                             fontSize: 13.sp,
                             fontFamily: 'Mont',
                             color: Colors.white,
                             fontWeight: FontWeight.bold
                         ),
                       ),
                       Text(
                         "${current.Year}",
                         style: TextStyle(
                             fontWeight: FontWeight.bold,
                             fontSize: 13.sp,
                             fontFamily: 'Mont',
                             color: Colors.white
                         ),
                       ),

                     ],
                   ),
                 ),
                SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Container(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${current.imdbRating}",
                          style: TextStyle(
                              fontFamily: 'MontB',
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 13.sp,
                          ),
                        ),
                        Icon(
                          Icons.star,color: Colors.white,size: 13.sp,
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color(0xFFEFEFEF),
                        borderRadius: BorderRadius.circular(12.sp),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.play_arrow,size: 25.sp,),
                          Text(
                              "Watch Trailer",
                            style: TextStyle(

                              color: Colors.black,
                              fontFamily: 'MontB',
                              fontSize: 14.sp
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Movie Info",
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontFamily: 'MontB',
                        color: Colors.white
                      ),
                    ),
                  ),
                ),
                 SizedBox(height: 13,),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: ReadMoreText(
            '${current.Plot}',
            style: TextStyle(
                fontSize: 11.sp, fontWeight: FontWeight.bold,fontFamily: 'Mont',color: Colors.white,letterSpacing: 0.5
            ),
            trimLines: 2,
            colorClickableText: Colors.yellow,
            trimMode: TrimMode.Line,
            trimCollapsedText: 'READ MORE',
            trimExpandedText: 'READ LESS',
            moreStyle: TextStyle(fontSize: 10.sp,fontFamily: 'MontB',color: Colors.yellow),
            lessStyle: TextStyle(fontSize: 10.sp,fontFamily: 'MontB',color: Colors.yellow),
          ),
        ),
                SizedBox(height: 20.0,),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Cast",
                      style: TextStyle(
                          fontSize: 13.sp,
                          fontFamily: 'MontB',
                          color: Colors.white,
                        letterSpacing: 0.5
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15.0,),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      "${current.Actors}",
                      style: TextStyle(
                        fontFamily: 'Mont',
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 12.sp
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 50.0,),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "You might also like",
                      style: TextStyle(
                          fontSize: 13.sp,
                          fontFamily: 'MontB',
                          color: Colors.white,
                          letterSpacing: 0.5
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15,),
                Container(
                  height: 33.h,

                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      InkWell(
                        onTap: (){
                          n="The Big Bang Theory";
                          if(isLoggedIn==true)
                            getData();
                        },
                        child: Container(
                          width: 40.w,
                          child: ClipRRect(
                            child: Image.asset(
                              'assets/tbbt.jpg',fit: BoxFit.cover,),
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                      ),
                      SizedBox(width: 5.w,),
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
                              'assets/aot.jpg',fit: BoxFit.cover,),
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                      ),
                      SizedBox(width: 5.w,),
                      InkWell(
                        onTap: (){
                          n="Game Of Thrones";
                          if(isLoggedIn==true)
                            getData();
                        },
                        child: Container(
                          width: 40.w,
                          child: ClipRRect(
                            child: Image.asset(
                              'assets/got.jpg',fit: BoxFit.cover,),
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                      ),
                      SizedBox(width: 5.w,),
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
                              'assets/army.jpg',fit: BoxFit.cover,),
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                      ), SizedBox(width: 5.w,),
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
                              'assets/she.jpg',fit: BoxFit.cover,),
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                      ),  SizedBox(width: 5.w,),
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
                              'assets/inc.jpg',fit: BoxFit.cover,),
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30,)
              ],
            ),
          ),
      ),
    );
  }
  );
  }
}

