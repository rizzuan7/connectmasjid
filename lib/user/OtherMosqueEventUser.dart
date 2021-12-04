import 'package:connectmasjid/user/MosqueDetailUser.dart';
import 'package:connectmasjid/user/ViewEventUser.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart';
import 'package:connectmasjid/Mosque/MosqueDetail.dart';

class OtherMosqueEventUser extends StatefulWidget {
  static String id = '/OtherMosqueEventUser';
  @override
  _OtherMosqueEventUserState createState() => _OtherMosqueEventUserState();
}

class _OtherMosqueEventUserState extends State<OtherMosqueEventUser> {
  List mosquelist = [];

  @override
  void initState() {
    super.initState();
    fetchEventList();
  }

  fetchEventList() async {
    dynamic resultant = await getMosque();
    if(resultant == null){
      print("Null");
    } else {
      setState(() {
        mosquelist = resultant;
      }); } }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('List of Mosque'),
      ),
      body: Container(
          height: 200,
          child: ListView.builder(
              itemCount: mosquelist.length,
              itemBuilder: (context, index) {
            if (mosquelist[index]['Name'] != null && mosquelist[index]['Address'] != null) {
                return Card(
                  child: ListTile(
                    title: Text(mosquelist[index]['Name']),
                    subtitle: Text(mosquelist[index]['Address']),
                    trailing: Icon(Icons.list,),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => ViewEventUser(mosqueId : mosquelist[index]['id'])));
                    },
                  ),
                );
              }
  }
              )
      ),

    );
  }

  Future getMosque() async {
    List _mosquelist = [];
    CollectionReference Mosquelist = Firestore.instance.
    collection("mosque");
    await Mosquelist.getDocuments().then((QuerySnapshot) {
      QuerySnapshot.documents.forEach((element) {
        _mosquelist.add(element.data);
      });
    });
    return _mosquelist;
  }

}