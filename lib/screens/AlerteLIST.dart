import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trouver_un_candidat/constants/color.dart';
import 'package:trouver_un_candidat/widget/widget.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class AlertList extends StatefulWidget {
  final String category;

  final String location;
  const AlertList({Key? key, required this.category, required this.location})
      : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<AlertList> {
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

  Future getData() async {
    var url =
        'https://trouver-un-candidat.com/test/alert.php?category=${widget.category}&${widget.location}';
    var response = await http.get(Uri.parse(url));
    Map<String, dynamic> map = json.decode(response.body);
    List<dynamic> data = map["job"];
    return data;
  }

  String _text(String link) {
    if (link.contains("indeed")) {
      return "https://i.ibb.co/8j6XTC7/indeed-small.png";
    } else {
      return "https://i.ibb.co/QP8jHZ7/ic-launcher.png";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: navigatorpop(context),
      body: Container(
        height: MediaQuery.of(context).size.width + 200.0,
        child: ListView(
          children: [
            FutureBuilder(
              future: getData(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasError) print(snapshot.error);
                /*String mainString = "toyota allion 260 2010";
                  String substring = "allion";

                  if (mainString.contains(substring)) {
                    print("true");
                  } else {
                    print("falses");
                  }*/
                return snapshot.hasData
                    ? SingleChildScrollView(
                        physics: ScrollPhysics(),
                        child: Column(children: <Widget>[
                          ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              itemCount: snapshot.data.length,
                              itemBuilder: (BuildContext context, int index) {
                                List list = snapshot.data;
                                print(snapshot.data.length);
                                //list = list['job_alert'];
                                return ListTile(
                                  onTap: () {
                                    _launchURL(list[index]['link']);
                                  },
                                  leading: CircleAvatar(
                                    child: Image.network(
                                        _text(list[index]['link'])),
                                    backgroundColor: Colors.white,
                                  ),
                                  title: Text("${list[index]['post_title ']}"),
                                  subtitle: Text(
                                      "Posté le : " + "${list[index]['date']}"),
                                  trailing: TextButton(
                                      style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty
                                            .resolveWith<Color?>(
                                          (Set<MaterialState> states) {
                                            if (states.contains(
                                                MaterialState.pressed))
                                              return Theme.of(context)
                                                  .colorScheme
                                                  .primary
                                                  .withOpacity(0.5);
                                            return mButtonEmailColor; // Use the component's default.
                                          },
                                        ),
                                        overlayColor: MaterialStateProperty
                                            .resolveWith<Color?>(
                                                (Set<MaterialState> states) {
                                          Colors
                                              .white; // Defer to the widget's default.
                                        }),
                                      ),
                                      onPressed: () {
                                        _launchURL(list[index]['link']);
                                      },
                                      child: Text(
                                        'Postulez',
                                        style:
                                            TextStyle(color: mBackgroundColor),
                                      )),
                                );
                              })
                        ]))
                    : ProgressLife();
              },
            ),
          ],
        ),
      ),
    );
  }
}
