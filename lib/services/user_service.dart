import 'dart:convert';
import 'dart:io';

import 'package:noktonokto/models/user.dart';
import 'package:noktonokto/utils/constants.dart';
import 'package:http/http.dart' as http;

class UserService {
    static const String USER_URL = "$BACKEND_BASE_URL/user";
 
  String? token;

  Future<void> login(String username, String password) async {
    final body = {
      'username': username,
      'password': password,
    };
    final headers = {'Content-Type': 'application/json',
      'Accept': 'application/json',};

    final response = await http.post(Uri.parse("$USER_URL/login"), body: jsonEncode(body), headers: headers);

    token = jsonDecode(response.body).cast<Map<String, dynamic>>()['token'];
  }

   Future<User?> getUser() async {
    if (getToken() == null) {
      throw const HttpException("Unauthorized");
    }
    final headers = {'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',};

    final response = await http.get(Uri.parse("$USER_URL"),  headers: headers);

  }

  String? getToken() {
    return token;
  }

  void logout() {
    user = null;
    token = null;
  }
}
