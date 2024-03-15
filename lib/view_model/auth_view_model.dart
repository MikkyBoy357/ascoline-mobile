import 'dart:convert';

import 'package:ascolin/base/api_service.dart';
import 'package:ascolin/base/constant.dart';
import 'package:ascolin/model/token_model.dart';
import 'package:ascolin/model/user_model.dart';
import 'package:ascolin/pages/main_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../widgets/error_dialog.dart';

class AuthViewModel extends ChangeNotifier {
  late UserModel userData;
  late TokenModel tokenData;

  var api = ApiService();
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  // SignUp
  String firstName = '';
  String lastName = '';
  String phoneNumber = '';
  String emailAddress = '';
  String password = '';

  // Login
  String lEmail = '';
  String lPassword = '';

  void setLEmail(String val) {
    lEmail = val;
    notifyListeners();
  }

  void setLPassword(String val) {
    lPassword = val;
    notifyListeners();
  }

  void setFirstName(String val) {
    firstName = val;
    print(val);
    notifyListeners();
  }

  void setLastName(String val) {
    lastName = val;
    notifyListeners();
  }

  void setPhoneNumber(String val) {
    phoneNumber = val;
    notifyListeners();
  }

  void setEmailAddress(String val) {
    emailAddress = val;
    notifyListeners();
  }

  void setPassword(String val) {
    password = val;
    notifyListeners();
  }

  Future<void> signUp(
      BuildContext context, GlobalKey<FormState> signupFormKey) async {
    if ((signupFormKey.currentState?.validate() ?? false) == false) {
      print("Invalid Fields");
      return showDialog(
        context: context,
        builder: (context) {
          return ErrorDialog(
            text: 'Invalid Text Fields',
          );
        },
      );
    }

    try {
      // Replace this with your actual API endpoint
      String apiUrl = '/auth/signup';

      print(apiUrl);

      final Map<String, dynamic> data = {
        'email': emailAddress,
        'password': password,
        'type': 'client',
        'lastName': lastName,
        'firstName': firstName,
        'address': 'anything lol',
        'phone': phoneNumber,
        'status': 'actif',
      };

      final Response response = await api.dio.post(
        apiUrl,
        data: data,
      );

      if (response.statusCode == 201) {
        // Handle successful response here
        print('SignUp Successful');
        print('${response.data}');

        userData = UserModel.fromJson(response.data['user']);
        userData.password = password;
        tokenData = TokenModel.fromJson(response.data);

        await storage.write(key: 'user', value: jsonEncode(userData.toJson()));
        await storage.write(
            key: 'token', value: jsonEncode(tokenData.toJson()));

        Constant.navigatePushReplacement(context, MainScreen());
      } else {
        // Handle other status codes or errors here
        print('SignUp Failed: ${response.statusCode}');
      }
    } on DioException catch (error) {
      // Handle Dio errors or exceptions here
      print('Error occurred: $error');
      showDialog(
        context: context,
        builder: (context) {
          return ErrorDialog(
            title: "Erreur",
            text:
                "${error.response?.data['message'] ?? "Une erreur est survenue"}",
          );
        },
      );
    }
  }

  Future<void> login(
      BuildContext context, GlobalKey<FormState> loginFormKey) async {
    if ((loginFormKey.currentState?.validate() ?? false) == false) {
      print("Invalid Fields");
      return showDialog(
        context: context,
        builder: (context) {
          return ErrorDialog(
            text: 'Invalid Text Fields',
          );
        },
      );
    }

    try {
      // Replace this with your actual API endpoint for login
      final String loginUrl = '/auth/login';
      print(loginUrl);

      final Map<String, dynamic> loginData = {
        'email': lEmail,
        'password': lPassword,
      };

      final Response response = await api.dio.post(
        loginUrl,
        data: loginData,
      );

      if (response.statusCode == 200) {
        // Handle successful login response here
        print('Login Successful');
        print('${response.data}');

        userData = UserModel.fromJson(response.data['user']);
        userData.password = lPassword;
        tokenData = TokenModel.fromJson(response.data);

        await storage.write(key: 'user', value: jsonEncode(userData.toJson()));
        await storage.write(
            key: 'token', value: jsonEncode(tokenData.toJson()));

        Constant.navigatePushReplacement(context, MainScreen());
      } else {
        // Handle other status codes or errors here
        print('Login Failed: ${response.statusCode}');
      }
    } on DioException catch (error) {
      // Handle Dio errors or exceptions here
      print('Error occurred: $error');
      showDialog(
        context: context,
        builder: (context) {
          return ErrorDialog(
            text: "${error.response!.data['message']}",
          );
        },
      );
    }
  }
}
