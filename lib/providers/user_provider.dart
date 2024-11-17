import 'package:amazon_clone/models/user.dart';
import 'package:flutter/material.dart';

import 'package:flutter/foundation.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
    token: "",
    email: "",
    name: "",
    id: "",
    password: "",
    type: "",
    address: "",
    cart: [],
  );

  User get user => _user;

  void setUser(String userJson) {
    if (userJson.isNotEmpty) {
      _user = User.fromJson(userJson);
      notifyListeners();
    } else {
      throw Exception("User JSON data is empty or null");
    }
  }

  void setUserFromModel(User user) {
    _user = user;
    notifyListeners();
  }
}
