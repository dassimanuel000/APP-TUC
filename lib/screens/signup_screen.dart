// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:tuc/constants/color.dart';
import 'package:tuc/widget/widget.dart';

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
