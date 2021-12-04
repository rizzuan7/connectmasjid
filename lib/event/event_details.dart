import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectmasjid/event/edit_event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class EventDetails extends StatefulWidget {
  static String id = '/EventDetails';
  String eventId;
  EventDetails({this.eventId});

  @override
  _EventDetailsState createState() => _EventDetailsState(eventId);
}

class _EventDetailsState extends State<EventDetails> {
  final firestoreInstance = Firestore.instance;
  String eventId;
  _EventDetailsState(this.eventId);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple,
          title: Center(
            child: const Text('Event Details'),
          ),
        ),
        body: ListView(
          children: <Widget>[
            Container(
              child: Column( children: <Widget>[
               
                //Event Title
                ListTile(
                  title: Text(
                    'Event Title',
                    style: TextStyle(
                      color: Colors.purple,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: FutureBuilder(
                    future: getTitle(),
                    builder: (_, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }
                      return //Text(snapshot.data);
                        Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[new Text((snapshot.data),
                              style:
                              TextStyle(fontSize: 18.0, color: Colors.black),
                            )
                            ]
                        );
                    },),
                ),

                //Event Descp
                ListTile(
                  title: Text(
                    'Event Description',
                    style: TextStyle(
                      color: Colors.purple,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  subtitle: FutureBuilder(
                    future: getDesc(),
                    builder: (_, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }
                      return //Text(snapshot.data);
                        Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[new Text((snapshot.data),
                              style:
                              TextStyle(fontSize: 18.0, color: Colors.black),
                            )
                            ]
                        );
                    },),
                ),

                //Event Date
                ListTile(
                  title: Text(
                    'Event Date',
                    style: TextStyle(
                      color: Colors.purple,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  subtitle: FutureBuilder(
                    future: getDate(),
                    builder: (_, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }
                      return //Text(snapshot.data);
                        Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[new Text((snapshot.data),
                              style:
                              TextStyle(fontSize: 18.0, color: Colors.black),
                            )
                            ]
                        );
                    },),
                ),

                //Event Link
                ListTile(
                  title: Text(
                    'Google Form Link ',
                    style: TextStyle(
                      color: Colors.purple,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  subtitle: FutureBuilder(
                    future: getFeedback(),
                    builder: (_, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }
                      return Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[new Text((snapshot.data),
                              style:
                              TextStyle(fontSize: 18.0, color: Colors.black),
                            )
                            ]
                        );
                    },),
                ),
                
                              ],
                              ),
                
                            ),
                          ],
                        ),

                        
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.edit,),
        onPressed:  () { 
          Navigator.push(context, MaterialPageRoute(builder: (_) => EditEventPage(eventId : eventId)));
                      },
      ),
                      ),
                    );
                  }
                
                  //Title
                  Future<String> getTitle() async {
                    final CollectionReference mosquedata = Firestore.instance.collection("events");
                    final result2 = await mosquedata.document(eventId).get();
                    return result2.data['Title'];
                  }
                
                  //Descp
                  Future<String> getDesc() async {
                    final CollectionReference mosquedata = Firestore.instance.collection("events");
                    final result2 = await mosquedata.document(eventId).get();
                    return result2.data['Description'];
                  }
                
                  //Date
                  Future<String> getDate() async {
                    final CollectionReference mosquedata = Firestore.instance.collection("events");
                    final result2 = await mosquedata.document(eventId).get();
                    var Eventdate = result2['Date'];
                    DateTime x = DateTime.fromMicrosecondsSinceEpoch(Eventdate.microsecondsSinceEpoch);
                    var formattedDate = new DateFormat('d MMMM y, EEEE').format(x);
                    return formattedDate;
                  }
                
                Future<String> getFeedback() async {
                    final CollectionReference mosquedata = Firestore.instance.collection("events");
                    final result2 = await mosquedata.document(eventId).get();
                    String url = result2.data['Feedback'].toString();
                    return url;
                  }

                }