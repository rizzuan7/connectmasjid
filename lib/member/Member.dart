import 'package:connectmasjid/member/MemberDetails.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class Member extends StatefulWidget {
  static String id = '/Member';
  @override
  _MemberState createState() => _MemberState();
}

class _MemberState extends State<Member> {
  List memberlist = [];
  String mosqueId;

  @override
  void initState() {
    super.initState();
    fetchMemberList();
    fetchMosqueData();
  }

  fetchMemberList() async {
    dynamic resultant = await getmembers();
    if (resultant == null) {
      print("Null");
    } else {
      setState(() {
        memberlist = resultant;
      });
      if (memberlist.isNotEmpty) {
        print("memberlist ada");
      }
    }
  }

  fetchMosqueData() async {
    dynamic resultant2 = await getMosqueId();
    if (resultant2 == null) {
      print("Null");
    } else {
      setState(() {
        mosqueId = resultant2;
      });
      if (mosqueId.isNotEmpty) {
        print("Masjid :" + mosqueId);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('List of Member'),
        ),
        body: Container(
            height: 400,
            child: ListView.builder(
                itemCount: memberlist.length,
                itemBuilder: (context, index) {
                if (memberlist[index]['Name'] != null &&
                      memberlist[index]['MosqueId'] == mosqueId && memberlist[index]['isAdmin'] != true) {
                    return Card(
                      child: ListTile(
                        title: Text(memberlist[index]['Name']),
                        trailing: Icon(
                          Icons.list,
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => MemberDetails(
                                      UserId: memberlist[index]['uid'])));
                        },
                      ),
                    );
                  }
                })));
  }

  Future<List> getmembers() async {
    List _memberlist = [];
    CollectionReference Memberlist = Firestore.instance.collection("user");
    await Memberlist.getDocuments().then((QuerySnapshot) {
      QuerySnapshot.documents.forEach((element) {
        _memberlist.add(element.data);
      });
    });
    return _memberlist;
  }

  Future<String> getMosqueId() async {
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    final String uid = user.uid.toString();
    final CollectionReference userdata = Firestore.instance.collection("user");
    final result = await userdata.document(uid).get();
    return result.data['MosqueId'];
  }
}
