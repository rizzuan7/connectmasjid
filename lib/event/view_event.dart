import 'package:connectmasjid/event/event_details.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class EventDetailsPage extends StatefulWidget {
  static String id = '/EventDetailsPage';
  @override
  _EventDetailsPageState createState() => _EventDetailsPageState();
}

class _EventDetailsPageState extends State<EventDetailsPage> {
  List eventlist = [];
  String mosqueId;

  @override
  void initState() {
    super.initState();
    fetchEventList();
    fetchMosqueData();
  }

  fetchEventList() async {
    dynamic resultant = await getevents();
    if (resultant == null) {
      print("Null");
    } else {
      setState(() {
        eventlist = resultant;
      });
    }
  }

  fetchMosqueData() async {
    dynamic resultant2 = await getMosqueId();
    if (resultant2 == null) {
      print("Null");
    } else {
      setState(() {
        mosqueId = resultant2;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('List of Event'),
        ),
        body: Container(
            height: 400,
            child: ListView.builder(
                itemCount: eventlist.length,
                itemBuilder: (context, index) {
                  var Eventdate = eventlist[index]['Date'];
                  DateTime x = DateTime.fromMicrosecondsSinceEpoch(Eventdate.microsecondsSinceEpoch);
                  var formattedDate = new DateFormat('d MMMM y, EEEE').format(x);
                  if (eventlist[index]['id'] != null &&
                      eventlist[index]['MosqueId'] == mosqueId &&
                      eventlist[index]['Description'] != null) {
                    return Card(
                      child: ListTile(
                        title: Text(eventlist[index]['id'] +
                            " " +
                            eventlist[index]['Title']),
                        subtitle: Text(formattedDate),
                        trailing: Icon(
                          Icons.list,
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => EventDetails(
                                      eventId: eventlist[index]['id'])));
                        },
                        onLongPress: () {
                          delete(eventlist[index]['id']);
                        },
                      ),
                    );
                  }
                })));
  }

  void delete(String id2) {
    Firestore.instance.collection("events").document(id2).delete();
    print(id2);
  }

  Future getevents() async {
    List _eventlist = [];
    CollectionReference Eventlist = Firestore.instance.collection("events");
    await Eventlist.getDocuments().then((QuerySnapshot) {
      QuerySnapshot.documents.forEach((element) {
        _eventlist.add(element.data);
      });
    });
    return _eventlist;
  }

  Future<String> getMosqueId() async {
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    final String uid = user.uid.toString();
    final CollectionReference userdata = Firestore.instance.collection("user");
    final result = await userdata.document(uid).get();
    return result.data['MosqueId'];
  }
}
