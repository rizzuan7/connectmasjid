import 'package:connectmasjid/Mosque/AddMosque.dart';
import 'package:connectmasjid/Mosque/MosqueDetail.dart';
import 'package:connectmasjid/Mosque/MosqueInfo.dart';
import 'package:connectmasjid/event/edit_event.dart';
import 'package:connectmasjid/event/event_details.dart';
import 'package:connectmasjid/main_screens/NavigationUser.dart';
import 'package:connectmasjid/event/EventMain.dart';
import 'package:connectmasjid/member/Member.dart';
import 'package:connectmasjid/member/MemberDetails.dart';
import 'package:connectmasjid/profile/EditProfile.dart';
import 'package:connectmasjid/user/MosqueDetailUser.dart';
import 'package:connectmasjid/user/ViewEventUser.dart';
import 'package:flutter/material.dart';
import 'package:connectmasjid/results_screen/ForgotPassword.dart';
import 'package:connectmasjid/main_screens/LoginPage.dart';
import 'package:connectmasjid/main_screens/RegisterPage.dart';
import 'package:connectmasjid/results_screen/UserHome.dart';
import 'package:connectmasjid/results_screen/AdminHome.dart';
import 'package:connectmasjid/profile/Profile.dart';
import 'package:connectmasjid/main_screens/Navigation.dart';
import 'package:connectmasjid/event/add_event.dart';
import 'package:connectmasjid/gmap.dart';
import 'package:connectmasjid/event/view_event.dart';
import 'package:connectmasjid/video/Youtube.dart';
import 'package:connectmasjid/user/MosqueInfoUser.dart';
import 'package:connectmasjid/Mosque/EditMosque.dart';
import 'package:connectmasjid/user/YoutubeUser.dart';
import 'package:connectmasjid/user/VideoMainUser.dart';
import 'package:connectmasjid/user/OtherMosqueEventUser.dart';
import 'package:connectmasjid/user/MainEventUser.dart';

void main() {
  runApp(Home());
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      initialRoute: LoginPage.id,
      routes: {
        //MainPage
        LoginPage.id: (context) => LoginPage(),
        RegisterPage.id: (context) => RegisterPage(),
        ForgotPassword.id: (context) => ForgotPassword(),
        UserHome.id: (context) => UserHome(),
        NavigationUser.id: (context) => NavigationUser(),
        AdminHome.id: (context) => AdminHome(),
        Navigation.id: (context) => Navigation(),

        //Profile
        Profile.id: (context) => Profile(),
        EditProfile.id: (context) => EditProfile(),

        //Event
        EventMain.id: (context) => EventMain(),
        AddEventPage.id: (context) => AddEventPage(),
        EventDetailsPage.id: (context) => EventDetailsPage(),
        EditEventPage.id: (context) => EditEventPage(),
        EventDetails.id: (context) => EventDetails(),

        //Mosque
        MosqueInfo.id: (context) => MosqueInfo(),
        MosqueDetail.id: (context) => MosqueDetail(),
        AddMosque.id: (context) => AddMosque(),
        EditMosque.id: (context) => EditMosque(),

        GMap.id: (context) => GMap(),
        Youtube.id: (context) => Youtube(),

        //User
        MosqueInfoUser.id: (context) => MosqueInfoUser(),
        MosqueDetailUser.id: (context) => MosqueDetailUser(),
        YoutubeUser.id: (context) => YoutubeUser(),
        VideoMainUser.id: (context) => VideoMainUser(),
        MainEventUser.id: (context) => MainEventUser(),
        ViewEventUser.id: (context) => ViewEventUser(),
        OtherMosqueEventUser.id: (context) => OtherMosqueEventUser(),
        ViewEventUser.id: (context) => ViewEventUser(),

        //Member
        Member.id: (context) => Member(),
        MemberDetails.id: (context) => MemberDetails(),
      },
    );
  }
}
