// ignore_for_file: avoid_unnecessary_containers, sized_box_for_whitespace, use_key_in_widget_constructors, file_names, prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trouver_un_candidat/constants/color.dart';
import 'package:url_launcher/url_launcher.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> with TickerProviderStateMixin {
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

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: true,
        forceWebView: true,
        enableJavaScript: true,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  String uid = '';
  String user_email = '';
  String user_login = '';
  _loadCounter() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    uid = (localStorage.getString('uid') ?? '');
    user_email = (localStorage.getString('user_email') ?? '');
    user_login = (localStorage.getString('user_login') ?? '');
  }

  @override
  void setState(VoidCallback fn) {
    // ignore: todo
    // TODO: implement setState
    super.setState(fn);
    _loadCounter();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text("${user_login}"),
            accountEmail: Text("${user_email}"),
            currentAccountPicture: CircleAvatar(
              child: Image.network("https://i.ibb.co/QP8jHZ7/ic-launcher.png"),
            ),
          ),
          ListTile(
            title: Text("Offfres"),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: mButtonFacebookColor,
            ),
            onLongPress: () {},
            onTap: () {
              _launchURL("https://trouver-un-candidat.com/liste-des-offres");
            },
          ),
          Divider(),
          ListTile(
            title: Text("Site Web"),
            trailing: Icon(
              Icons.ondemand_video,
              color: mButtonFacebookColor,
            ),
            onLongPress: () {},
            onTap: () {
              _launchURL("https://trouver-un-candidat.com/");
            },
          ),
          Divider(),
          ListTile(
            title: Text("Tutoriels Youtube"),
            trailing: Icon(
              Icons.collections,
              color: mButtonFacebookColor,
            ),
            onLongPress: () {},
            onTap: () {
              _launchURL(
                  "https://www.youtube.com/channel/UCAtFP6U10RSNtLUsE6PU4fg");
            },
          ),
          Divider(),
          ListTile(
            title: Text("Fermer"),
            trailing: Icon(
              Icons.close,
              color: Colors.red.shade300,
            ),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
