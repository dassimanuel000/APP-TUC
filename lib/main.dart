// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, sized_box_for_whitespace, avoid_print, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, use_key_in_widget_constructors, must_be_immutable, unnecessary_new, override_on_non_overriding_member, deprecated_member_use, prefer_final_fields, non_constant_identifier_names, unnecessary_null_comparison

import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

import 'package:tuc/constants/color.dart';
import 'package:tuc/screens/index.dart';
import 'package:tuc/widget/widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

late SharedPreferences localStorage;
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

  //await FirebaseMessaging.instance.subscribeToTopic('news');

  SharedPreferences localStorage = await SharedPreferences.getInstance();
  var uid = localStorage.getString('uid');
  runApp(MaterialApp(
    home: uid == null ? MyApp() : RootPage(),
  ));

  //runApp(MyApp());
}

class MyApp extends StatelessWidget {
  String uid = '';

  /*_loadCounter() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    uid = (localStorage.getString('uid') ?? '');
    return uid;
  }*/

  //Future<SharedPreferences> localStorage = SharedPreferences.getInstance();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trouver un candidat',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: 'Trouver un candidat'),
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
                icon: '@mipmap/ic_launcher',
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
              img: Icons.group_rounded,
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
              text: ' Get Started ',
              backgroundColor: mButtonEmailColor,
              textColor: mBackgroundColor,
            ),
            SizedBox(
              height: 16,
            ),
            RoundedButton(
              img: Icons.admin_panel_settings_sharp,
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
              text: ' Se Faire Reférencer ',
              backgroundColor: mButtonFacebookColor,
              textColor: Colors.white,
            ),
            SizedBox(
              height: 16,
            ),
            RoundedButton(
              img: Icons.wifi_tethering_error,
              press: () {
                _launchURL(
                    "mailto:jeremywebmaster031@gmail.com?subject=Password forgot ");
              },
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
                Changelanguage(context);
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
      appBar: navigatorpop(context),
      backgroundColor: Color(
          0xffffffff), //you can paste your custom code color, but this one is for demo purpose,
      body: ListView(
        padding: EdgeInsets.all(12),
        physics: BouncingScrollPhysics(), //use this for a bouncing experience
        children: [
          Container(height: 35),
          userTile(),
          divider(),
          colorTiles(),
          divider(),
          bwTiles(),
        ],
      ),
      // floatingActionButton: fab(),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget userTile() {
    //I use pixabay.com & unsplash.com for most of the time.
    return ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage("https://i.ibb.co/HdgCQVN/iconB.png"),
        ),
        title: Text(
          "Equipe Trouver un candidat",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          "Service en ligne",
          style: TextStyle(fontWeight: FontWeight.bold),
        ));
  }

  Widget divider() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Divider(
        thickness: 1.5,
      ),
    );
  }

  Widget colorTiles() {
    return Column(
      children: [
        colorTile(Icons.mail_outline, Colors.deepPurple, () {
          String? encodeQueryParameters(Map<String, String> params) {
            return params.entries
                .map((e) =>
                    '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                .join('&');
          }

          final Uri emailLaunchUri = Uri(
            scheme: 'mailto',
            path: 'contact@trouver-un-candidat.com',
            query: encodeQueryParameters(
                <String, String>{'subject': 'Me faire référencer !'}),
          );

          launch(emailLaunchUri.toString());
        }, "Contactez par mail"),
        colorTile(Icons.phone_iphone, Colors.blue, () {
          launch("tel://0768128023");
        }, "Contactez par Télephone"),
        colorTile(Icons.security_outlined, Colors.pink, () {
          _launchURL("https://trouver-un-candidat.com/me-faire-referencer/");
        }, "S'inscrire"),
        colorTile(Icons.favorite_border, Colors.orange, () {
          _launchURL("https://trouver-un-candidat.com/terms/");
        }, "Mentions Légales"),
      ],
    );
  }

  Widget bwTiles() {
    // Color color = Colors.blueGrey.shade800; not satisfied, so let us pick it
    return Column(
      children: [
        bwTile(Icons.info_outline, "Admin login", () {
          _launchURL("https://trouver-un-candidat.com/wp-login.php");
        }),
      ],
    );
  }

//only for ease of understanding, other wise you can use colorTile Directly,
// in my preference, i split the widgets into as many chunks as possible

  Widget bwTile(IconData icon, String text, VoidCallback calls) {
    return colorTile(icon, Colors.black, calls, text, blackAndWhite: true);
  }

  Widget colorTile(IconData icon, Color color, VoidCallback call, String text,
      {bool blackAndWhite = false}) {
    Color pickedColor = Color(0xfff3f4fe);
    return InkWell(
      onTap: call,
      child: ListTile(
        leading: Container(
          child: Icon(icon, color: color),
          height: 45,
          width: 45,
          decoration: BoxDecoration(
            color: blackAndWhite ? pickedColor : color.withOpacity(0.09),
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        title: Text(
          text,
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        trailing: Icon(Icons.arrow_forward_ios, color: Colors.black, size: 20),
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

Future<void> saveTokenToDatabase(String token) async {
  // Assume user is logged in for this example
  String userId = FirebaseAuth.instance.currentUser!.uid;

  await FirebaseFirestore.instance.collection('users').doc(userId).update({
    'tokens': FieldValue.arrayUnion([token]),
  });
}

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginPage();
  }
}

class _LoginPage extends State<LoginPage> {
  late String _token;
  late String errormsg;
  late bool error, showprogress;
  late String user_login, user_pass;

  var _username = TextEditingController();
  var _password = TextEditingController();

  static Future init() async {
    localStorage = await SharedPreferences.getInstance();
  }

  startLogin() async {
    // Get the token each time the application loads
    /*String? _token = await FirebaseMessaging.instance.getToken();

    String apiurl = "https://trouver-un-candidat.com/test/login.php"; //api url
    //dont use http://localhost , because emulator don't get that address
    //insted use your local IP address or use live URL
    //hit "ipconfig" in windows or "ip a" in linux to get you local IP
    print(user_login);

    var response = await http.post(Uri.parse(apiurl), body: {
      'user_login': user_login, //get the user_login text
      'user_pass': user_pass //get user_pass text
    });*/
    var url =
        'https://trouver-un-candidat.com/test/login.php?user=${_password.text}&${_username.text}';
    var response = await http.get(Uri.parse(url));

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
          String uid = jsondata["uid"];
          String user_login = jsondata["user_login"];
          String user_email = jsondata["user_email"];
          print(user_login + user_email + uid);
          await init();

          localStorage.setString('uid', uid.toString());
          localStorage.setString('user_email', user_email.toString());
          localStorage.setString('user_login', user_login.toString());
          if (localStorage != null) print(localStorage.get('uid'));
          await FirebaseMessaging.instance.subscribeToTopic('${uid}');
          SuccesLogin(context);
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
              "Se Connecter avec votre identifiant et votre mail",
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
              obscureText: false,
              decoration: myInputDecoration(
                  label: "Identifiant", icon: Icons.security_outlined),
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
                  findID(context);
                },
                child: Text(
                  "Où trouver son identifiant et son mail ?",
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
          TextStyle(color: mPrimaryTextColor, fontSize: 20), //hint text style
      prefixIcon: Padding(
          padding: EdgeInsets.only(left: 20, right: 10),
          child: Icon(
            icon,
            color: mButtonFacebookColor,
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

      fillColor: mBackgroundColor,
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

Changelanguage(context) async {
  return showDialog(
      context: context,
      builder: (context) {
        return Center(
            child: Material(
                type: MaterialType.transparency,
                child: Container(
                  height: 250.0,
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)),
                  child: ListView(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, top: 10),
                        child: Text(
                          'Change language',
                          style: TextStyle(
                              color: Colors.black26,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Open",
                              fontSize: 16),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 20, top: 10, right: 20),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                            showAlertDialog;
                          },
                          child: Container(
                            height: 46,
                            width: MediaQuery.of(context).size.width * 0.7,
                            decoration: BoxDecoration(
                                color: mButtonFacebookColor,
                                borderRadius: BorderRadius.circular(5)),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text(
                                'Français ( Fr )',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Open",
                                    fontSize: 16),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )));
      });
}

findID(context) async {
  return showDialog(
      context: context,
      builder: (context) {
        return Center(
            child: Material(
                type: MaterialType.transparency,
                child: Container(
                  height: 250.0,
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)),
                  child: ListView(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, top: 10),
                        child: Text(
                          'Votre boîte Mail',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Open",
                              fontSize: 16),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 20, top: 10, right: 20),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text(
                                  "Après votre bilan de compétence et votre inscription sur la plateforme Trouver un candidat, Vous avez reçu un mail avec votre Identifiant ( Utilisez l'adresse mail sur laquelle vous avez reçu le mail d'inscription )",
                                  style: TextStyle(
                                      color: mPrimaryTextColor,
                                      fontWeight: FontWeight.normal,
                                      fontFamily: "Open",
                                      fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )));
      });
}

SuccesLogin(context) async {
  return showDialog(
      context: context,
      builder: (context) {
        return Center(
            child: Material(
                type: MaterialType.transparency,
                child: Container(
                  height: 250.0,
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)),
                  child: ListView(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, top: 10),
                        child: Text(
                          ' ',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Open",
                              fontSize: 16),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 20, top: 10, right: 20),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Column(
                            children: [
                              Container(
                                height: 150,
                                width: double.infinity,
                                decoration: new BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: backgroundWhite,
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        'https://i.ibb.co/bvb7zw1/success.gif'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              TextButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty
                                        .resolveWith<Color?>(
                                      (Set<MaterialState> states) {
                                        if (states
                                            .contains(MaterialState.pressed))
                                          return Theme.of(context)
                                              .colorScheme
                                              .primary
                                              .withOpacity(0.5);
                                        return successColor; // Use the component's default.
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
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                OnboardingScreen()));
                                  },
                                  child: Text(
                                    'Vous êtes connecté(e), Continuez',
                                    style: TextStyle(color: mBackgroundColor),
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )));
      });
}

showAlertDialog(BuildContext context) {
  // set up the button
  Widget okButton = TextButton(
    child: Text("OK"),
    onPressed: () {},
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Modifications"),
    content: Text("Demande de modifications validé."),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
