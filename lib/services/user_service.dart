import 'package:noktonokto/models/user.dart';

class UserService {
  User? user;
  String? token;

  User? getUser() {
    return user;
  }

  void loginUser(String username, String password) {
    token = "asd";
  }

  void logout() {
    user = null;
  }
}
