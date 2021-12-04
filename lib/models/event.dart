import 'package:firebase_helpers/firebase_helpers.dart';

class EventModel extends DatabaseItem{
  final String id;
  final String Title;
  final String Description;
  final DateTime Date;
  final String MosqueId;

  EventModel({this.id,this.Title, this.Description, this.Date,this.MosqueId}):super(id);

  factory EventModel.fromMap(Map data) {
    return EventModel(
      Title: data['Title'],
      Description: data['Description'],
      Date: data['Date'],
      MosqueId: data['MosqueId'],
    );
  }

  factory EventModel.fromDS(String id, Map<String,dynamic> data) {
    return EventModel(
      id: id,
      Title: data['Title'],
      Description: data['Description'],
      Date: data['Date'].toDate(),
      MosqueId: data['MosqueId'],
    );
  }

  Map<String,dynamic> toMap() {
    return {
      "Title":Title,
      "Description": Description,
      "Date":Date,
      "id":id,
      'MosqueId':MosqueId,
    };
  }
}