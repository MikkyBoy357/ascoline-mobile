import 'dart:async';

import 'package:flutter/material.dart';

import '../utils/page_view_widget.dart';

class SplashScreen extends StatefulWidget {
  final dynamic value;
  final dynamic onChanged;
  final dynamic isDark;

  const SplashScreen({Key? key, this.onChanged, this.value, this.isDark})
      : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTimeOut() {
    return Timer(const Duration(seconds: 5), navigate);
  }

  void navigate() {
    changeScreen();
  }

  changeScreen() {
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) {
      return const PageViewWidget();
    }), (route) => false);
  }

  @override
  void initState() {
    startTimeOut();
    super.initState();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image(
              image: AssetImage('assets/splashimage.png'),
            ),
          ),
        ],
      ),
    );
  }
}
