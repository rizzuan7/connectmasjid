import 'package:flutter/material.dart';
import 'package:connectmasjid/profile/Profile.dart';
import 'package:connectmasjid/results_screen/UserHome.dart';
import 'package:connectmasjid/user/VideoMainUser.dart';

class NavigationUser extends StatefulWidget {
  static String id = '/NavigationUser';

  @override
  _NavigationUserState createState() => _NavigationUserState();
}

class _NavigationUserState extends State<NavigationUser> {

  int _currentIndex = 0;
  final List<Widget> _children = [
    UserHome(),
    Profile(),
    VideoMainUser(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.purple,

          onTap: onTabTapped,
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: new Icon(Icons.home),
              title: new Text("Home"),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.account_circle),
              title: new Text("Profile"),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.video_collection),
              title: new Text("Video"),
            ),
          ]
      ),


    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}