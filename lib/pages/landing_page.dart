import 'dart:convert';

import 'package:ascolin/base/token.dart';
import 'package:ascolin/model/token_model.dart';
import 'package:ascolin/model/user_model.dart';
import 'package:ascolin/pages/main_screen.dart';
import 'package:ascolin/pages/sign_in_page.dart';
import 'package:ascolin/view_model/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  void initState() {
    // TODO: implement initState

    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);

    storage.read(key: 'user').then((valueUser) {
      if (valueUser == null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) {
              return SignInPage();
            },
          ),
        );
      } else {
        authViewModel.userData = UserModel.fromJson(jsonDecode(valueUser));
        storage.read(key: 'token').then((valueToken) {
          if (valueToken != null) {
            authViewModel.tokenData =
                TokenModel.fromJson(jsonDecode(valueToken));
          }
        });
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) {
              return MainScreen();
            },
          ),
        );
      }
    }).catchError((onError) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return SignInPage();
          },
        ),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Consumer<AuthViewModel>(
      builder: (context, authViewModel, _) {
        return Scaffold(
          body: Container(
            height: height,
            width: width,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }
}
