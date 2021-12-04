import 'package:connectmasjid/Mosque/MosqueInfo.dart';
import 'package:connectmasjid/event/EventMain.dart';
import 'package:connectmasjid/gmap.dart';
import 'package:connectmasjid/main_screens/LoginPage.dart';
import 'package:connectmasjid/member/Member.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class AdminHome extends StatefulWidget {
  static String id = '/AdminHome';

  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  //final FirebaseAuth _auth1 = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
    tabController = new TabController(length: 4, vsync: this);
  }
Future<bool> _onBackPressed(){
return showDialog(
context: context,
builder: (context)=>AlertDialog(
title: Text("Please logout to exit the app"),
actions: <Widget>[

FlatButton(
child: Text("Close"),
onPressed: ()=>Navigator.pop(context, false),
), 
], ) ); }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: _onBackPressed,
          child: MaterialApp(
          home : Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple,
          title: Center(
            child: const Text('Connecting Masjid - Admin'),
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () async {
                await _signOut();
                Navigator.pushNamed(context, LoginPage.id);
              },
            ),
          ],
        ),
        body: Stack(
          children: <Widget>[
            Container(
              height: size.height * 1,
              width: size.width * 1,
              decoration: BoxDecoration(
                image: DecorationImage(
                  //alignment: Alignment.center,
                  fit: BoxFit.fill,
                  image: AssetImage('assets/images/back.jpg'),
                ),
              ),
            ),

            SafeArea(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    Expanded(
                        child: GridView.count(
                            mainAxisSpacing: 5,
                            crossAxisSpacing: 5,
                            primary: false,
                            children: <Widget>[
                              //Events
                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                elevation: 4,
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    new Image.asset("assets/Event.png",width: 100.0),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        TextButton(
                                          child: Text('       '+'Event' + '\n' +'Management',
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.purple,
                                              )),
                                          onPressed: () {
                                            Navigator.pushNamed(
                                                context, EventMain.id);
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),

                              //Map
                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                elevation: 4,
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                  new Image.asset("assets/Map.png",width: 100.0),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        TextButton(
                                          child: Text('Location',
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.purple,
                                              )),
                                          onPressed: () {
                                            Navigator.pushNamed(
                                                context, GMap.id);
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),

                              //MosqueInfo
                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                elevation: 4,
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                  new Image.asset("assets/mosque.png",width: 100.0),

                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        TextButton(
                                          child: Text('   '+'Mosque' + '\n' +'Information',
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.purple,
                                              )),
                                          onPressed: () {
                                            Navigator.pushNamed(
                                                context, MosqueInfo.id);
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            
                              //Member
                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                elevation: 4,
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                  new Image.asset("assets/member.png",width: 100.0),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        TextButton(
                                          child: Text('Member',
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.purple,
                                              )),
                                          onPressed: () {
                                            Navigator.pushNamed(
                                                context, Member.id);
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),

                            ],
                            crossAxisCount: 2)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
          ),
    );
  }

  Future _signOut() async {
    try {
      print("Success");
      return FirebaseAuth.instance.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
}
