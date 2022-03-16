import 'package:flutter/material.dart';
import 'package:tuc/widget/widget.dart';

class Search extends StatefulWidget {
  final String text;
  const Search({Key? key, required this.text}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: navigatorpop(context),
      body: ListView(
        children: [Text(widget.text)],
      ),
    );
  }
}
