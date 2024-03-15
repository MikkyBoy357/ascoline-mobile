import 'package:flutter/material.dart';

class Constant {
  //static String baseUrl = 'http://192.168.10.194:3000';
  //static String baseUrl = 'http://192.168.100.57:3000';
  static String baseUrl = 'http://13.41.57.233:3000';

  static void navigatePush(BuildContext context, Widget nextScreen) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return nextScreen;
        },
      ),
    );
  }

  static void navigatePushReplacement(BuildContext context, Widget nextScreen) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) {
          return nextScreen;
        },
      ),
    );
  }
}
