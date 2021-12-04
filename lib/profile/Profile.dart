import 'package:connectmasjid/profile/EditProfile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Profile extends StatefulWidget {
  static String id = '/Profile';

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final firestoreInstance = Firestore.instance;

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
    return WillPopScope(
      onWillPop: _onBackPressed,
          child: MaterialApp(
          home : Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple,
          title: Center(
            child: const Text('Profile'),
          ),
        ),
        body: ListView(
          children: <Widget>[
            Container(
              height: 250,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.red, Colors.purple.shade300],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  stops: [0.5, 0.9],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Colors.white70,
                        minRadius: 60.0,
                        child: CircleAvatar(
                          radius: 50.0,
                          backgroundImage: NetworkImage(
                              'https://images.app.goo.gl/pYnaar5EhkXPgE4y5'),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  FutureBuilder(
                    future: getUserName(),
                    builder: (_, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if ((snapshot.data) != null) {
                      return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            new Text(
                              (snapshot.data),
                              style: TextStyle(
                                fontSize: 35,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            )
                          ]);
                          } else{
                          return Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                new Text("",
                                  style: TextStyle(
                                      fontSize: 18.0, color: Colors.black),
                                )
                              ]);}
                    },
                  ),
                  FutureBuilder(
                    future: getSurauName(),
                    builder: (_, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if ((snapshot.data) != null) {
                      return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            new Text(
                              (snapshot.data),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                              ),
                            )
                          ]);} else {
                          return Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                new Text("",
                                  style: TextStyle(
                                      fontSize: 18.0, color: Colors.black),
                                )
                              ]);}
                    },
                  ),
                ],
              ),
            ),
            Container(
              child: Column(
                children: <Widget>[
                  //Email
                  ListTile(
                    title: Text(
                      'Email',
                      style: TextStyle(
                        color: Colors.purple,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: FutureBuilder(
                      future: getUserEmail(),
                      builder: (_, AsyncSnapshot snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }
                        if ((snapshot.data) != null) {
                          return Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                new Text(
                                  (snapshot.data),
                                  style: TextStyle(
                                      fontSize: 18.0, color: Colors.black),
                                )
                              ]);
                        } else {
                          return Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                new Text("No data",
                                  style: TextStyle(
                                      fontSize: 18.0, color: Colors.black),
                                )
                              ]);
                        }
                      },
                    ),
                  ),
                  //Phone
                  ListTile(
                    title: Text(
                      'Phone number',
                      style: TextStyle(
                        color: Colors.purple,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: FutureBuilder(
                      future: getUserPhone(),
                      builder: (_, AsyncSnapshot snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }
                        if ((snapshot.data) != null) {
                        return Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              new Text(
                                (snapshot.data),
                                style: TextStyle(
                                    fontSize: 18.0, color: Colors.black),
                              )
                            ]);
                            }else {
                          return Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                new Text("No data",
                                  style: TextStyle(
                                      fontSize: 18.0, color: Colors.black),
                                )
                              ]);}
                      },
                    ),
                  ),
                  //Gender
                  ListTile(
                    title: Text(
                      'Gender',
                      style: TextStyle(
                        color: Colors.purple,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: FutureBuilder(
                      future: getUserGender(),
                      builder: (_, AsyncSnapshot snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }
                        if ((snapshot.data) != null) {
                        return Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              new Text(
                                (snapshot.data),
                                style: TextStyle(
                                    fontSize: 18.0, color: Colors.black),
                              )
                            ]);
                            }else {
                          return Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                new Text("No data",
                                  style: TextStyle(
                                      fontSize: 18.0, color: Colors.black),
                                )
                              ]);}
                      },
                    ),
                  ),
                  //State
                  ListTile(
                    title: Text(
                      'State',
                      style: TextStyle(
                        color: Colors.purple,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: FutureBuilder(
                      future: getUserState(),
                      builder: (_, AsyncSnapshot snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }
                        if ((snapshot.data) != null) {
                        return Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              new Text(
                                (snapshot.data),
                                style: TextStyle(
                                    fontSize: 18.0, color: Colors.black),
                              )
                            ]);
                            }else {
                          return Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                new Text("No data",
                                  style: TextStyle(
                                      fontSize: 18.0, color: Colors.black),
                                )
                              ]);}
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        //Button EditProfile
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.edit),
          onPressed: () => Navigator.pushNamed(context, EditProfile.id),
        ),
      ),
          ),
    );
  }

  //UserName
  Future<String> getUserName() async {
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    final String uid = user.uid.toString();
    final CollectionReference userdata = Firestore.instance.collection("user");
    final result = await userdata.document(uid).get();
    return result.data['Name'];
  }

  //SurauName
  Future<String> getSurauName() async {
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    final String uid = user.uid.toString();
    final CollectionReference userdata = Firestore.instance.collection("user");
    final result = await userdata.document(uid).get();
    return result.data['Surau Name'];
  }

  //UserEmail
  Future<String> getUserEmail() async {
    try {
      final FirebaseUser user = await FirebaseAuth.instance.currentUser();
      final String uid = user.uid.toString();
      final CollectionReference userdata =
          Firestore.instance.collection("user");
      final result = await userdata.document(uid).get();
      return result.data['Email'];
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //UserGender
  Future<String> getUserGender() async {
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    final String uid = user.uid.toString();
    final CollectionReference userdata = Firestore.instance.collection("user");
    final result = await userdata.document(uid).get();
    return result.data['Gender'];
  }

  //UserNumber
  Future<String> getUserPhone() async {
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    final String uid = user.uid.toString();
    final CollectionReference userdata = Firestore.instance.collection("user");
    final result = await userdata.document(uid).get();
    return result.data['Phone Number'];
  }

  //UserState
  Future<String> getUserState() async {
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    final String uid = user.uid.toString();
    final CollectionReference userdata = Firestore.instance.collection("user");
    final result = await userdata.document(uid).get();
    return result.data['State'];
  }
}
