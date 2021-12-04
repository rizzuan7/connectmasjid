import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditProfile extends StatefulWidget {
  static String id = '/EditProfile';
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile>
    with SingleTickerProviderStateMixin {
  bool _status = true;
  final FocusNode myFocusNode = FocusNode();
  TextEditingController Name;
  TextEditingController SurauName;
  TextEditingController State;
  TextEditingController Phone;
  TextEditingController Gender;
  TextEditingController MosqueId;
  String dropdownValue = "";
  String dropdownValue1 = "";

  @override
  void initState() {
    // TODO: implement initState
    Name = TextEditingController(text: "");
    SurauName = TextEditingController( text: "");
    State = TextEditingController(text: "");
    Phone = TextEditingController(text: "");
    Gender = TextEditingController(text: "");
    MosqueId = TextEditingController(text: "");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.purple,
          title: Text('Edit Profile'),
        ),
      body: new Container(
        color: Colors.white,
        child: new ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                SizedBox(height: 20,),
                new Container(
                  color: Color(0xffFFFFFF),
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 25.0),
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 0.0),
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                new Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    new Text(
                                      'User Information',
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                new Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    _status ? _getEditIcon() : new Container(),
                                  ],
                                )
                              ],
                            )),
                        SizedBox(height: 10,),
                        //Name
                        Padding(
                            padding: EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 10.0),
                            child: new Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                new Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    new Text(
                                      'Name',
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                        Padding(
                            padding: EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 2.0),
                            child: new Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                new Flexible(
                                  child: new TextField(
                                    controller: Name,
                                    decoration: const InputDecoration(
                                      hintText: "Enter Your Name",
                                    ),
                                    enabled: !_status,
                                    autofocus: !_status,

                                  ),
                                ),
                              ],
                            )),

                        //Mobile
                        Padding(
                            padding: EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 15.0),
                            child: new Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                new Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    new Text(
                                      'Mobile',
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                        Padding(
                            padding: EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 2.0),
                            child: new Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                new Flexible(
                                  child: new TextField(
                                    controller: Phone,
                                    decoration: const InputDecoration(
                                        hintText: "Enter Mobile Number"),
                                    enabled: !_status,
                                  ),
                                ),
                              ],
                            )),

                        //Surau Name
                        Padding(
                            padding: EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 15.0),
                            child: new Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                new Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    new Text(
                                      'Surau Name',
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                        Padding(
                            padding: EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 2.0),
                            child: new Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                new Flexible(
                                  child: new TextField(
                                    controller: SurauName,
                                    decoration: const InputDecoration(
                                        hintText: "Enter surau name"),
                                    enabled: !_status,
                                  ),
                                ),
                              ],
                            )),

                        //SurauId
                        Padding(
                            padding: EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 15.0),
                            child: new Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                new Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    new Text(
                                      'Mosque Id',
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                        Padding(
                            padding: EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 2.0),
                            child: new Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                new Flexible(
                                  child: new TextField(
                                    controller: MosqueId,
                                    decoration: const InputDecoration(
                                        hintText: "Enter mosque id"),
                                    enabled: !_status,
                                  ),
                                ),
                              ],
                            )),

                        //Gender and State
                        Padding(
                            padding: EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 15.0),
                            child: new Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    child: new Text(
                                      'Gender',
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  flex: 2,
                                ),
                                Expanded(
                                  child: Container(
                                    child: new Text(
                                      'State',
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  flex: 2,
                                ),
                              ],
                            )),
                        Padding(
                            padding: EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 2.0),
                            child: new Row(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Flexible(
                                  child: DropdownButton<String>( 
                                value: dropdownValue,
                                style: TextStyle(color: Colors.black),
                                underline: Container(
                                 height: 4,
                                 color: Colors.deepPurpleAccent, ),
                                  onChanged: (String newValue) {
                                  setState(() {
                                 dropdownValue = newValue; 
                                 Gender.text = newValue;}); },
                                 items: <String>["",'Male','Female'].map<DropdownMenuItem<String>>((String value) {
                                 return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value,),
                                  ); }).toList(),
                                  ),
                                  flex: 2,
                                ),
                                SizedBox( width: 105, ),
                                
                                Flexible(
                                  child: DropdownButton<String>( 
                                value: dropdownValue1,
                                style: TextStyle(color: Colors.black),
                                underline: Container(
                                 height: 4,
                                 color: Colors.deepPurpleAccent, ),
                                  onChanged: (String newValue) {
                                  setState(() {
                                 dropdownValue1 = newValue; 
                                 State.text = newValue;}); },
                                 items: <String>["",'Kuala Lumpur','Selangor','Kelantan','Kedah','Perak','Pulau Pinang','Perlis',
                                 'Terengganu','Pahang','Negeri Sembilan',
                                 'Johor','Melaka','Sabah', 'Sarawak','Labuan'].map<DropdownMenuItem<String>>((String value) {
                                 return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                  ); }).toList(),
                                  ),
                                  flex: 3,
                                ),
                              ],
                            )),
                        !_status ? _getActionButtons() : new Container(),
                      ],
                    ),
                  ),
                )
              ],
            ),

          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myFocusNode.dispose();
    super.dispose();
  }

  Widget _getActionButtons() {
    return Padding(
      padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Container(
                  child: new RaisedButton(
                    child: new Text("Save"),
                    textColor: Colors.white,
                    color: Colors.green,
                    onPressed: () {
                      setState(() {
                        _status = true;
                        FocusScope.of(context).requestFocus(new FocusNode());
                        FirebaseAuth.instance.currentUser().then((user) {
                          AddName(Name.text, user.uid);
                          AddGender(Gender.text, user.uid);
                          AddState(State.text, user.uid);
                          AddSurauName(SurauName.text, user.uid);
                          AddPhone(Phone.text, user.uid);
                          AddMosqueId(MosqueId.text, user.uid);
                        });
                      });
                    },
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0)),
                  )),
            ),
            flex: 2,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Container(
                  child: new RaisedButton(
                    child: new Text("Cancel"),

                    textColor: Colors.white,
                    color: Colors.red,
                    onPressed: () {
                      setState(() {
                        _status = true;
                        FocusScope.of(context).requestFocus(new FocusNode());
                      });
                    },
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0)),
                  )),
            ),
            flex: 2,
          ),
        ],
      ),
    );
  }

  Widget _getEditIcon() {
    return new GestureDetector(
      child: new CircleAvatar(
        backgroundColor: Colors.purpleAccent,
        radius: 14.0,
        child: new Icon(
          Icons.edit,
          color: Colors.white,
          size: 16.0,
        ),
      ),
      onTap: () {
        setState(() {
          _status = false;
        });
      },
    );
  }


  void AddName (String Name,String uid) {
    if(Name != "") {
      Firestore.instance.collection("user").document(uid).updateData(
          { "Name" : Name,
          }); }
    else {
      print ("Fail");
    }
  }

  void AddSurauName (String SurauName, String uid) {
    if(SurauName != "") {
      Firestore.instance.collection("user").document(uid).updateData(
          {
            "Surau Name" : SurauName,
          }); }
    else {
      print ("Fail");
    }
  }

  void AddPhone ( String Phone, String uid) {
    if(Phone != "") {
      Firestore.instance.collection("user").document(uid).updateData(
          {
            "Phone Number" : Phone,
          }); }
    else {
      print ("Fail");
    }
  }

  void AddGender ( String Gender,String uid) {
    if(Gender != "") {
      Firestore.instance.collection("user").document(uid).updateData(
          {
            "Gender" : Gender,
          }); }
    else {
      print ("Fail");
    }
  }

  void AddState (String State,String uid) {
    if(State != "") {
      Firestore.instance.collection("user").document(uid).updateData(
          {
            "State" : State
          }); }
    else {
      print ("Fail");
    }
  }

  void AddMosqueId (String Id,String uid) {
    if(Id != "") {
      Firestore.instance.collection("user").document(uid).updateData(
          {
            "MosqueId" : Id
          }); }
    else {
      print ("Fail");
    }
  }

  Future getProfile(String uid) async {
    List Profilelist = [];
    CollectionReference Pro = Firestore.instance.collection("user");
    await Pro.document(uid).get().then((QuerySnapshot) {
      Profilelist.add(QuerySnapshot.data);
    });
    return Profilelist;
  }

}
