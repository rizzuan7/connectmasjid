import 'package:connectmasjid/models/event.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddMosque extends StatefulWidget {
  static String id = '/AddMosque';
  final EventModel note;
  const AddMosque({Key key, this.note}) : super(key: key);

  @override
  _AddMosqueState createState() => _AddMosqueState();
}

class _AddMosqueState extends State<AddMosque> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
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
    _address = TextEditingController(text:"");
    _info = TextEditingController(text:"");
    _name = TextEditingController(text:"");
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
        title: Text("Add Mosque"),
      ),
      key: _key,
      body: Form(
        key: _formKey,
        child: Container(
          alignment: Alignment.center,
          child: ListView(
            children: <Widget>[
              SizedBox(height: 20.0),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: TextFormField(
                  controller: _name,
                  validator: (value) =>
                  (value.isEmpty) ? "Please enter mosque name" : null,
                  style: style,
                  decoration: InputDecoration(
                      labelText: "Mosque name",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: TextFormField(
                  controller: _address,
                  minLines: 3,
                  maxLines: 5,
                  validator: (value) =>
                  (value.isEmpty) ? "Please enter address" : null,
                  style: style,
                  decoration: InputDecoration(
                      labelText: "Address",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: TextFormField(
                  controller: _info,
                  minLines: 2,
                  maxLines: 10,
                  validator: (value) =>
                  (value.isEmpty) ? "Please enter info" : null,
                  style: style,
                  decoration: InputDecoration(
                      labelText: "Info",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: TextFormField(
                  controller: _contactNumber,
                  validator: (value) =>
                  (value.isEmpty) ? "Please enter phone number" : null,
                  style: style,
                  decoration: InputDecoration(
                      labelText: "Mosque Number",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: TextFormField(
                  controller: _pic,
                  validator: (value) =>
                  (value.isEmpty) ? "Please enter name" : null,
                  style: style,
                  decoration: InputDecoration(
                      labelText: "Person in charge",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: TextFormField(
                  controller: _channelId,
                  validator: (value) =>
                  (value.isEmpty) ? "Please enter channel link" : null,
                  style: style,
                  decoration: InputDecoration(
                      labelText: "Youtube Channel",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: TextFormField(
                  controller: _fb,
                  validator: (value) =>
                  (value.isEmpty) ? "Please enter facebook link" : null,
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
                        if(1==1) {
                          addMosque(_address.text, _info.text,_name.text ,_contactNumber.text ,_pic.text, _channelId.text,_fb.text);
                        }else{
                          addMosque( _address.text,  _info.text,_name.text ,_contactNumber.text ,_pic.text, _channelId.text,_fb.text);
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

  Future<void> addMosque (String Address, String Info,String MosqueName,
  String Contact,String PIC,String ChannelId,String Fb) async {
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    final String uid = user.uid.toString();
    final CollectionReference userdata = Firestore.instance.collection("user");
    final result = await userdata.document(uid).get();
    final id2 = result.data['MosqueId'];
    Firestore.instance.collection("mosque").document(id2).
    setData(
        {  "id" : id2.toString(),
          "Address" : Address,
          "Info" : Info,
          "Name" : MosqueName,
          "Contact" : Contact ,
          "PIC": PIC ,
          "ChannelId" : ChannelId,
          "Fb" : Fb,
        });
  }

}