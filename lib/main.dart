import 'dart:collection';
import 'dart:convert';
import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'dart:core';
import 'package:flutter/material.dart';
import 'loading.dart';
import 'display.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'disp_fav.dart';
import 'error.dart';
import 'package:sizer/sizer.dart';
import 'login.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'models/data.dart';
import 'models/sign_inState.dart';
import 'models/check_fav.dart';
String T;
GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email',]); bool isLoggedIn;


  main() async  {


   await dotenv.load(fileName: ".env");
  runApp(MaterialApp(

     initialRoute: (log.sign!="")?'/home':'/login',

    routes: {
      '/':(context)=>Home(),
      '/home':(context)=>Home(),
      '/loading':(context)=>Loading(),
      '/display':(context)=>Display(),
      '/favorites':(context)=>Disp_Fav(),
      '/error':(context)=>Error(),
      '/login':(context)=>Login(),
    },

    
  ));
}
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String sign="Login/Logout";


  Map d={}; int flag=0;

  initLogin()  {
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) async {
      if (account != null) {
           log=Log(_googleSignIn.currentUser.id,_googleSignIn.currentUser.photoUrl,_googleSignIn.currentUser.displayName);
        isLoggedIn=true;
      } else {
        log=Log("","","");
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
        log=Log(_googleSignIn.currentUser.id,_googleSignIn.currentUser.photoUrl,_googleSignIn.currentUser.displayName);
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
      log=Log("","","");
      isLoggedIn=false;
    });
  }

  var n="";
  final TextEditingController t1= new TextEditingController(text: "");

  void getData() async{
   

       Navigator.pushNamed(context,'/loading');
    String url=dotenv.env['MOVIE_API']+n+dotenv.env['API_KEY'];
    Response response= await get(url);

    Map data= jsonDecode(response.body);
    current = Data.fromJson(data);
       Check che = Check(); await che.check(current.Title);
      if(data['Response']=="True")
        Navigator.pushReplacementNamed(context,'/display',);
        else
        Navigator.pushReplacementNamed(context, '/error');
  }

  GlobalKey<ScaffoldState> _scaffold = GlobalKey<ScaffoldState>();
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
      drawer: Drawer(
        child: Container(
          color: Colors.grey.shade900,
          child: ListView(

            children: [
              DrawerHeader(
               child: Padding(
                 padding: const EdgeInsets.all(30.0),
                 child: Container(

                   decoration: BoxDecoration(
                     shape: BoxShape.circle,
                     image: DecorationImage(
                         image: NetworkImage('${log.ph}'),
                         fit: BoxFit.fill
                     ),
                   ),
                 ),
                 
               ),
              ),
               Container(
                 color: Colors.black54,
                 child: ListTile(
                   onTap: ()async{
                     await _googleSignIn.signOut();
                     setState(() {
                       log=Log("","","");
                       print(log.ph);
                       isLoggedIn=false;
                       sign="Login";
                     });
                     Navigator.pushReplacementNamed(context, '/login');
                   },
                   trailing: Icon(Icons.logout,color: Colors.white70,),
                   title: Text(
                     "Logout",
                     style: TextStyle(
                       fontWeight: FontWeight.w800,
                       fontSize: 13.sp,
                       fontFamily: 'Mont',
                       color: Colors.white70
                     ),
                   ),
                 ),
               ),
              SizedBox(height: 2,),
              Container(
                color: Colors.black54,
                child: ListTile(
                  onTap: (){
                    SystemNavigator.pop();
                  },
                  trailing: Icon(Icons.close,color: Colors.white70,),
                  title: Text(
                    "Exit",
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 13.sp,
                        fontFamily: 'Mont',
                        color: Colors.white70
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      key: _scaffold,
      backgroundColor: Colors.black,

      body: Container(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
          child: ListView(
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 40.0,
                    ),
                    Container(

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: (){
                              _scaffold.currentState.openDrawer();
                            },
                            icon: Icon(Icons.menu,color: Colors.white,),
                          ),
                          IconButton(
                            onPressed: (){
                              Navigator.pushNamed(context, '/favorites',);
                            },
                            icon: Icon(Icons.favorite,color: Colors.white,),
                          ),
                        ],
                      ),


                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Container(
                     alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: Text(
                          "Explore",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'MontB',
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10.sp),
                          border: Border.all(width: 1.5,color: Colors.white70)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: TextField(
                          onSubmitted: (String b){
                            setState(() {
                              b=t1.text;
                              n=b;
                            });
                            getData();
                          },
                          cursorColor: Colors.white70,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(

                            border: InputBorder.none,
                              hintText: (t1.text == "")
                                  ? "Search..."
                                  : "",
                              hintStyle: Theme
                                  .of(context)
                                  .textTheme
                                  .caption
                                  .copyWith(
                                  color: Colors.white70,
                                  fontSize: 19.0,
                                  fontFamily: 'Mont',
                                  fontWeight: FontWeight.w700
                              )
                          ),
                          controller: t1,
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontFamily: 'Mont',
                            fontWeight: FontWeight.w800,
                            color: Colors.white70,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 60.0,),
                    Container(
                       alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Trending",
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Mont',
                            color: Colors.white,
                            letterSpacing: 0.2
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10.0,),
                    Container(
                      height: 33.h,

                      child: ListView(
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
                                    'assets/ys.jpg',fit: BoxFit.cover,),
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
                              n="Friends";
                              if(isLoggedIn==true)
                                getData();
                            },
                            child: Container(
                              width: 40.w,
                              child: ClipRRect(
                                child: Image.asset(
                                    'assets/fr.jpg',fit: BoxFit.cover,),
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
                              n="Karnan";
                              if(isLoggedIn==true)
                                getData();
                            },
                            child: Container(
                              width: 40.w,
                              child: ClipRRect(
                                child: Image.asset(
                                    'assets/kar.jpg',fit: BoxFit.cover,),
                                borderRadius: BorderRadius.circular(24),
                              ),
                            ),
                          ),  SizedBox(width: 5.w,),
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
                                    'assets/mau.jpg',fit: BoxFit.cover,),
                                borderRadius: BorderRadius.circular(24),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height:30.0),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Popular",
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Mont',
                              color: Colors.white
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10.0,),
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
                                    'assets/got.jpg',fit: BoxFit.cover,),
                                borderRadius: BorderRadius.circular(24),
                              ),
                            ),
                          ),
                          SizedBox(width: 5.w,),
                          InkWell(
                            onTap: (){
                              n="La Casa De Papel";
                              if(isLoggedIn==true)
                                getData();
                            },
                            child: Container(
                              width: 40.w,
                              child: ClipRRect(
                                child: Image.asset(
                                    'assets/mon.jpg',fit: BoxFit.cover,),
                                borderRadius: BorderRadius.circular(24),
                              ),
                            ),
                          ),
                          SizedBox(width: 5.w,),InkWell(
                            onTap: (){
                              n="Queen's Gambit";
                              if(isLoggedIn==true)
                                getData();
                            },
                            child: Container(
                              width: 40.w,
                              child: ClipRRect(
                                child: Image.asset(
                                    'assets/que.jpg',fit: BoxFit.cover,),
                                borderRadius: BorderRadius.circular(24),
                              ),
                            ),
                          ),
                          SizedBox(width: 5.w,),
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
                                    'assets/pea.jpg',fit: BoxFit.cover,),
                                borderRadius: BorderRadius.circular(24),
                              ),
                            ),
                          ),
                          SizedBox(width: 5.w,),
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
                                    'assets/st.jpg',fit: BoxFit.cover,),
                                borderRadius: BorderRadius.circular(24),
                              ),
                            ),
                          ), SizedBox(width: 5.w,),
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
                                    'assets/ten.jpg',fit: BoxFit.cover,),
                                borderRadius: BorderRadius.circular(24),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 30.0,),
                    Container(
                       alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Top Rated",
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Mont',
                              color: Colors.white,
                            letterSpacing: 0.5
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10.0,),
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
                                    'assets/bre.jpg',fit: BoxFit.cover,),
                                borderRadius: BorderRadius.circular(24),
                              ),
                            ),
                          ),
                          SizedBox(width: 5.w,),
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
                                    'assets/shaw.jpg',fit: BoxFit.cover,),
                                borderRadius: BorderRadius.circular(24),
                              ),
                            ),
                          ), SizedBox(width: 5.w,),
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
                                    'assets/rick.jpg',fit: BoxFit.cover,),
                                borderRadius: BorderRadius.circular(24),
                              ),
                            ),
                          ), SizedBox(width: 5.w,),
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
                          ), SizedBox(width: 5.w,),
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
                                    'assets/che.jpg',fit: BoxFit.cover,),
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
