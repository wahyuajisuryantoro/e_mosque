import 'package:flutter/material.dart';
import 'package:e_mosque/model/user_model.dart';

class UserProvider with ChangeNotifier {
  User? _user;

  User? get user => _user;

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }

   void updateUser(User updatedUser) {
    _user = updatedUser;
    notifyListeners();
  }

  void logout() {
    _user = null;
    notifyListeners();
  }
}
