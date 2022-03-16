// ignore_for_file: file_names, prefer_const_constructors, non_constant_identifier_names, unused_import, avoid_print, unused_element, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:tuc/constants/color.dart';
import 'package:tuc/screens/notif.dart';

class ListJob extends StatefulWidget {
  const ListJob({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _ListJobState createState() => _ListJobState();
}

class _ListJobState extends State<ListJob> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mBackgroundColor,
      appBar: _Header(),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          ExpansionTile(
            leading: Icon(
              Icons.message_rounded,
              color: gradientStartColor,
            ),
            title: Text("Mes Messages"),
            children: [
              Container(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(children: [
                    Padding(
                      padding: EdgeInsets.all(0.0),
                      child: Text(
                        "by :" + "Author",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(0.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("\n" +
                              "Message   AllocSpace objects, 10(328KB) LOS objects, 42% free, 2854KB/4958KB, paused 6.594ms total 506.128ms"),
                        ],
                      ),
                    ),
                  ]),
                ),
              ),
            ],
          )
        ],
      ),
    );
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
            onTap: () {},
          ),
          SizedBox(width: 20)
        ],
      );
}
