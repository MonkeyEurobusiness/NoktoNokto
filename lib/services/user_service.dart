import 'dart:convert';
import 'dart:io';

import 'package:noktonokto/models/user.dart';
import 'package:noktonokto/utils/constants.dart';
import 'package:http/http.dart' as http;

class UserService {
  static UserService? instance = null;
  static UserService getInstance() {
    instance ??= UserService._();
    return instance!;
  }

  UserService._() {}

  static const String USER_URL = "$BACKEND_BASE_URL/user";

  String? token;

  Future<void> login(String username, String password) async {
    final body = {
      'username': username,
      'password': password,
    };
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    final response =
        await http.post(Uri.parse("$USER_URL/login"), body: jsonEncode(body), headers: headers);

    token = jsonDecode(response.body)['token'];
  }

  Future<void> register(String username, String email, String password) async {
    final body = {
      'username': username,
      // 'email': email,
      'password': password,
    };
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    final response =
        await http.post(Uri.parse("$USER_URL/register"), body: jsonEncode(body), headers: headers);

    token = jsonDecode(response.body)['token'];
  }

  Future<User?> getUser() async {
    // if (getToken() == null) {
    //   throw const HttpException("Unauthorized");
    // }
    // final headers = {
    //   'Content-Type': 'application/json',
    //   'Accept': 'application/json',
    //   'Authorization': 'Bearer $token',
    // };

    // final response = await http.get(Uri.parse(USER_URL), headers: headers);

    return User(1, 'email', 'user', 'sad');
  }

  String? getToken() {
    return token;
  }

  Future<void> logout() async {
    final body = {
      'token': token ?? '',
    };
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    await http.post(Uri.parse("$USER_URL/logout"), body: jsonEncode(body), headers: headers);
  }
}
