// ignore_for_file: file_names, prefer_const_constructors, unnecessary_new
import 'package:flutter/material.dart';
import 'package:native_notify/native_notify.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class ListJob extends StatefulWidget {
  const ListJob({Key? key}) : super(key: key);

  @override
  _ListJobState createState() => _ListJobState();
}

class _ListJobState extends State<ListJob> {
  late AnimationController _controller;

  late FlutterLocalNotificationsPlugin fltrNotification;

  @override
  void initState() {
    super.initState();
    var androidInitilize = new AndroidInitializationSettings('app_icon');
    var iOSinitilize = new IOSInitializationSettings();
    var initilizationsSettings =
        new InitializationSettings(androidInitilize, iOSinitilize);
    fltrNotification = new FlutterLocalNotificationsPlugin();
    fltrNotification.initialize(initilizationsSettings,
        onSelectNotification: notificationSelected);
  }

  Future _showNotification() async {
    var androidDetails = new AndroidNotificationDetails(
        "Channel ID", "Desi programmer", "This is my channel",
        importance: Importance.Max);
    var iSODetails = new IOSNotificationDetails();
    var generalNotificationDetails =
        new NotificationDetails(androidDetails, iSODetails);

    await fltrNotification.show(
        0, "Task", "You created a Task", generalNotificationDetails,
        payload: "Task");
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  Future notificationSelected(String payload) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text("Notification : $payload"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
          child: Container(
            child: ElevatedButton(
              onPressed: () {
                _showNotification();
                notificationSelected("VOILA");
              },
              child: Text('LONGGGGGGGGGGGGGGGGG'),
            ),
          ),
        ),
      ),
    );
  }
}
