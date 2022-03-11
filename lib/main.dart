// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, sized_box_for_whitespace, avoid_print, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, use_key_in_widget_constructors, must_be_immutable, unnecessary_new, override_on_non_overriding_member, deprecated_member_use, prefer_final_fields, non_constant_identifier_names

import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;

import 'package:tuc/constants/color.dart';
import 'package:tuc/screens/index.dart';
import 'package:tuc/widget/widget.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    'This channel is used for important notifications.', // description
    importance: Importance.high,
    playSound: true);

// flutter local notification
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

// firebase background message handler
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('A Background message just showed up :  ${message.messageId}');
}

Future<void> main() async {
  // firebase App initialize
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

// Firebase local notification plugin
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

//Firebase messaging
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Push Notification',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: 'Flutter Push Notification'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  @override
  void initState() {
    super.initState();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channel.description,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_lancher',
              ),
            ));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new messageopen app event was published');
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text("${notification.title}"),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text("${notification.body}")],
                  ),
                ),
              );
            });
      }
    });
  }

  void showNotification() {
    setState(() {
      _counter++;
    });

    flutterLocalNotificationsPlugin.show(
        0,
        "Testing $_counter",
        "This is an Flutter Push Notification",
        NotificationDetails(
            android: AndroidNotificationDetails(
                channel.id, channel.name, channel.description,
                importance: Importance.high,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      backgroundColor: mBackgroundColor,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.width / 5,
            ),
            Container(
                decoration: BoxDecoration(),
                height: MediaQuery.of(context).size.height / 8,
                child: Image.asset('assets/images/logo.png')),
            SizedBox(
              height: MediaQuery.of(context).size.width / 100,
            ),
            SizedBox(
              height: 10.0,
            ),
            Center(
              child: Text(
                'Trouver le candidat idéal ',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: mButtonEmailColor,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat'),
              ),
            ),
            SizedBox(
              height: (MediaQuery.of(context).size.height / 6),
            ),
            RoundedButton(
              img: Icons.g_mobiledata_outlined,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginPage();
                    },
                  ),
                );
              },
              text: ' Sign in ',
              backgroundColor: mButtonEmailColor,
              textColor: mBackgroundColor,
            ),
            SizedBox(
              height: 16,
            ),
            RoundedButton(
              img: Icons.facebook_rounded,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignupScreen();
                    },
                  ),
                );
              },
              text: '  Sign up  ',
              backgroundColor: mButtonFacebookColor,
              textColor: Colors.white,
            ),
            SizedBox(
              height: 16,
            ),
            RoundedButton(
              img: Icons.admin_panel_settings_sharp,
              press: () {},
              text: ' Password forgot ?',
              backgroundColor: mButtonAppleColor,
              textColor: Colors.white,
            ),
            SizedBox(
              height: 16,
            ),
            HaveAccount()
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: mBackgroundColor,
      elevation: 0,
      centerTitle: false,
      automaticallyImplyLeading: false,
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => OnboardingScreen()));
              },
              child: Text(
                "Skip",
                style: TextStyle(
                    fontFamily: 'Montserrat',
                    color: mButtonAppleColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              width: 5,
            ),
            IconButton(
              icon: const Icon(Icons.language),
              tooltip: 'Change language',
              color: mButtonAppleColor,
              onPressed: () {
                showNotification;
              },
            ),
          ],
        )
      ],
    );
  }
}

class SignupScreen extends StatelessWidget {
  double sizeboz = 16.0;

  SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      backgroundColor: mBackgroundColor,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Let\'s do some Adventure',
              style: TextStyle(
                color: mPrimaryTextColor,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: sizeboz,
            ),
            Text(
              "Create an account to get started",
            ),
            SizedBox(
              height: 36,
            ),
            RoundedInput(
              hintText: 'Name',
            ),
            SizedBox(
              height: 16,
            ),
            RoundedInput(
              hintText: 'Email',
            ),
            SizedBox(
              height: 16,
            ),
            RoundedInput(hintText: 'Password', suffixText: 'SHOW'),
            SizedBox(
              height: 16,
            ),
            Row(
              children: <Widget>[
                Checkbox(value: false, onChanged: (value) {}),
                Text('I accept the Terms of Use')
              ],
            ),
            SizedBox(
              height: 36,
            ),
            RoundedButton(
              img: Icons.arrow_forward_ios_rounded,
              press: () {},
              backgroundColor: mPrimaryColor,
              text: 'Sign up',
              textColor: Colors.white,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 50),
              child: Text(
                'By continuing, you agree to accept our Privacy Policy & Terms of Service',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width / 100,
            ),
            HaveAccount(),
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: mBackgroundColor,
      elevation: 0,
      centerTitle: false,
      automaticallyImplyLeading: false,
      title: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Icon(
          Icons.arrow_back_ios_rounded,
          color: mPrimaryTextColor,
          size: 24.0,
          semanticLabel: 'Back',
        ),
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginPage();
  }
}

class _LoginPage extends State<LoginPage> {
  late String errormsg;
  late bool error, showprogress;
  late String user_login, user_pass;

  var _username = TextEditingController();
  var _password = TextEditingController();

  startLogin() async {
    String apiurl = "https://trouver-un-candidat.com/test/login.php"; //api url
    //dont use http://localhost , because emulator don't get that address
    //insted use your local IP address or use live URL
    //hit "ipconfig" in windows or "ip a" in linux to get you local IP
    print(user_login);

    var response = await http.post(Uri.parse(apiurl), body: {
      'user_login': user_login, //get the user_login text
      'user_pass': user_pass //get user_pass text
    });

    if (response.statusCode == 200) {
      var jsondata = json.decode(response.body);
      if (jsondata["error"]) {
        setState(() {
          showprogress = false; //don't show progress indicator
          error = true;
          errormsg = jsondata["message"];
        });
      } else {
        if (jsondata["success"]) {
          setState(() {
            error = false;
            showprogress = false;
          });
          //save the data returned from server
          //and navigate to home page
          String uid = jsondata["ID"];
          String user_login = jsondata["user_login"];
          String user_email = jsondata["user_email"];
          print(user_login + user_email + uid);
          //user shablueAccent preference to save data
        } else {
          showprogress = false; //don't show progress indicator
          error = true;
          errormsg = "Something went wrong.";
        }
      }
    } else {
      setState(() {
        showprogress = false; //don't show progress indicator
        error = true;
        errormsg = "Error during connecting to server.";
      });
    }
  }

  @override
  void initState() {
    user_login = "";
    user_pass = "";
    errormsg = "";
    error = false;
    showprogress = false;

    //_username.text = "defaulttext";
    //_password.text = "defaultpassword";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Container(
        constraints:
            BoxConstraints(minHeight: MediaQuery.of(context).size.height
                //set minimum height equal to 100% of VH
                ),
        width: MediaQuery.of(context).size.width,
        //make width of outer wrapper to 100%
        decoration: BoxDecoration(
          color: Colors.lightBlue,
        ), //show linear gradient background of page

        padding: EdgeInsets.all(20),
        child: Column(children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 80),
            child: Text(
              "Login trouver Un Candidat",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold),
            ), //title text
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Text(
              "Sign In using Email and Password",
              style: TextStyle(color: Colors.white, fontSize: 15),
            ), //subtitle text
          ),
          Container(
            //show error message here
            margin: EdgeInsets.only(top: 30),
            padding: EdgeInsets.all(10),
            child: error ? errmsg(errormsg) : Container(),
            //if error == true then show error message
            //else set empty container as child
          ),
          Container(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            margin: EdgeInsets.only(top: 10),
            child: TextField(
              controller: _username, //set user_login controller
              style: TextStyle(color: Colors.blue[100], fontSize: 20),
              decoration: myInputDecoration(
                label: "Email",
                icon: Icons.person,
              ),
              onChanged: (value) {
                //set user_login  text on change
                user_login = value;
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: _password, //set user_pass controller
              style: TextStyle(color: Colors.blue[100], fontSize: 20),
              obscureText: true,
              decoration: myInputDecoration(
                label: "Password",
                icon: Icons.lock,
              ),
              onChanged: (value) {
                // change user_pass text
                user_pass = value;
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.only(top: 20),
            child: SizedBox(
              height: 60,
              width: double.infinity,
              child: RaisedButton(
                onPressed: () {
                  setState(() {
                    //show progress indicator on click
                    showprogress = true;
                  });
                  startLogin();
                },
                child: showprogress
                    ? SizedBox(
                        height: 30,
                        width: 30,
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.blue[100],
                          valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.lightBlueAccent),
                        ),
                      )
                    : Text(
                        "LOGIN NOW",
                        style: TextStyle(fontSize: 20),
                      ),
                // if showprogress == true then show progress indicator
                // else show "LOGIN NOW" text
                colorBrightness: Brightness.dark,
                color: Colors.blue,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)
                    //button corner radius
                    ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.only(top: 20),
            child: InkResponse(
                onTap: () {
                  //action on tap
                },
                child: Text(
                  "Forgot Password? Troubleshoot",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                )),
          )
        ]),
      )),
    );
  }

  InputDecoration myInputDecoration({String? label, IconData? icon}) {
    return InputDecoration(
      hintText: label, //show label as placeholder
      hintStyle:
          TextStyle(color: Colors.blue[100], fontSize: 20), //hint text style
      prefixIcon: Padding(
          padding: EdgeInsets.only(left: 20, right: 10),
          child: Icon(
            icon,
            color: Colors.blue[100],
          )
          //padding and icon for prefix
          ),

      contentPadding: EdgeInsets.fromLTRB(30, 20, 30, 20),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
              color: Colors.blue[300]!, width: 1)), //default border of input

      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide:
              BorderSide(color: Colors.blue[200]!, width: 1)), //focus border

      fillColor: Color.fromRGBO(251, 140, 0, 0.5),
      filled: true, //set true if you want to show input background
    );
  }

  Widget errmsg(String text) {
    //error message widget.
    return Container(
      padding: EdgeInsets.all(15.00),
      margin: EdgeInsets.only(bottom: 10.00),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.red,
          border: Border.all(color: Colors.red[300]!, width: 2)),
      child: Row(children: <Widget>[
        Container(
          margin: EdgeInsets.only(right: 6.00),
          child: Icon(Icons.info, color: Colors.white),
        ), // icon for error message

        Text(text, style: TextStyle(color: Colors.white, fontSize: 18)),
        //show error message text
      ]),
    );
  }
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  PageController pageController = new PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
            child: PageView(
                controller: pageController,
                physics: NeverScrollableScrollPhysics(),
                children: [
              Slide(
                  hero: Image.asset(
                    "./assets/images/hero-1.png",
                    height: 395,
                    width: 340,
                  ),
                  title: "Recrutement de proximité",
                  subtitle: "Trouvez le candidat qui vous correspond",
                  onNext: nextPage),
              Slide(
                  hero: Image.asset(
                    "./assets/images/hero-2.png",
                    height: 395,
                    width: 340,
                  ),
                  title: "Explorez des milliers d'offres",
                  subtitle:
                      "Comment trouver l'offre qui correspond à vos attentes ? ",
                  onNext: nextPage),
              Slide(
                  hero: Image.asset(
                    "./assets/images/hero-3.png",
                    height: 395,
                    width: 340,
                  ),
                  title: "Se Faire Référencer",
                  subtitle:
                      "Bénéficiez de la meilleure visibilité en ligne grâce à un référencement naturel ",
                  onNext: nextPage),
              Scaffold(
                backgroundColor: Colors.white,
                body: Center(
                    child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 10,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.width / 3,
                      child: Image.asset("assets/images/logo.png"),
                    ),
                    SizedBox(
                      height: 12.0,
                    ),
                    Text(
                      'Recevez des offres qui vous correspondent dans votre localisation',
                      style: kTitleStyle,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => OnboardingScreen()));
                      },
                      child: Text(
                        'Back',
                        style: kSubtitleStyle,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: ProgressButton(
                        onNext: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => RootPage()));
                        },
                      ),
                    )
                  ],
                )),
              )
            ])),
      ),
    );
  }

  void nextPage() {
    pageController.nextPage(
        duration: const Duration(milliseconds: 200), curve: Curves.ease);
  }
}

class Slide extends StatelessWidget {
  final Widget hero;
  final String title;
  final String subtitle;
  final VoidCallback onNext;

  const Slide(
      {Key? key,
      required this.hero,
      required this.title,
      required this.subtitle,
      required this.onNext})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: hero),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Text(
                  title,
                  style: kTitleStyle,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  subtitle,
                  style: kSubtitleStyle,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 35,
                ),
                ProgressButton(onNext: onNext),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => RootPage()));
            },
            child: Text(
              "Skip",
              style: kSubtitleStyle,
            ),
          ),
          SizedBox(
            height: 4,
          )
        ],
      ),
    );
  }
}

class ProgressButton extends StatelessWidget {
  final VoidCallback onNext;
  const ProgressButton({Key? key, required this.onNext}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 75,
      height: 75,
      child: Stack(children: [
        AnimatedIndicator(
          duration: const Duration(seconds: 10),
          size: 75,
          callback: onNext,
        ),
        Center(
          child: GestureDetector(
            child: Container(
              height: 60,
              width: 60,
              child: Center(
                  child: Padding(
                padding: EdgeInsets.all(1.0),
                child: Icon(
                  Icons.arrow_forward_ios,
                  size: 30,
                  color: Colors.white,
                ),
              )),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(99),
                  color: mButtonEmailColor),
            ),
            onTap: onNext,
          ),
        )
      ]),
    );
  }
}

class AnimatedIndicator extends StatefulWidget {
  final Duration duration;
  final double size;
  final VoidCallback callback;
  const AnimatedIndicator(
      {Key? key,
      required this.duration,
      required this.size,
      required this.callback})
      : super(key: key);

  @override
  _AnimatedIndicatorState createState() => _AnimatedIndicatorState();
}

class _AnimatedIndicatorState extends State<AnimatedIndicator>
    with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(duration: widget.duration, vsync: this);
    animation = Tween(begin: 0.0, end: 100.0).animate(controller)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.reset();
          widget.callback();
        }
      });
    controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: animation,
        builder: (context, child) {
          return CustomPaint(
              size: Size(widget.size, widget.size),
              painter: ProgressPainter(animation.value));
        });
  }
}

class ProgressPainter extends CustomPainter {
  final double progress;
  ProgressPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    // setup
    var linePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..color = mButtonEmailColor;

    var circlePaint = Paint()
      ..style = PaintingStyle.fill
      ..color = mButtonEmailColor;

    final radians = (progress / 100) * 2 * pi;
    _drawArc(canvas, linePaint, circlePaint, -pi / 2, radians, size);
  }

  void _drawArc(
    Canvas canvas,
    Paint linePaint,
    Paint circlePaint,
    double startRadian,
    double sweepRadian,
    Size size,
  ) {
    final centerX = size.width / 2, centerY = size.height / 2;
    final centerOffset = Offset(centerX, centerY);
    final double radius = min(size.width, size.height) / 2;

    canvas.drawArc(Rect.fromCircle(center: centerOffset, radius: radius),
        startRadian, sweepRadian, false, linePaint);

    final x = radius * (1 + sin(sweepRadian)),
        y = radius * (1 - cos(sweepRadian));
    final circleOffset = Offset(x, y);
    canvas.drawCircle(circleOffset, 5, circlePaint);
  }

  @override
  bool shouldRepaint(CustomPainter old) => true;
}
