// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, unused_import, avoid_print

import 'package:flutter/material.dart';
import 'package:tuc/widget/widget.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _Header(),
      body: ListView(),
    );
  }
}

AppBar _Header() => AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Image.asset('./assets/images/tuc.png'),
      leading: InkWell(
        child: Icon(
          Icons.menu,
          color: Colors.black87,
        ),
        onTap: () {
          print("click menu");
        },
      ),
      actions: <Widget>[
        InkWell(
          child: Icon(
            Icons.search,
            color: Colors.black87,
          ),
          onTap: () {
            print("click search");
          },
        ),
        SizedBox(width: 10),
        InkWell(
          child: Icon(
            Icons.notifications_outlined,
            color: Colors.black87,
          ),
          onTap: () {
            print("click more");
          },
        ),
        SizedBox(width: 20)
      ],
    );
