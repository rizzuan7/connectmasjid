import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MemberDetails extends StatefulWidget {
  static String id = '/MemberDetails';
  String UserId;
  MemberDetails({this.UserId});

  @override
  _MemberDetailsState createState() => _MemberDetailsState(UserId);
}

class _MemberDetailsState extends State<MemberDetails> {
  final firestoreInstance = Firestore.instance;
  String UserId;
  _MemberDetailsState(this.UserId);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple,
          title: Center(
            child: const Text('Member Details'),
          ),
        ),
        body: ListView(
          children: <Widget>[
            Container(
              child: Column( children: <Widget>[
               
                //Name
                ListTile(
                  title: Text(
                    'Member Name',
                    style: TextStyle(
                      color: Colors.purple,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: FutureBuilder(
                    future: getName(),
                    builder: (_, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
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
                    },),
                ),

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
                    future: getEmail(),
                    builder: (_, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
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
                    },),
                ),

                //Number
                ListTile(
                  title: Text(
                    'Phone Number',
                    style: TextStyle(
                      color: Colors.purple,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  subtitle: FutureBuilder(
                    future: getPhoneNumber(),
                    builder: (_, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
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
                    },),
                ),

                //Gender
                ListTile(
                  title: Text(
                    'Gender ',
                    style: TextStyle(
                      color: Colors.purple,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),),
                  
                  subtitle: FutureBuilder(
                    future: getGender(),
                    builder: (_, AsyncSnapshot snapshot) {
               if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator()); }
                        
               if ((snapshot.data) != null) {
                        return Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              new Text((snapshot.data),
                                style: TextStyle(fontSize: 18.0, color: Colors.black), )]);
                            } else {
                          return Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                new Text("No data",
                                  style: TextStyle(
                                      fontSize: 18.0, color: Colors.black),
                                )
                              ]);}
                    },),
                ),

              //State  
              ListTile(
                  title: Text(
                    'State ',
                    style: TextStyle(
                      color: Colors.purple,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  subtitle: FutureBuilder(
                    future: getState(),
                    builder: (_, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
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
                    },),
                ),
                

                              ],
                              ),
                
                            ),
                          ],
                        ),

                      
                      ),
                    );
                  }
                
                  //Name
                  Future<String> getName() async {
                    final CollectionReference mosquedata = Firestore.instance.collection("user");
                    final result2 = await mosquedata.document(UserId).get();
                    return result2.data['Name'];
                  }
                
                  //Email
                  Future<String> getEmail() async {
                    final CollectionReference mosquedata = Firestore.instance.collection("user");
                    final result2 = await mosquedata.document(UserId).get();
                    return result2.data['Email'];
                  }
                
                  //Phone Number            
                Future<String> getPhoneNumber() async {
                    final CollectionReference mosquedata = Firestore.instance.collection("user");
                    final result2 = await mosquedata.document(UserId).get();
                    return result2.data['Phone Number'];
                  }

                  //Gender      
                Future<String> getGender() async {
                    final CollectionReference mosquedata = Firestore.instance.collection("user");
                    final result2 = await mosquedata.document(UserId).get();
                    return result2.data['Gender'];
                  }

                   //State               
                Future<String> getState() async {
                    final CollectionReference mosquedata = Firestore.instance.collection("user");
                    final result2 = await mosquedata.document(UserId).get();
                    return result2.data['State'];
                  }

                }