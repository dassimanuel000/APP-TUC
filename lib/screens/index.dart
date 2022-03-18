// ignore_for_file: unnecessary_new, unnecessary_const

import 'package:bottom_nav_bar/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:tuc/screens/dashboard.dart';
import 'package:tuc/screens/listJob.dart';
import 'package:tuc/screens/profile.dart';

class RootPage extends StatefulWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
      bottomNavigationBar: _bottomNavBar(),
    );
  }

  Widget _body() => SizedBox.expand(
        child: IndexedStack(
          index: _currentIndex,
          children: const <Widget>[
            Dashboard(title: 'Flutter Push Notification'),
            ListJob(title: 'Page List'),
            ProfilePage(),
          ],
        ),
      );

  Widget _bottomNavBar() => BottomNavBar(
        showElevation: true,
        selectedIndex: _currentIndex,
        onItemSelected: (index) {
          setState(() => _currentIndex = index);
        },
        items: <BottomNavBarItem>[
          BottomNavBarItem(
            title: 'Home',
            icon: const Icon(Icons.dashboard_rounded),
            activeColor: Colors.white,
            inactiveColor: Colors.black,
            activeBackgroundColor: Colors.red.shade300,
          ),
          BottomNavBarItem(
            title: 'Profiles',
            icon: const Icon(Icons.person_outlined),
            activeColor: Colors.white,
            inactiveColor: Colors.black,
            activeBackgroundColor: Colors.blue.shade300,
          ),
          BottomNavBarItem(
            title: 'Settings',
            icon: const Icon(Icons.settings_outlined),
            inactiveColor: Colors.black,
            activeColor: Colors.white,
            activeBackgroundColor: Colors.green.shade300,
          ),
        ],
      );
}
