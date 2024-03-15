import 'dart:convert';
import 'dart:developer';

import 'package:ascolin/model/token_model.dart';
import 'package:ascolin/model/user_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'api_service.dart';

const FlutterSecureStorage storage = FlutterSecureStorage();

Future<TokenModel?> checkAndGetToken() async {
  const FlutterSecureStorage storage = FlutterSecureStorage();

  TokenModel? token;

  try {
    String? value = await storage.read(key: 'token');

    token = value != null ? TokenModel.fromJson(jsonDecode(value)) : null;
  } catch (e) {
    rethrow;
  }

  return token;
}

Future<UserModel?> checkAndGetUser() async {
  const FlutterSecureStorage storage = FlutterSecureStorage();

  UserModel? user;

  try {
    String? value = await storage.read(key: 'user');

    user = value != null ? UserModel.fromJson(jsonDecode(value)) : null;
  } catch (e) {
    rethrow;
  }

  return user;
}

Future<TokenModel?> refreshToken(Dio tokenDio) async {
  var api = ApiService();

  String? value = await storage.read(key: 'user');

  var user = value != null ? UserModel.fromJson(jsonDecode(value)) : null;
  TokenModel? token;

  if (user != null) {
    try {
      final response = await tokenDio.post("/auth/login", data: {
        'email': user.email,
        'password': user.password,
      });

      token = TokenModel.fromJson(response.data);
      await storage.write(key: 'token', value: jsonEncode(token.toJson()));
    } catch (e) {
      rethrow;
    }
  } else {
    log("refresh token, no user found");
  }

  return token;
}
