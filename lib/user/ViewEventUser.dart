import 'package:connectmasjid/user/EventDetailUser.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';


class ViewEventUser extends StatefulWidget {
  static String id = '/ViewEventUser';
  String mosqueId;
  ViewEventUser({this.mosqueId});
  @override
  _ViewEventUserState createState() => _ViewEventUserState(mosqueId);
}

class _ViewEventUserState extends State<ViewEventUser> {
  List eventlist = [];
  String mosqueId;
  _ViewEventUserState(this.mosqueId);

  @override
  void initState() {
    super.initState();
    fetchEventList();
  }

  fetchEventList() async {
    dynamic resultant = await getevents();
    if(resultant == null){
      print("Null");
    } else {
      setState(() {
        eventlist = resultant;
      }); } }


  @override
  Widget build(BuildContext context){
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
                if (eventlist[index]['id'] != null && eventlist[index]['MosqueId'] == mosqueId && eventlist[index]['Description'] != null) {
                  return Card(
                    child: ListTile(
                      title: Text(eventlist[index]['Title']),
                      subtitle: Text(formattedDate),
                      trailing: Icon(Icons.list,),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => EventDetailUser(eventId : eventlist[index]['id'])));
                      },
                    ),
                  );
                } 
              }
          )
      ),

    );
  }

  Future getevents() async {
    List _eventlist = [];
    CollectionReference Eventlist = Firestore.instance.
    collection("events");
    await Eventlist.getDocuments().then((QuerySnapshot) {
      QuerySnapshot.documents.forEach((element) {
        _eventlist.add(element.data);
      });
    });
    return _eventlist;
  }


}