

import 'package:noktonokto/models/user.dart';

class UserService {

  User getUser(String username, String password) {
    return User('test@test.com', 'dzik');
  }
}