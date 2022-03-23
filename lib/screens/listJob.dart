import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tuc/constants/color.dart';
import 'package:tuc/screens/FDrawer.dart';
import 'package:tuc/screens/searchPage.dart';
import 'package:tuc/widget/widget.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class ListJob extends StatefulWidget {
  const ListJob({Key? key}) : super(key: key);

  @override
  _ListJobState createState() => _ListJobState();
}

class _ListJobState extends State<ListJob> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mBackgroundColor,
      appBar: _Header(),
      key: _scaffoldKey,
      drawer: MyDrawer(),
      body: ListView(
        children: [
          SizedBox(
            height: 5.0,
          ),
          Container(
              margin: EdgeInsets.only(bottom: 5),
              child: Container(
                padding: EdgeInsets.all(15.0),
                height: MediaQuery.of(context).size.width * 1.5,
                child: new News(),
              )),
        ],
      ),
    );
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
                      title: "Job",
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

class News extends StatelessWidget {
  const News({Key? key}) : super(key: key);

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
    var url = 'https://trouver-un-candidat.com/test/new.php';
    var response = await http.get(Uri.parse(url));
    Map<String, dynamic> map = json.decode(response.body);
    List<dynamic> data = map["news"];
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
                      itemBuilder: (context, index) {
                        List list = snapshot.data;
                        return GestureDetector(
                            onTap: () {
                              _launchURL("${list[index]['link']}");
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: Container(
                                color: Colors.transparent,
                                height: 80,
                                width: MediaQuery.of(context).size.width - 32,
                                child: Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Container(
                                      width: 88,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        /*image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                            '${list[index]['img']}',
                                          ),
                                        ),*/
                                      ),
                                      child: Image.network(
                                        '${list[index]['img']}',
                                        fit: BoxFit.cover,
                                        loadingBuilder:
                                            (context, child, loadingProgress) {
                                          if (loadingProgress == null)
                                            return child;

                                          return new ProgressLife();
                                          // You can use LinearProgressIndicator or CircularProgressIndicator instead
                                        },
                                        errorBuilder: (context, error,
                                                stackTrace) =>
                                            new Image.network(
                                                "https://i.ibb.co/QP8jHZ7/ic-launcher.png"),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 16,
                                    ),
                                    Flexible(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SingleChildScrollView(
                                            scrollDirection: Axis.vertical,
                                            child: Column(
                                              children: [
                                                Text(
                                                  "${list[index]['_title']}",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  style:
                                                      TextStyle(fontSize: 14.0),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const Spacer(),
                                          Text(
                                            "${list[index]['date']}",
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 3,
                                            style: TextStyle(fontSize: 8.0),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                136,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    RatingBar.builder(
                                                      itemSize: 16,
                                                      initialRating:
                                                          double.parse(
                                                        "4.8",
                                                      ),
                                                      minRating: 1,
                                                      direction:
                                                          Axis.horizontal,
                                                      itemCount: 5,
                                                      itemPadding:
                                                          EdgeInsets.zero,
                                                      itemBuilder:
                                                          (context, _) =>
                                                              const Icon(
                                                        Icons.star,
                                                        color: kYellowColor,
                                                      ),
                                                      onRatingUpdate: (rating) {
                                                        debugPrint(
                                                            rating.toString());
                                                      },
                                                      unratedColor:
                                                          contentTextColor,
                                                    ),
                                                    const SizedBox(
                                                      width: 4,
                                                    ),
                                                  ],
                                                ),
                                                Container(
                                                  height: 24,
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    horizontal: 13,
                                                    vertical: 3,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4),
                                                    color: successColor,
                                                  ),
                                                  child: Text(
                                                    'Read More',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .labelSmall!
                                                        .copyWith(
                                                          color:
                                                              backgroundWhite,
                                                        ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ));
                      })
                ]))
            : ProgressLife();
      },
    );
  }
}
