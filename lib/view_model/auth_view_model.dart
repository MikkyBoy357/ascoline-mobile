import 'package:ascolin/base/constant.dart';
import 'package:ascolin/model/user_model.dart';
import 'package:ascolin/pages/main_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../widgets/error_dialog.dart';

class AuthViewModel extends ChangeNotifier {
  late UserModel userData;

  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

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

  Future<void> signUp(BuildContext context) async {
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
      String apiUrl = '${Constant.baseUrl}/auth/signup';

      print(apiUrl);

      final Dio dio = Dio();

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

      final Response response = await dio.post(
        apiUrl,
        data: data,
      );

      if (response.statusCode == 201) {
        // Handle successful response here
        print('SignUp Successful');
        print('${response.data}');
        Constant.navigatePush(context, MainScreen());
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
            text: "${error.response!.data['message']}",
          );
        },
      );
    }
  }

  Future<void> login(BuildContext context) async {
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
      final String loginUrl = '${Constant.baseUrl}/auth/login';
      print(loginUrl);

      final Dio dio = Dio();

      final Map<String, dynamic> loginData = {
        'email': lEmail,
        'password': lPassword,
      };

      final Response response = await dio.post(
        loginUrl,
        data: loginData,
      );

      if (response.statusCode == 200) {
        // Handle successful login response here
        print('Login Successful');
        print('${response.data}');

        userData = UserModel.fromJson(response.data['user']);
        Constant.navigatePush(context, MainScreen());
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
