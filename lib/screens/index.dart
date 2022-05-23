// ignore_for_file: unnecessary_new, unnecessary_const

import 'package:bottom_nav_bar/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:trouver_un_candidat/screens/dashboard.dart';
import 'package:trouver_un_candidat/screens/listJob.dart';
import 'package:trouver_un_candidat/screens/profile.dart';

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
            ListJob(),
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
            title: 'Accueil',
            icon: const Icon(Icons.dashboard_rounded),
            activeColor: Colors.white,
            inactiveColor: Colors.black,
            activeBackgroundColor: Colors.blue.shade300,
          ),
          BottomNavBarItem(
            title: 'Articles',
            icon: const Icon(Icons.bookmark_add_sharp),
            activeColor: Colors.white,
            inactiveColor: Colors.black,
            activeBackgroundColor: Colors.red.shade300,
          ),
          BottomNavBarItem(
            title: 'Réglages',
            icon: const Icon(Icons.settings_outlined),
            inactiveColor: Colors.black,
            activeColor: Colors.white,
            activeBackgroundColor: Colors.blue.shade300,
          ),
        ],
      );
}
