import 'package:connectmasjid/models/event.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditMosque extends StatefulWidget {
  static String id = '/EditMosque';
  final EventModel note;

  const EditMosque({Key key, this.note}) : super(key: key);

  @override
  _EditMosqueState createState() => _EditMosqueState();
}

class _EditMosqueState extends State<EditMosque> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  TextEditingController _id;
  TextEditingController _address;
  TextEditingController _info;
  TextEditingController _name;
  TextEditingController _contactNumber;
  TextEditingController _pic;
  TextEditingController _channelId;
  TextEditingController _fb;
  final _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();
  bool processing;

  @override
  void initState() {
    super.initState();
    _id = TextEditingController(text:"");
    _address = TextEditingController(text:"");
    _info = TextEditingController(text:"");
    _name = TextEditingController(text: "");
    _contactNumber = TextEditingController(text:"");
    _pic = TextEditingController(text:"");
    _channelId = TextEditingController(text:"");
    _fb = TextEditingController(text:"");
    processing = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Mosque Details"),
      ),
      key: _key,
      body: Form(
        key: _formKey,
        child: Container(
          alignment: Alignment.center,
          child: ListView(
            children: <Widget>[
              SizedBox(height: 10.0),
              //Mosque Name
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: TextFormField(
                  controller: _name,
                  style: style,
                  decoration: InputDecoration(
                      labelText: "Mosque name",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                ),
              ),
              //Mosque Address
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: TextFormField(
                  controller: _address,
                  minLines: 3,
                  maxLines: 5,
                  style: style,
                  decoration: InputDecoration(
                      labelText: "Address",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                ),
              ),
              //Mosque info
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: TextFormField(
                  controller: _info,
                  minLines: 2,
                  maxLines: 10,
                  style: style,
                  decoration: InputDecoration(
                      labelText: "Info",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                ),
              ),
              //Mosque Phone
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: TextFormField(
                  controller: _contactNumber,
                  style: style,
                  decoration: InputDecoration(
                      labelText: "Mosque Number",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                ),
              ),
              //Mosque PIC
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: TextFormField(
                  controller: _pic,
                  style: style,
                  decoration: InputDecoration(
                      labelText: "Person in charge",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                ),
              ),

              //Mosque Channel
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: TextFormField(
                  controller: _channelId,
                  style: style,
                  decoration: InputDecoration(
                      labelText: "Youtube Channel",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                ),
              ),
              //Mosque Facebook
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: TextFormField(
                  controller: _fb,
                  style: style,
                  decoration: InputDecoration(
                      labelText: "Facebook Page",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                ),
              ),
              const SizedBox(height: 10.0),

              SizedBox(height: 8.0),
              processing
                  ? Center(child: CircularProgressIndicator())
                  : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 64.0),
                child: Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(30.0),
                  color: Theme.of(context).primaryColor,
                  child: MaterialButton(
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        setState(() {
                          processing = true;
                        });
                        if(widget.note != null) {
                          editAddress(_address.text);
                          editMosqueContact(_contactNumber.text);
                          editMosqueInfo(_info.text);
                          editMosquePIC(_pic.text);
                          editMosqueName(_name.text);
                          editMosqueChannel(_channelId.text);
                          editMosqueFb(_fb.text);
                        }else{
                          editAddress(_address.text);
                          editMosqueContact(_contactNumber.text);
                          editMosqueInfo(_info.text);
                          editMosquePIC(_pic.text);
                          editMosqueChannel(_channelId.text);
                          editMosqueFb(_fb.text);
                        }
                        Navigator.pop(context);
                        setState(() {
                          processing = false;
                        });
                      }
                    },
                    child: Text(
                      "Save",
                      style: style.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            SizedBox(height: 25.0),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _address.dispose();
    _info.dispose();
    super.dispose();
  }

  Future<void> editMosqueName (String MosqueName) async {
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    final String uid = user.uid.toString();
    final CollectionReference userdata = Firestore.instance.collection("user");
    final result = await userdata.document(uid).get();
    final id2 = result.data['MosqueId'];
    if(MosqueName != "") {
      Firestore.instance.collection("mosque").document(id2).updateData(
          {"Name" : MosqueName,
          });
    }
    else {
      print ("Fail");
    }
  }

  Future<void> editAddress ( String Address) async {
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    final String uid = user.uid.toString();
    final CollectionReference userdata = Firestore.instance.collection("user");
    final result = await userdata.document(uid).get();
    final id2 = result.data['MosqueId'];
    if(Address != "") {
      Firestore.instance.collection("mosque").document(id2).
      updateData(
          {
            "Address" : Address,
          });
    }
    else {
      print ("Fail");
    }

  }

  Future<void> editMosqueInfo (String Info) async {
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    final String uid = user.uid.toString();
    final CollectionReference userdata = Firestore.instance.collection("user");
    final result = await userdata.document(uid).get();
    final id2 = result.data['MosqueId'];
    if(Info != "") {
      Firestore.instance.collection("mosque").document(id2).
      updateData(
          {
            "Info" : Info,
          });
    }
    else {
      print ("Fail");
    }
  }

  Future<void> editMosqueContact ( String Contact) async {
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    final String uid = user.uid.toString();
    final CollectionReference userdata = Firestore.instance.collection("user");
    final result = await userdata.document(uid).get();
    final id2 = result.data['MosqueId'];
    if(Contact != "") {
      Firestore.instance.collection("mosque").document(id2).
      updateData(
          {
            "Contact" : Contact,
          });
    }
    else {
      print ("Fail");
    }
  }

  Future<void> editMosquePIC ( String PIC) async {
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    final String uid = user.uid.toString();
    final CollectionReference userdata = Firestore.instance.collection("user");
    final result = await userdata.document(uid).get();
    final id2 = result.data['MosqueId'];
    if(PIC != "") {
      Firestore.instance.collection("mosque").document(id2).
      updateData(
          {
            "PIC" : PIC,
          });
    }
    else {
      print ("Fail");
    }
  }

  Future<void> editMosqueChannel (String MosqueChannel) async {
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    final String uid = user.uid.toString();
    final CollectionReference userdata = Firestore.instance.collection("user");
    final result = await userdata.document(uid).get();
    final id2 = result.data['MosqueId'];
    if(MosqueChannel != "") {
      Firestore.instance.collection("mosque").document(id2).updateData(
          {"ChannelId" : MosqueChannel,
          });
    }
    else {
      print ("Fail");
    }
  }

    Future<void> editMosqueFb ( String Fb) async {
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    final String uid = user.uid.toString();
    final CollectionReference userdata = Firestore.instance.collection("user");
    final result = await userdata.document(uid).get();
    final id2 = result.data['MosqueId'];
    if(Fb != "") {
      Firestore.instance.collection("mosque").document(id2).
      updateData(
          {
            "Fb" : Fb,
          });
    }
    else {
      print ("Fail");
    }
  }

}