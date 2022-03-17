// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, unused_import, import_of_legacy_library_into_null_safe, unused_element
// ignore_for_file: unnecessary_new

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweetalert/sweetalert.dart';
import 'package:tuc/constants/color.dart';
import 'package:tuc/screens/FDrawer.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: FDrawer(),
        backgroundColor: backgroundWhite,
        body: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(),
            child: Column(
              children: [
                Stack(
                  fit: StackFit.passthrough,
                  children: [
                    Container(
                      height: 180,
                      width: double.infinity,
                    ),
                    Container(
                      height: 150,
                      width: double.infinity,
                      decoration: new BoxDecoration(
                        color: backgroundWhite,
                        image: DecorationImage(
                          image: ExactAssetImage('assets/images/bg.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(15.0),
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                color: backgroundWhite,
                                borderRadius: BorderRadius.circular(10.0),
                                boxShadow: [
                                  BoxShadow(
                                    offset: Offset(0.0, 0.0),
                                    blurRadius: 20,
                                    spreadRadius: -2.0,
                                    color: secondaryMessageBoxColor,
                                  ),
                                ],
                              ),
                              child: Align(
                                alignment: Alignment.center,
                                child: IconButton(
                                    icon: Icon(Icons.menu,
                                        color: primaryTextColorDark),
                                    onPressed: () {}),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 60.0,
                      left: (MediaQuery.of(context).size.width / 2 - 50),
                      child: Container(
                        height: 120,
                        width: 120,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 7),
                              blurRadius: 23,
                              spreadRadius: -1,
                              color: primaryBackgroundColor,
                            ),
                          ],
                          image: DecorationImage(
                            image: ExactAssetImage('assets/images/logo.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  decoration: BoxDecoration(color: backgroundWhite),
                  width: double.infinity,
                  child: Column(
                    //crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          _launchURL("https://trouver-un-candidat.com/login");
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          width: MediaQuery.of(context).size.width - 30,
                          height: 50,
                          decoration: BoxDecoration(
                            color: backgroundWhite,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0.0, 0.0),
                                blurRadius: 20,
                                spreadRadius: -2.0,
                                color: primaryBackgroundColor,
                              ),
                            ],
                          ),
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(left: 5, top: 5),
                                child: IconButton(
                                    icon: Icon(Icons.lock,
                                        color: Colors.blueAccent),
                                    onPressed: () {}),
                              ),
                              Container(
                                width: 160,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 5, top: 5),
                                  child: Text(
                                    'Account',
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 18.0,
                                      color: primaryTextColorLight,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.09,
                              ),
                              Padding(
                                  padding: EdgeInsets.only(left: 10, top: 5),
                                  child: Container(
                                    width: 50,
                                    decoration: BoxDecoration(
                                      color: backgroundWhite,
                                      image: DecorationImage(
                                        image: ExactAssetImage(
                                            'assets/images/icon-3.png'),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    child: Center(
                                      child: IconButton(
                                          icon: Icon(
                                            Icons.arrow_forward_ios,
                                            color: Colors.blueAccent,
                                            size: 10.0,
                                          ),
                                          onPressed: () {}),
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () {
                          _launchURL(
                              "https://trouver-un-candidat.com/new-employer");
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          width: MediaQuery.of(context).size.width - 30,
                          height: 50,
                          decoration: BoxDecoration(
                            color: backgroundWhite,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0.0, 0.0),
                                blurRadius: 20,
                                spreadRadius: -2.0,
                                color: primaryBackgroundColor,
                              ),
                            ],
                          ),
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(left: 5, top: 5),
                                child: IconButton(
                                    icon: Icon(Icons.shopping_cart,
                                        color: Colors.orange),
                                    onPressed: () {}),
                              ),
                              Container(
                                width: 160,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 5, top: 5),
                                  child: Text(
                                    'Postez une offre',
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 18.0,
                                      color: primaryTextColorLight,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.09,
                              ),
                              Padding(
                                  padding: EdgeInsets.only(left: 10, top: 5),
                                  child: Container(
                                    width: 50,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: ExactAssetImage(
                                            'assets/images/icon-2.png'),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    child: Center(
                                      child: IconButton(
                                          icon: Icon(
                                            Icons.arrow_forward_ios,
                                            color: Colors.orange,
                                            size: 10.0,
                                          ),
                                          onPressed: () {}),
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () {
                          _launchURL(
                              "https://trouver-un-candidat.com/articles/");
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          width: MediaQuery.of(context).size.width - 30,
                          height: 50,
                          decoration: BoxDecoration(
                            color: backgroundWhite,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0.0, 0.0),
                                blurRadius: 20,
                                spreadRadius: -2.0,
                                color: primaryBackgroundColor,
                              ),
                            ],
                          ),
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(left: 5, top: 5),
                                child: IconButton(
                                    icon: Icon(Icons.message,
                                        color: Colors.lightGreen),
                                    onPressed: () {}),
                              ),
                              Container(
                                width: 160,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 5, top: 5),
                                  child: Text(
                                    "Articles D'emplois",
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 16.0,
                                      color: primaryTextColorLight,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.09,
                              ),
                              Padding(
                                  padding: EdgeInsets.only(left: 10, top: 5),
                                  child: Container(
                                    width: 50,
                                    decoration: BoxDecoration(
                                      color: backgroundWhite,
                                      image: DecorationImage(
                                        image: ExactAssetImage(
                                            'assets/images/icon-6.png'),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    child: Center(
                                      child: IconButton(
                                          icon: Icon(
                                            Icons.arrow_forward_ios,
                                            color: Colors.lightGreen,
                                            size: 10.0,
                                          ),
                                          onPressed: () {}),
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () {
                          SweetAlert.show(context,
                              title: "RECHARGER LES OFFRES",
                              subtitle: "Vous pouvez voir les Offres",
                              style: SweetAlertStyle.success);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          width: MediaQuery.of(context).size.width - 30,
                          height: 50,
                          decoration: BoxDecoration(
                            color: backgroundWhite,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0.0, 0.0),
                                blurRadius: 20,
                                spreadRadius: -2.0,
                                color: primaryBackgroundColor,
                              ),
                            ],
                          ),
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(left: 5, top: 5),
                                child: IconButton(
                                    icon: Icon(Icons.near_me,
                                        color: Colors.purpleAccent),
                                    onPressed: () {}),
                              ),
                              Container(
                                width: 160,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 5, top: 5),
                                  child: Text(
                                    'Actualiser les offres',
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 18.0,
                                      color: primaryTextColorLight,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.09,
                              ),
                              Padding(
                                  padding: EdgeInsets.only(left: 10, top: 5),
                                  child: Container(
                                    width: 50,
                                    decoration: BoxDecoration(
                                      color: backgroundWhite,
                                      image: DecorationImage(
                                        image: ExactAssetImage(
                                            'assets/images/icon-7.png'),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    child: Center(
                                      child: IconButton(
                                          icon: Icon(
                                            Icons.arrow_forward_ios,
                                            color: Colors.purpleAccent,
                                            size: 10.0,
                                          ),
                                          onPressed: () {}),
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () => setState(() async {
                          String? encodeQueryParameters(
                              Map<String, String> params) {
                            return params.entries
                                .map((e) =>
                                    '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                                .join('&');
                          }

                          final Uri emailLaunchUri = Uri(
                            scheme: 'mailto',
                            path: 'jeremywebmaster031@gmail.com',
                            query: encodeQueryParameters(<String, String>{
                              'subject': 'SERVICE EN LIGNE TROUVER UN CANDIDAT!'
                            }),
                          );

                          launch(emailLaunchUri.toString());
                        }),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          width: MediaQuery.of(context).size.width - 30,
                          height: 50,
                          decoration: BoxDecoration(
                            color: backgroundWhite,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0.0, 0.0),
                                blurRadius: 20,
                                spreadRadius: -2.0,
                                color: primaryBackgroundColor,
                              ),
                            ],
                          ),
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(left: 5, top: 5),
                                child: IconButton(
                                    icon: Icon(Icons.info_outline,
                                        color: Colors.lightBlue),
                                    onPressed: () {}),
                              ),
                              Container(
                                width: 160,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 5, top: 5),
                                  child: Text(
                                    'About & help',
                                    style: TextStyle(
                                      fontFamily: 'Roboto',
                                      fontSize: 18.0,
                                      color: primaryTextColorLight,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.09,
                              ),
                              Padding(
                                  padding: EdgeInsets.only(left: 10, top: 5),
                                  child: Container(
                                    width: 50,
                                    decoration: BoxDecoration(
                                      color: backgroundWhite,
                                      image: DecorationImage(
                                        image: ExactAssetImage(
                                            'assets/images/icon-4.png'),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    child: Center(
                                      child: IconButton(
                                          icon: Icon(
                                            Icons.arrow_forward_ios,
                                            color: Colors.lightBlue,
                                            size: 10.0,
                                          ),
                                          onPressed: () {}),
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      InkWell(
                          onTap: null,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            width: MediaQuery.of(context).size.width - 30,
                            height: 60,
                            decoration: BoxDecoration(
                              color: backgroundWhite,
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Center(
                                child: Text(
                                  '© 2022 trouver-un-candidat. Tous droits réservés.',
                                  style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 12.0,
                                    color: primaryTextColorLight,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
