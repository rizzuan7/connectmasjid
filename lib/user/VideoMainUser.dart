import 'package:connectmasjid/user/YoutubeUser.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class VideoMainUser extends StatefulWidget {
  static String id = '/VideoMainUser';

  @override
  _VideoMainUserState createState() => _VideoMainUserState();
}

class _VideoMainUserState extends State<VideoMainUser> {
  List mosquelist = [];

  @override
  void initState() {
    super.initState();
    fetchVideoList();
  }

  fetchVideoList() async {
    dynamic resultant = await getMosque();
    if (resultant == null) {
      print("Null");
    } else {
      setState(() {
        mosquelist = resultant;
      });
    }
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
    return WillPopScope(
      onWillPop: _onBackPressed,
          child: MaterialApp(
          home : Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple,
          title: Center(
            child: const Text('List of Channel'),
          ),
        ),
        body: Container(
            height: 200,
            child: ListView.builder(
                itemCount: mosquelist.length,
                itemBuilder: (context, index) {
                  if (mosquelist[index]['Name'] != null &&
                      mosquelist[index]['Address'] != null) {
                    return Card(
                      child: ListTile(
                        title: Text(mosquelist[index]['Name']),
                        subtitle: Text(mosquelist[index]['Address']),
                        trailing: Icon(
                          Icons.list,
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => YoutubeUser(
                                      Chid: mosquelist[index]['id'])));
                        },
                      ),
                    );
                  }
                })),
      ),
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
