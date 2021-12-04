import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:connectmasjid/Mosque/MosqueDetail.dart';
import 'package:connectmasjid/Mosque/AddMosque.dart';


class MosqueInfo extends StatefulWidget {
  static String id = '/MosqueInfo';
  @override
  _MosqueInfoState createState() => _MosqueInfoState();
}

class _MosqueInfoState extends State<MosqueInfo> {
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
          title: Text('Mosque Information'),
        ),
        body: Container(
            height: 200,
            child: ListView.builder(
                itemCount: mosquedata.length,
                itemBuilder: (context, index) {
                 if(mosquedata[index]['Name'] != null && mosquedata[index]['id'] == mosqueId ) {
                   return Card(
        child: ListTile(
          title: Text(
              mosquedata[index]['id'] + " " + mosquedata[index]['Name']),
              subtitle: Text(mosquedata[index]['Address']),
              trailing: Icon(Icons.list,),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => MosqueDetail()));
          },
        ),
      ); }
                })
        ),

        floatingActionButton: FloatingActionButton(
    child: Icon(Icons.add),
    onPressed: () => Navigator.pushNamed(context, AddMosque.id),
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