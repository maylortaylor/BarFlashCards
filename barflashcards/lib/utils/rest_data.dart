import 'dart:async';

import 'package:barflashcards/models/user.dart';
import 'package:barflashcards/utils/network_util.dart';

class RestData {
  NetworkUtil _netUtil = new NetworkUtil();
  static final BASE_URL = "";
  static final LOGIN_URL = BASE_URL + "/login";

  Future<User> login(String username, String password) {
    return new Future.value(new User(username, password));
  }
}
