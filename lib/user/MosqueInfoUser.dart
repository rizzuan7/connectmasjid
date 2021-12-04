import 'package:connectmasjid/user/MosqueDetailUser.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MosqueInfoUser extends StatefulWidget {
  static String id = '/MosqueInfoUser';
  @override
  _MosqueInfoUserState createState() => _MosqueInfoUserState();
}

class _MosqueInfoUserState extends State<MosqueInfoUser> {
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
        title: Text('Mosque Information'),
      ),
      body: Container(
          height: 200,
          child: ListView.builder(
              itemCount: mosquelist.length,
              itemBuilder: (context, index) {
           if (mosquelist[index]['Name'] != null && mosquelist[index]['Address'] != null) {
                return Card(
                  child: ListTile(
                    title: Text(mosquelist[index]['id'] +" "+mosquelist[index]['Name']),
                    subtitle: Text(mosquelist[index]['Address']),
                    trailing: Icon(Icons.list,),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => MosqueDetailUser(Mid : mosquelist[index]['id'])));
                    },
                  ),
                );
              }
              })
      ),

    );
  }

  Future getMosque() async {
    List _mosquelist = [];
    CollectionReference Mosquelist = Firestore.instance.collection("mosque");
    await Mosquelist.getDocuments().then((QuerySnapshot) {
      QuerySnapshot.documents.forEach((element) {
        _mosquelist.add(element.data);
      });
    });
    return _mosquelist;
  }

}