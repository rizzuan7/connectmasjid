import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditEventPage extends StatefulWidget {
  static String id = '/EditEventPage';
  String eventId;
  EditEventPage({this.eventId});

  @override
  _EditEventPageState createState() => _EditEventPageState(eventId);
}

class _EditEventPageState extends State<EditEventPage> {
  String eventId;
  _EditEventPageState(this.eventId);

  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  TextEditingController _id;
  TextEditingController _title;
  TextEditingController _description;
  TextEditingController _feedback;
  DateTime _eventDate;
  final _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();
  bool processing;

  @override
  void initState() {
    super.initState();
    _id = TextEditingController(text: eventId);
    _title = TextEditingController(text: "");
    _description = TextEditingController(text: "");
    _feedback = TextEditingController(text: "");
    _eventDate = DateTime.now();
    processing = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Event Details'),
      ),
      key: _key,
      body: Form(
        key: _formKey,
        child: Container(
          alignment: Alignment.center,
          child: ListView(
            children: <Widget>[
              SizedBox(height: 20.0),

              //EventId
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: TextFormField(
                  controller: _id,
                  validator: (value) =>
                      (value.isEmpty) ? "Please enter id" : null,
                  style: style,
                  decoration: InputDecoration(
                      labelText: "ID",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
              ),

              //EventTitle
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: TextFormField(
                  controller: _title,
                  style: style,
                  decoration: InputDecoration(
                      labelText: "Title",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
              ),

              //EventDesc
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: TextFormField(
                  controller: _description,
                  minLines: 3,
                  maxLines: 5,
                  style: style,
                  decoration: InputDecoration(
                      labelText: "description",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
              ),

              //Event Feedback
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: TextFormField(
                  controller: _feedback,
                  style: style,
                  decoration: InputDecoration(
                      labelText: "Link google form",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
              ),

              //EventDate
              const SizedBox(height: 10.0),
              ListTile(
                title: Text("Date (YYYY-MM-DD)"),
                subtitle: Text(
                    "${_eventDate.year} - ${_eventDate.month} - ${_eventDate.day}"),
                onTap: () async {
                  DateTime picked = await showDatePicker(
                      context: context,
                      initialDate: _eventDate,
                      firstDate: DateTime(_eventDate.year - 5),
                      lastDate: DateTime(_eventDate.year + 5));
                  if (picked != null) {
                    setState(() {
                      _eventDate = picked;
                    });
                  }
                },
              ),
              SizedBox(height: 10.0),
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
                              if (eventId != null) {
                                editTitle(_id.text, _title.text);
                                editDescp(_id.text, _description.text);
                                editDate(_id.text, _eventDate);
                                editFeedback(_id.text, _feedback.text);
                              } else {
                                editTitle(_id.text, _title.text);
                                editDescp(_id.text, _description.text);
                                editDate(_id.text, _eventDate);
                                editFeedback(_id.text, _feedback.text);
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
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _title.dispose();
    _description.dispose();
    super.dispose();
  }

  Future<void> editTitle(String id, String Title) async {
    if (Title != "") {
      Firestore.instance.collection("events").document(id).updateData({
        "id": id,
        "Title": Title,
      });
    } else {
      print("Title Fail");
    }
  }

  Future<void> editDate(
      String id, DateTime Date) async {
    if (Date != null) {
      Firestore.instance.collection("events").document(id).updateData({
        "id": id,
        "Date": Date,
      });
    } else {
      print("Fail");
    }
  }

  Future<void> editDescp(String id, String Descp) async {
    if (Descp != "") {
      Firestore.instance.collection("events").document(id).updateData({
        "id": id,
        "Description": Descp,
      });
    } else {
      print("Descp Fail");
    }
  }

  Future<void> editFeedback(String id, String Feedback) async {
    if (Feedback != "") {
      Firestore.instance.collection("events").document(id).updateData({
        "id": id,
        "Feedback": Feedback,
      });
    } else {
      print("Feedback Fail");
    }
  }
}
