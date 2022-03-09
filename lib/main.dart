// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuc/constants/color.dart';
import 'package:tuc/screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      child: MaterialApp(
        title: 'Trouver un candidat',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            scaffoldBackgroundColor: mBackgroundColor,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            fontFamily: 'Montserrat'),
        home: HomeScreen(),
      ),
      create: (context) => AppStyleModeNotifier(),
    );
  }
}
