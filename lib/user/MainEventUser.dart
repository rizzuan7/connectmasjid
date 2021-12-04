import 'package:connectmasjid/user/OtherMosqueEventUser.dart';
import 'package:connectmasjid/user/ViewEventUser.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MainEventUser extends StatefulWidget {
  static String id = '/MainEventUser';

  @override
  _MainEventUserState createState() => _MainEventUserState();
}

class _MainEventUserState extends State<MainEventUser> {
  List mosquedata = [];
  String mosqueId;

  @override
  void initState() {
    super.initState();
    fetchMosqueData();
    fetchMosqueId();
  }

  fetchMosqueData() async {
    dynamic resultant = await getMosque();
    if(resultant == null){
      print("Null");
    } else {
      setState(() {
        mosquedata = resultant;
      }); } }

  fetchMosqueId() async {
    dynamic resultant2 = await getMosqueId();
    if(resultant2 == null){
      print("Null");
    } else {
      setState(() {
        mosqueId = resultant2;
      }); } }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Event Main Page'),
      ),
      body: Container(
          height: 200,
          child: ListView.builder(
              itemCount: mosquedata.length,
              itemBuilder: (context, index) {
                if(mosquedata[index]['Name'] != null && mosquedata[index]['id'] == mosqueId ) {
                  return Card(
                    child: ListTile(
                      title: Text(mosquedata[index]['Name']),
                      subtitle: Text(mosquedata[index]['Address']),
                      trailing: Icon(Icons.list,),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => ViewEventUser(mosqueId : mosqueId)));
                      },
                    ),
                  ); }
              })
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.list),
        onPressed: () => Navigator.pushNamed(context, OtherMosqueEventUser.id),
      ),
    );


  }

  Future getMosque() async {
    List _mosque = [];
    CollectionReference Eventlist = Firestore.instance.
    collection("mosque");
    await Eventlist.getDocuments().then((QuerySnapshot) {
      QuerySnapshot.documents.forEach((element) {
        _mosque.add(element.data);
      });
    });
    return _mosque;
  }

  Future<String> getMosqueId() async {
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    final String uid = user.uid.toString();
    final CollectionReference userdata = Firestore.instance.collection("user");
    final result = await userdata.document(uid).get();
    return result.data['MosqueId'];
  }
}