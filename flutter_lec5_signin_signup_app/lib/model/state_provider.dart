import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lec5_signin_signup_app/model/user_model.dart';

class StateProvider extends ChangeNotifier {
  bool _isSignup = false;
  bool _isVisible = false;
  bool _isValidEmail = false;
  bool _isValid = false;
  bool _isValidPassword = false;
  bool _isValidConfirmPassword = false;

  final List<UserModel> _users = [];

  bool get isSignup => _isSignup;
  set isSignup(bool value) {
    _isSignup = value;
    notifyListeners();
  }

  bool get isVisible => _isVisible;
  set isVisible(bool value) {
    _isVisible = value;
    notifyListeners();
  }

  bool get isValidEmail => _isValidEmail;
  set isValidEmail(bool value) {
    _isValidEmail = value;
    notifyListeners();
  }

  bool get isValid => _isValid;
  set isValid(bool value) {
    _isValid = value;
    notifyListeners();
  }

  bool get isValidPassword => _isValidPassword;
  set isValidPassword(bool value) {
    _isValidPassword = value;
    notifyListeners();
  }

  bool get isValidConfirmPassword => _isValidConfirmPassword;
  set isValidConfirmPassword(bool value) {
    _isValidConfirmPassword = value;
    notifyListeners();
  }

  void verifyEmail(String value) {
    final emailRegex = RegExp(
      // A common, reasonably robust regex pattern for emails
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    if (emailRegex.hasMatch(value)) {
      _isValidEmail = true;
    } else {
      _isValidEmail = false;
    }
    notifyListeners();
  }

  void verifyPassword(String value) {
    const int minLength = 8;

    if (value.length < minLength ||
        !value.contains(RegExp(r'[a-z]')) ||
        !value.contains(RegExp(r'[A-Z]')) ||
        !value.contains(RegExp(r'[0-9]')) ||
        !value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      _isValidPassword = false;
    } else {
      _isValidPassword = true;
    }
    notifyListeners();
  }

  bool addUser(String name, String email, String password) {
    if (!_isExistingUser(email)) {
      UserModel user = UserModel();
      user.name = name;
      user.email = email;
      user.password = password;
      _users.add(user);
      _isSignup = false;
      return true;
    } else {
      return false;
    }
  }

  bool _isExistingUser(String email) {
    return _users.any((item) => item.email == email);
  }

  UserModel? getValidUser(String email, String password) {
    UserModel? existingUser = _users.firstWhereOrNull((x) => x.email == email);
    if (existingUser?.password == password) {
      return existingUser;
    } else {
      return null;
    }
  }

  void verifyConfirmPassword(String value, String pwd) {
    if (value == pwd) {
      _isValidConfirmPassword = true;
    } else {
      _isValidConfirmPassword = false;
    }
    notifyListeners();
  }
}
