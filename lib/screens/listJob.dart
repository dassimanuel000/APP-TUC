// ignore_for_file: file_names, prefer_const_constructors, unnecessary_new, import_of_legacy_library_into_null_safe, prefer_const_literals_to_create_immutables, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:tuc/main.dart';

class ListJob extends StatefulWidget {
  const ListJob({Key? key}) : super(key: key);

  @override
  _ListJobState createState() => _ListJobState();
}

class _ListJobState extends State<ListJob> {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void _showNotification() {
    flutterLocalNotificationsPlugin.show(
        0,
        "title",
        "body",
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channel.description,
            color: Colors.blue,
            playSound: true,
            icon: "@mipmap/ic_launcher",
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
          child: Container(
            child: ElevatedButton(
              onPressed: () {
                _showNotification;
              },
              child: Text('LONGGGGGGGGGGGGGGGGG'),
            ),
          ),
        ),
      ),
    );
  }
}
