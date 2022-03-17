import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tuc/widget/widget.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class AlertList extends StatefulWidget {
  final String text;
  const AlertList({Key? key, required this.text}) : super(key: key);

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
        'https://www.trouver-un-candidat.com/test/index.php?user=${widget.text}';
    var response = await http.get(Uri.parse(url));
    Map<String, dynamic> map = json.decode(response.body);
    List<dynamic> data = map["job_out_category"];
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: navigatorpop(context),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          height: MediaQuery.of(context).size.height,
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
                      ? ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            List list = snapshot.data;
                            //list = list['job_alert'];
                            return ListTile(
                              onTap: () {
                                _launchURL(list[index]['link']);
                              },
                              leading: CircleAvatar(
                                child: Image.asset(
                                    'assets/images/ic_launcher.png'),
                                backgroundColor: Colors.white,
                              ),
                              title: Text("${list[index]['post_title ']}"),
                              subtitle: Text(
                                  "Posté le : " + "${list[index]['date']}"),
                              trailing: TextButton(
                                  style: ButtonStyle(
                                    overlayColor: MaterialStateProperty
                                        .resolveWith<Color?>(
                                            (Set<MaterialState> states) {
                                      if (states
                                          .contains(MaterialState.focused))
                                        return Colors.blue;
                                      return null; // Defer to the widget's default.
                                    }),
                                  ),
                                  onPressed: () {
                                    _launchURL(list[index]['link']);
                                  },
                                  child: Text('Postulez')),
                            );
                          })
                      : ProgressLife();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
