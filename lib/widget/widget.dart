// ignore_for_file: prefer_const_constructors, avoid_print, unused_element, prefer_const_literals_to_create_immutables

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tuc/constants/color.dart';
import 'package:tuc/screens/dashboard.dart';

import 'package:flutter/services.dart';
import 'dart:math';

import 'package:provider/provider.dart';

import '../main.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    Key? key,
    required this.text,
    required this.backgroundColor,
    required this.textColor,
    required this.press,
    required this.img,
  }) : super(key: key);

  final String text;
  final Color backgroundColor;
  final Color textColor;
  final VoidCallback press;
  final IconData img;

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return FlatButton(
      onPressed: press,
      color: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Container(
          padding: EdgeInsets.symmetric(vertical: 16),
          alignment: Alignment.center,
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                img,
                color: Colors.white,
                size: 20.0,
              ),
              Text(
                '$text',
                style: TextStyle(
                  color: textColor,
                ),
              ),
            ],
          )),
    );
  }
}

class RoundedInput extends StatelessWidget {
  const RoundedInput({
    Key? key,
    required this.hintText,
    this.suffixText = '',
  }) : super(key: key);

  final String hintText;
  final String suffixText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
        hintText: hintText,
        hintStyle: TextStyle(color: mPrimaryTextColor),
        suffixText: suffixText,
        suffixStyle: TextStyle(
            color: mPrimaryColor,
            fontSize: 12,
            fontFamily: 'Montserrat-Medium'),
        border: UnderlineInputBorder(
          borderSide: BorderSide(
            color: mBorderColor,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: mBorderColor,
          ),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: mBorderColor,
          ),
        ),
      ),
    );
  }
}

class HaveAccount extends StatelessWidget {
  const HaveAccount({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => LoginPage()));
      },
      child: Center(
        child: RichText(
          text: TextSpan(
              style: TextStyle(
                color: mPrimaryTextColor,
              ),
              children: [
                TextSpan(text: 'Already have an account?'),
                TextSpan(
                  text: ' Log in',
                  style: TextStyle(color: mPrimaryColor),
                ),
              ]),
        ),
      ),
    );
  }
}

AppBar navigatorpop(BuildContext context) {
  return AppBar(
    backgroundColor: mBackgroundColor,
    elevation: 0,
    leading: InkWell(
      child: Icon(
        Icons.arrow_back_ios,
        color: Colors.black87,
      ),
      onTap: () {
        Navigator.pop(context);
      },
    ),
    centerTitle: false,
    automaticallyImplyLeading: false,
    actions: <Widget>[],
  );
}

class ProgressLife extends StatefulWidget {
  @override
  _ProgressLifeState createState() => _ProgressLifeState();
}

class _ProgressLifeState extends State<ProgressLife> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ColorLoader3(
              radius: 15.0,
              dotRadius: 6.0,
            ),
            SizedBox(
              width: 20,
            ),
            Container(
              height: 120,
              width: 120,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: ExactAssetImage('assets/images/ic_launcher.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Text("0"),
            ),
          ],
        ),
      ),
    );
  }
}

class Success extends StatefulWidget {
  @override
  _SuccessState createState() => _SuccessState();
}

final PageController _pageController = PageController(initialPage: 0);

class _SuccessState extends State<Success> {
  @override
  Widget build(BuildContext context) {
    final appStyleMode = Provider.of<AppStyleModeNotifier>(context);
    return Scaffold(
        backgroundColor: appStyleMode.primaryTextColor,
        body: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light,
            child: ListView(
              children: [
                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(0.0),
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: appStyleMode.backgroundWhite,
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0.0, 0.0),
                                blurRadius: 20,
                                spreadRadius: -2.0,
                                color: appStyleMode.primaryBackgroundColor,
                              ),
                            ],
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: IconButton(
                                icon: Icon(Icons.menu,
                                    color: appStyleMode.primaryTextColorDark),
                                onPressed: () {}),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(0.0),
                        child: Container(
                          child: Image(
                            image: AssetImage('assets/images/logo.png'),
                            height: 60.0,
                            width: 150.0,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(0.0),
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: appStyleMode.backgroundWhite,
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0.0, 0.0),
                                blurRadius: 20,
                                spreadRadius: -2.0,
                                color: appStyleMode.primaryBackgroundColor,
                              ),
                            ],
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: IconButton(
                                icon: Icon(Icons.person_pin,
                                    color: appStyleMode.primaryTextColorDark),
                                onPressed: () {}),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                    decoration: BoxDecoration(
                      color: appStyleMode.backgroundWhite,
                    ),
                    child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 40.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.80,
                                  child: PageView(
                                      physics: ClampingScrollPhysics(),
                                      controller: _pageController,
                                      onPageChanged: (int page) {},
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.all(40.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Center(
                                                child: Image(
                                                  image: AssetImage(
                                                    'assets/images/icon_success.png',
                                                  ),
                                                  height: 230.0,
                                                  width: 260.0,
                                                ),
                                              ),
                                              SizedBox(height: 5.0),
                                              Center(
                                                child: Text(
                                                  'Votre Commande est bien envoye',
                                                  style: kTitleStyle,
                                                ),
                                              ),
                                              SizedBox(height: 15.0),
                                              Center(
                                                child: Text(
                                                  'Vous allez recevoir un appel et message de Life CM',
                                                  style: kTitleStyle,
                                                ),
                                              ),
                                              Center(
                                                child: InkWell(
                                                  onTap: () {
                                                    Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    Dashboard(
                                                                      title: '',
                                                                    )));
                                                  },
                                                  child: Container(
                                                    height: 40,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.7,
                                                    decoration: BoxDecoration(
                                                      color: appStyleMode
                                                          .primaryMessageBoxColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          offset:
                                                              Offset(0.0, 0.0),
                                                          blurRadius: 20,
                                                          spreadRadius: -2.0,
                                                          color:
                                                              gradientStartColor,
                                                        ),
                                                      ],
                                                    ),
                                                    child: Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: IconButton(
                                                          icon: Icon(Icons.home,
                                                              color: appStyleMode
                                                                  .backgroundWhite),
                                                          onPressed: () {}),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ]))
                            ])))
              ],
            )));
  }
}

class ErrorPage extends StatefulWidget {
  @override
  _ErrorPageState createState() => _ErrorPageState();
}

class _ErrorPageState extends State<ErrorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "assets/images/14_No Search Results.png",
            fit: BoxFit.cover,
          ),
          Positioned(
              bottom: MediaQuery.of(context).size.height * 0.15,
              left: MediaQuery.of(context).size.width * 0.065,
              right: MediaQuery.of(context).size.width * 0.065,
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pop(null);
                },
                child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 13),
                          blurRadius: 25,
                          color: Color(0xFF5666C2).withOpacity(0.17),
                        ),
                      ],
                    ),
                    child: Text('Erreur de connexion ')),
              ))
        ],
      ),
    );
  }
}

class ColorLoader3 extends StatefulWidget {
  final double radius;
  final double dotRadius;

  ColorLoader3({this.radius = 30.0, this.dotRadius = 3.0});

  @override
  _ColorLoader3State createState() => _ColorLoader3State();
}

class _ColorLoader3State extends State<ColorLoader3>
    with TickerProviderStateMixin {
  late Animation<double> animation_rotation;
  late Animation<double> animation_radius_in;
  late Animation<double> animation_radius_out;
  late AnimationController controller;

  late double radius;
  late double dotRadius;

  @override
  void initState() {
    super.initState();

    radius = widget.radius;
    dotRadius = widget.dotRadius;

    print(dotRadius);

    controller = AnimationController(
        lowerBound: 0.0,
        upperBound: 1.0,
        duration: const Duration(milliseconds: 3000),
        vsync: this);

    animation_rotation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0.0, 1.0, curve: Curves.linear),
      ),
    );

    animation_radius_in = Tween(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0.75, 1.0, curve: Curves.elasticIn),
      ),
    );

    animation_radius_out = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0.0, 0.25, curve: Curves.elasticOut),
      ),
    );

    controller.addListener(() {
      setState(() {
        if (controller.value >= 0.75 && controller.value <= 1.0)
          radius = widget.radius * animation_radius_in.value;
        else if (controller.value >= 0.0 && controller.value <= 0.25)
          radius = widget.radius * animation_radius_out.value;
      });
    });

    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {}
    });

    controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.0,
      height: 100.0,
      //color: Colors.black12,
      child: new Center(
        child: new RotationTransition(
          turns: animation_rotation,
          child: new Container(
            //color: Colors.limeAccent,
            child: new Center(
              child: Stack(
                children: <Widget>[
                  new Transform.translate(
                    offset: Offset(0.0, 0.0),
                    child: Dot(
                      radius: radius,
                      color: Colors.black12,
                    ),
                  ),
                  new Transform.translate(
                    child: Dot(
                      radius: dotRadius,
                      color: Colors.amber,
                    ),
                    offset: Offset(
                      radius * cos(0.0),
                      radius * sin(0.0),
                    ),
                  ),
                  new Transform.translate(
                    child: Dot(
                      radius: dotRadius,
                      color: Colors.deepOrangeAccent,
                    ),
                    offset: Offset(
                      radius * cos(0.0 + 1 * pi / 4),
                      radius * sin(0.0 + 1 * pi / 4),
                    ),
                  ),
                  new Transform.translate(
                    child: Dot(
                      radius: dotRadius,
                      color: Colors.pinkAccent,
                    ),
                    offset: Offset(
                      radius * cos(0.0 + 2 * pi / 4),
                      radius * sin(0.0 + 2 * pi / 4),
                    ),
                  ),
                  new Transform.translate(
                    child: Dot(
                      radius: dotRadius,
                      color: Colors.purple,
                    ),
                    offset: Offset(
                      radius * cos(0.0 + 3 * pi / 4),
                      radius * sin(0.0 + 3 * pi / 4),
                    ),
                  ),
                  new Transform.translate(
                    child: Dot(
                      radius: dotRadius,
                      color: Colors.yellow,
                    ),
                    offset: Offset(
                      radius * cos(0.0 + 4 * pi / 4),
                      radius * sin(0.0 + 4 * pi / 4),
                    ),
                  ),
                  new Transform.translate(
                    child: Dot(
                      radius: dotRadius,
                      color: Colors.lightGreen,
                    ),
                    offset: Offset(
                      radius * cos(0.0 + 5 * pi / 4),
                      radius * sin(0.0 + 5 * pi / 4),
                    ),
                  ),
                  new Transform.translate(
                    child: Dot(
                      radius: dotRadius,
                      color: Colors.orangeAccent,
                    ),
                    offset: Offset(
                      radius * cos(0.0 + 6 * pi / 4),
                      radius * sin(0.0 + 6 * pi / 4),
                    ),
                  ),
                  new Transform.translate(
                    child: Dot(
                      radius: dotRadius,
                      color: Colors.blueAccent,
                    ),
                    offset: Offset(
                      radius * cos(0.0 + 7 * pi / 4),
                      radius * sin(0.0 + 7 * pi / 4),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
        DiagnosticsProperty<AnimationController>('controller', controller));
  }
}

class Dot extends StatelessWidget {
  final double radius;
  final Color color;

  Dot({required this.radius, required this.color});

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: Container(
        width: radius,
        height: radius,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ),
    );
  }
}
