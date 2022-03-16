// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, unused_import, avoid_print, unused_element, unused_local_variable, unnecessary_null_comparison

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:tuc/constants/color.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:tuc/screens/searchPage.dart';

final url = "https://trouver-un-candidat.com/test/login.php";

class HttpService {
  static const Map<String, String> _JSON_HEADERS = {
    "content-type": "application/json"
  };
  final String postsURL =
      "https://www.trouver-un-candidat.com/test/index.php?user=421";
  Future<List<Post>> getPosts() async {
    Response res = await get(Uri.parse(postsURL), headers: _JSON_HEADERS);

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);

      List<Post> posts = body
          .map(
            (dynamic item) => Post.fromJson(item),
          )
          .toList();

      return posts;
    } else {
      throw "Unable to retrieve posts.";
    }
  }
}

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final HttpService httpService = HttpService();
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
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
        children: [
          search(),
          SizedBox(
            height: 10.0,
          ),
          tile("Alertes Emploi"),
          SizedBox(
            height: 10.0,
          ),
          FutureBuilder(
            future: httpService.getPosts(),
            builder:
                (BuildContext context, AsyncSnapshot<List<Post>> snapshot) {
              if (snapshot.hasData) {
                List<Post>? posts = snapshot.data;
                print(post);
                return Column(
                  children: posts!
                      .map(
                        (Post post) => ListTile(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Search(
                                    text: post.ID,
                                  ),
                                ));
                          },
                          leading: CircleAvatar(
                            child: Image.network(
                                'https://i.ibb.co/3r1MkCM/icon.png'),
                            backgroundColor: Colors.white,
                          ),
                          title: Text("${post.post_title}"),
                          subtitle: Text("${post.post_modified}"),
                          trailing: Icon(Icons.arrow_forward_ios_rounded),
                        ),
                      )
                      .toList(),
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ],
      ),
    );
  }

  Widget search() {
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
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search..',
                border: InputBorder.none,
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.indigo[900],
                ),
                isDense: true,
                contentPadding: EdgeInsets.all(0),
              ),
              textAlignVertical: TextAlignVertical.center,
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
              onPressed: () {}),
        ],
      ),
    );
  }

  Widget tile(String title) {
    return Container(
      margin: EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          "${title}",
          style: kTitleStyle,
        ),
      ),
    );
  }

  Widget _buildCard(String name, String status, int cardIndex) {
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
        margin: cardIndex.isEven
            ? EdgeInsets.fromLTRB(10.0, 0.0, 25.0, 10.0)
            : EdgeInsets.fromLTRB(25.0, 0.0, 5.0, 10.0));
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

class Post {
  final String post_author;
  final String ID;
  final String post_title;
  final String post_status;
  final String post_modified;

  Post({
    required this.post_author,
    required this.ID,
    required this.post_title,
    required this.post_status,
    required this.post_modified,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      post_author: json['post_author'] as String,
      ID: json['ID'] as String,
      post_title: json['post_title'] as String,
      post_status: json['post_status'] as String,
      post_modified: json['post_modified'] as String,
    );
  }
}
