import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:tuc/screens/singleJOB.dart';
import 'package:tuc/widget/widget.dart';

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
          Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Container(
                padding: EdgeInsets.all(15.0),
                height: MediaQuery.of(context).size.width,
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

  final String title;
  Future getData() async {
    var url =
        'https://www.trouver-un-candidat.com/test/search.php?keyword=${title}';
    var response = await http.get(Uri.parse(url));
    Map<String, dynamic> map = json.decode(response.body);
    List<dynamic> data = map["job_alert"];
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
                    onTap: () {},
                    leading: CircleAvatar(
                      child: Image.asset('assets/images/ic_launcher.png'),
                      backgroundColor: Colors.white,
                    ),
                    title: Text("${jsonEncode(list)}"),
                    subtitle: Text("Fait le : "),
                    trailing: Icon(Icons.arrow_forward_ios_rounded),
                  );
                })
            : ProgressLife();
      },
    );
  }
}
