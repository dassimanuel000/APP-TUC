// ignore_for_file: prefer_const_constructors

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tuc/constants/color.dart';
import 'package:tuc/screens/onboarding.dart';
import 'package:tuc/screens/signup_screen.dart';
import 'package:tuc/widget/widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

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
            Text(
              'Trouver le candidat idéal ',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: mButtonEmailColor,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat'),
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
                      return SignupScreen();
                    },
                  ),
                );
              },
              text: '  Sign up with Google',
              backgroundColor: mButtonEmailColor,
              textColor: mBackgroundColor,
            ),
            SizedBox(
              height: 16,
            ),
            RoundedButton(
              img: Icons.facebook_rounded,
              press: () {},
              text: '  Sign up with Facebook',
              backgroundColor: mButtonFacebookColor,
              textColor: Colors.white,
            ),
            SizedBox(
              height: 16,
            ),
            RoundedButton(
              img: Icons.admin_panel_settings_sharp,
              press: () {},
              text: '  Sign up with Apple',
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
                // handle the press
              },
            ),
          ],
        )
      ],
    );
  }
}
