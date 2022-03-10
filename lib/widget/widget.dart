// ignore_for_file: prefer_const_constructors, avoid_print
// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:tuc/constants/color.dart';

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
    return Center(
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
    );
  }
}
