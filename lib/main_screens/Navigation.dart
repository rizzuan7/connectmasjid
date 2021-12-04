import 'package:connectmasjid/video/Youtube.dart';
import 'package:flutter/material.dart';
import 'package:connectmasjid/profile/Profile.dart';
import 'package:connectmasjid/results_screen/AdminHome.dart';

class Navigation extends StatefulWidget {
  static String id = '/Navigation';

  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {

  int _currentIndex = 0;
  final List<Widget> _children = [
    AdminHome(),
    Profile(),
    Youtube(),
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