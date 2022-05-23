// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, unused_import, avoid_print, unused_element, unused_local_variable, unnecessary_null_comparison

import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trouver_un_candidat/constants/color.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:trouver_un_candidat/screens/AlerteLIST.dart';
import 'package:trouver_un_candidat/screens/searchPage.dart';
import 'package:trouver_un_candidat/widget/widget.dart';

import 'package:trouver_un_candidat/screens/FDrawer.dart';

String uid = '';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final DateFormat formatter = DateFormat('yyyy-MM-dd');

  var keyword = TextEditingController();
  @override
  void initState() {
    super.initState();
    _loadCounter();
  }

  _loadCounter() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    setState(() {
      uid = (localStorage.getString('uid') ?? '');
    });
    await FirebaseMessaging.instance.subscribeToTopic('${uid}');
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mBackgroundColor,
      appBar: _Header(),
      key: _scaffoldKey,
      drawer: MyDrawer(),
      body: ListView(
        children: [
          search(keyword),
          SizedBox(
            height: 1.0,
          ),
          tile("Mes Alertes "),
          SizedBox(
            height: 1.0,
          ),
          Container(
              margin: EdgeInsets.only(bottom: 5),
              child: Container(
                padding: EdgeInsets.all(15.0),
                height: MediaQuery.of(context).size.width * 0.8,
                child: new View(),
              )),
          SizedBox(
            height: 2.0,
          ),
          SizedBox(
            height: 2.0,
          ),
        ],
      ),
    );
  }

  Widget search(var keyword) {
    return Container(
      margin: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: TextField(
                controller: keyword, //set user_pass controller
                decoration: InputDecoration(
                  hintText: 'Rechercher ...',
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.all(0),
                ),
                textAlignVertical: TextAlignVertical.center,
                onSubmitted: (value) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Search(
                          title: keyword.text,
                        ),
                      ));
                },
              ),
            ),
          ),
          Container(
            width: 1,
            height: 30,
            color: Colors.indigo[900],
          ),
          IconButton(
              icon: Icon(
                Icons.keyboard_arrow_right_rounded,
                color: Colors.indigo[900],
                size: 30,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Search(
                        title: keyword.text,
                      ),
                    ));
              }),
        ],
      ),
    );
  }

  Widget tile(String title) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Text(
          "${title}",
          style: kTitleStyle,
        ),
      ),
    );
  }

  Widget _buildCard(String name, String status, String cardIndex) {
    return Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        elevation: 7.0,
        child: Column(
          children: <Widget>[
            SizedBox(height: 12.0),
            Stack(children: <Widget>[
              Container(
                height: 60.0,
                width: 60.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    color: Colors.white,
                    image: DecorationImage(
                        image:
                            NetworkImage('https://i.ibb.co/3r1MkCM/icon.png'))),
              ),
              Container(
                margin: EdgeInsets.only(left: 40.0),
                height: 20.0,
                width: 20.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    color: status == 'Away' ? Colors.amber : Colors.green,
                    border: Border.all(
                        color: Colors.white,
                        style: BorderStyle.solid,
                        width: 2.0)),
              )
            ]),
            SizedBox(height: 8.0),
            Text(
              name,
              style: TextStyle(
                fontFamily: 'Quicksand',
                fontWeight: FontWeight.bold,
                fontSize: 15.0,
              ),
            ),
            SizedBox(height: 5.0),
            Text(
              status,
              style: TextStyle(
                  fontFamily: 'Quicksand',
                  fontWeight: FontWeight.bold,
                  fontSize: 12.0,
                  color: Colors.grey),
            ),
            SizedBox(height: 15.0),
            Expanded(
                child: Container(
                    width: 175.0,
                    decoration: BoxDecoration(
                      color: status == 'Away' ? Colors.grey : Colors.green,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10.0),
                          bottomRight: Radius.circular(10.0)),
                    ),
                    child: Center(
                      child: Text(
                        'Request',
                        style: TextStyle(
                            color: Colors.white, fontFamily: 'Quicksand'),
                      ),
                    )))
          ],
        ),
        margin: 1.isEven
            ? EdgeInsets.fromLTRB(10.0, 0.0, 25.0, 10.0)
            : EdgeInsets.fromLTRB(25.0, 0.0, 5.0, 10.0));
  }

  AppBar _Header() => AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.black87),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
          tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
        ),
        title: Image.asset('./assets/images/tuc.png'),
        actions: <Widget>[
          InkWell(
            child: Icon(
              Icons.search,
              color: Colors.black87,
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Search(
                      title: "job",
                    ),
                  ));
              print("click search");
            },
          ),
          SizedBox(width: 10),
          SizedBox(width: 20)
        ],
      );
}

class View extends StatelessWidget {
  Future getData() async {
    var url = 'https://www.trouver-un-candidat.com/test/index.php?user=${uid}';
    var response = await http.get(Uri.parse(url));
    Map<String, dynamic> map = json.decode(response.body);
    List<dynamic> data = map["filtre"];
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getData(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) print(snapshot.error);
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  List list = snapshot.data;
                  //list = list['job_alert'];
                  return ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AlertList(
                              category: list[index]['filter-category'],
                              location: list[index]['filter-location'],
                            ),
                          ));
                    },
                    leading: CircleAvatar(
                      child: Image.asset('assets/images/ic_launcher.png'),
                      backgroundColor: Colors.white,
                    ),
                    title: Text("${list[index]['title_filtre ']}"),
                    subtitle:
                        Text("Crée  le : " + "${list[index]['post_modified']}"),
                    trailing: Icon(Icons.arrow_forward_ios_rounded),
                  );
                })
            : ProgressLife();
      },
    );
  }
}
