import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:trouver_un_candidat/constants/color.dart';
import 'package:trouver_un_candidat/widget/widget.dart';
import 'package:url_launcher/url_launcher.dart';

int _counter = 0;

Widget callcount(context, int count) {
  return Text("");
}

class Search extends StatefulWidget {
  //final String text;
  const Search({Key? key, required this.title}) : super(key: key);

  final String title;
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: navigatorpop(context),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(child: callcount(context, _counter)),
          ),
          Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Container(
                padding: EdgeInsets.all(15.0),
                height: MediaQuery.of(context).size.width * 1.5,
                child: new View(
                  title: widget.title,
                ),
              )),
        ],
      ),
    );
  }
}

class View extends StatelessWidget {
  const View({Key? key, required this.title}) : super(key: key);

  String _text(String link) {
    if (link.contains("indeed")) {
      return "https://i.ibb.co/8j6XTC7/indeed-small.png";
    } else {
      return "https://i.ibb.co/QP8jHZ7/ic-launcher.png";
    }
  }

  final String title;
  //int _counter = 0;
  //late String reims;

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
        'https://trouver-un-candidat.com/test/search.php?keyword=${title}';
    var response = await http.get(Uri.parse(url));
    Map<String, dynamic> map = json.decode(response.body);
    List<dynamic> data = map["job"];
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getData(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) print(snapshot.error);
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
                        _counter = snapshot.data.length;
                        callcount(context, _counter);
                        return ExpansionTile(
                          leading: CircleAvatar(
                            child: Image.network(_text(list[index]['link'])),
                            backgroundColor: mBackgroundColor,
                          ),
                          title: Text("${list[index]['post_title ']}"),
                          children: [
                            Container(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Column(children: [
                                  Padding(
                                    padding: EdgeInsets.all(0.0),
                                    child: Text(
                                      "Add to : "
                                      "${list[index]['date']}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(0.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("${list[index]['post_content']}"),
                                      ],
                                    ),
                                  ),
                                ]),
                              ),
                            ),
                          ],
                          trailing: TextButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.resolveWith<Color?>(
                                  (Set<MaterialState> states) {
                                    return Colors
                                        .green; // Use the component's default.
                                  },
                                ),
                                overlayColor:
                                    MaterialStateProperty.resolveWith<Color?>(
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
                                style: TextStyle(color: mBackgroundColor),
                              )),
                        );
                      })
                ]))
            : ProgressLife();
      },
    );
  }
}
