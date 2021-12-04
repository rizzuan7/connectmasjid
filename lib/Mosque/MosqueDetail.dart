import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectmasjid/Mosque/EditMosque.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MosqueDetail extends StatefulWidget {
  static String id = '/MosqueDetail';

  @override
  _MosqueDetailState createState() => _MosqueDetailState();
}

class _MosqueDetailState extends State<MosqueDetail> {
  final firestoreInstance = Firestore.instance;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MosqueDetail',
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple,
          title: Center(
            child: const Text('Mosque Details'),
          ),
        ),
        body: ListView(
          children: <Widget>[

            Container(
              child: Column( children: <Widget>[
                ListTile(
                  title: Text(
                    'Mosque Name',
                    style: TextStyle(
                      color: Colors.purple,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  subtitle: FutureBuilder(
                    future: getMosqueName(),
                    builder: (_ , AsyncSnapshot snapshot){
                      if(snapshot.connectionState == ConnectionState.waiting){
                        return Center( child: CircularProgressIndicator());}
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

                ListTile(
                  title: Text(
                    'Address',
                    style: TextStyle(
                      color: Colors.purple,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  subtitle: FutureBuilder(
                    future: getMosqueAddress(),
                    builder: (_ , AsyncSnapshot snapshot){
                      if(snapshot.connectionState == ConnectionState.waiting){
                        return Center( child: CircularProgressIndicator());}
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

                ListTile(
                  title: Text(
                    'Mosque Information',
                    style: TextStyle(
                      color: Colors.purple,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  subtitle: FutureBuilder(
                    future: getMosqueInfo(),
                    builder: (_ , AsyncSnapshot snapshot){
                      if(snapshot.connectionState == ConnectionState.waiting){
                        return Center( child: CircularProgressIndicator());}
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

                ListTile(
                  title: Text(
                    'Contact Number',
                    style: TextStyle(
                      color: Colors.purple,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  subtitle: FutureBuilder(
                    future: getMosquePhone(),
                    builder: (_ , AsyncSnapshot snapshot){
                      if(snapshot.connectionState == ConnectionState.waiting){
                        return Center( child: CircularProgressIndicator());}
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

                ListTile(
                  title: Text(
                    'Person in charge',
                    style: TextStyle(
                      color: Colors.purple,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  subtitle: FutureBuilder(
                    future: getMosquePIC(),
                    builder: (_ , AsyncSnapshot snapshot){
                      if(snapshot.connectionState == ConnectionState.waiting){
                        return Center( child: CircularProgressIndicator());}
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

            ListTile(
                  title: Text(
                    'Facebook Page',
                    style: TextStyle(
                      color: Colors.purple,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  subtitle: FutureBuilder(
                    future: getMosqueFb(),
                    builder: (_ , AsyncSnapshot snapshot){
                      if(snapshot.connectionState == ConnectionState.waiting){
                        return Center( child: CircularProgressIndicator());}
                      return 
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
          
          SizedBox(height: 20,),
          
          //Open Fb button
          RaisedButton(
                    elevation: 0.0,
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                    padding: EdgeInsets.only(
                        top: 7.0, bottom: 7.0, right: 40.0, left: 7.0),
                    onPressed: () {
                     openfburl();
                    },
                    child: new Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        new Image.asset(
                          'assets/images/facebook.png',
                          height: 40.0,
                          width: 40.0,
                        ),
                        Padding(
                            padding: EdgeInsets.only(left: 10.0),
                            child: new Text(
                              "Facebook",
                              style: TextStyle(
                                  fontSize: 15.0, fontWeight: FontWeight.bold),
                            ))
                      ],
                    ),
                    textColor: Colors.white,//Color(0xFF292929),
                    color: Colors.blue),
              ],
              ),

            ),

          ],
        ),

        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.edit),
          onPressed: () => Navigator.pushNamed(context, EditMosque.id),
        ),
      ),
    );
  }

  //MosqueName
  Future<String> getMosqueName() async {
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    final String uid = user.uid.toString();
    final CollectionReference userdata = Firestore.instance.collection("user");
    final CollectionReference mosquedata = Firestore.instance.collection("mosque");
    final result = await userdata.document(uid).get();
    final result2 = await mosquedata.document(result.data['MosqueId']).get();
    return result2.data['Name'];
  }

  //MosqueAddress
  Future<String> getMosqueAddress() async {
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    final String uid = user.uid.toString();
    final CollectionReference userdata = Firestore.instance.collection("user");
    final CollectionReference mosquedata = Firestore.instance.collection("mosque");
    final result = await userdata.document(uid).get();
    final result2 = await mosquedata.document(result.data['MosqueId']).get();
    return result2.data['Address'];
  }

  //MosqueInfo
  Future<String> getMosqueInfo() async {
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    final String uid = user.uid.toString();
    final CollectionReference userdata = Firestore.instance.collection("user");
    final CollectionReference mosquedata = Firestore.instance.collection("mosque");
    final result = await userdata.document(uid).get();
    final result2 = await mosquedata.document(result.data['MosqueId']).get();
    return result2.data['Info'];
  }

  //MosquePhone
  Future<String> getMosquePhone() async {
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    final String uid = user.uid.toString();
    final CollectionReference userdata = Firestore.instance.collection("user");
    final CollectionReference mosquedata = Firestore.instance.collection("mosque");
    final result = await userdata.document(uid).get();
    final result2 = await mosquedata.document(result.data['MosqueId']).get();
    return result2.data['Contact'];
  }

  //MosquePIC
  Future<String> getMosquePIC() async {
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    final String uid = user.uid.toString();
    final CollectionReference userdata = Firestore.instance.collection("user");
    final CollectionReference mosquedata = Firestore.instance.collection("mosque");
    final result = await userdata.document(uid).get();
    final result2 = await mosquedata.document(result.data['MosqueId']).get();
    return result2.data['PIC'];
  }

   //MosqueFb
  Future<String> getMosqueFb() async {
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    final String uid = user.uid.toString();
    final CollectionReference userdata = Firestore.instance.collection("user");
    final CollectionReference mosquedata = Firestore.instance.collection("mosque");
    final result = await userdata.document(uid).get();
    final result2 = await mosquedata.document(result.data['MosqueId']).get();
    String url1 = result2.data['Fb'].toString();
    return url1;}

   Future<bool> openfburl() async {
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    final String uid = user.uid.toString();
    final CollectionReference userdata = Firestore.instance.collection("user");
    final CollectionReference mosquedata = Firestore.instance.collection("mosque");
    final result = await userdata.document(uid).get();
    final result2 = await mosquedata.document(result.data['MosqueId']).get();
    String url1 = result2.data['Fb'].toString();
    return launch(url1);
                  }

}