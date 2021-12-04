import 'package:firebase_helpers/firebase_helpers.dart';

class MosqueModel extends DatabaseItem{
  final String Address;
  final String Contact;
  final String Info;
  final String Name;
  final String PIC;
  final String id;

  MosqueModel({this.id,this.Name, this.Contact,this.Address,this.Info, this.PIC}):super(id);

  factory MosqueModel.fromMap(Map data) {
    return MosqueModel(
      id: data['id'],
      Address: data['Description'],
      Contact: data['Date'],
      Name: data['Name'],
      Info: data['Info'],
      PIC: data['PIC'],
    );
  }

  factory MosqueModel.fromDS(String id, Map<String,dynamic> data) {
    return MosqueModel(
      id: data['id'],
      Address: data['Description'],
      Contact: data['Date'],
      Name: data['Name'],
      Info: data['Info'],
      PIC: data['PIC'],
    );
  }

  Map<String,dynamic> toMap() {
    return {
      "id" : id,
      "Name":Name,
      "Contact": Contact,
      "Address": Address,
      "Info":Info,
      "PIC":PIC,
    };
  }
}