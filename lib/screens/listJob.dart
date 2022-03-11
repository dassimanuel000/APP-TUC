// ignore_for_file: file_names, prefer_const_constructors, non_constant_identifier_names, unused_import, avoid_print, unused_element, prefer_const_literals_to_create_immutables

/*// ignore_for_file: file_names, prefer_const_constructors, unnecessary_new, import_of_legacy_library_into_null_safe, prefer_const_literals_to_create_immutables, avoid_print

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


*/

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    'This channel is used for important notifications.', // description
    importance: Importance.high,
    playSound: true);

// flutter local notification
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

// firebase background message handler
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('A Background message just showed up :  ${message.messageId}');
}

class ListJob extends StatefulWidget {
  const ListJob({Key? key, required this.title}) : super(key: key);

  final String title;
  Future<void> main() async {
    // firebase App initialize
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

// Firebase local notification plugin
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

//Firebase messaging
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  @override
  _ListJobState createState() => _ListJobState();
}

class _ListJobState extends State<ListJob> {
  int _counter = 0;

  @override
  void initState() {
    super.initState();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channel.description,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_lancher',
              ),
            ));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new messageopen app event was published');
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text("notification.title"),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text("notification.body")],
                  ),
                ),
              );
            });
      }
    });
  }

  void showNotification() {
    _counter++;

    flutterLocalNotificationsPlugin.show(
        0,
        "Testing $_counter",
        "This is an Flutter Push Notification",
        NotificationDetails(
            android: AndroidNotificationDetails(
                channel.id, channel.name, channel.description,
                importance: Importance.high,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _Header(),
      body: ListView(
        children: [
          ElevatedButton(
            onPressed: () {
              showNotification;
            },
            child: Text('LONGGGGGGGGGGGGGGGGG'),
          ),
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
