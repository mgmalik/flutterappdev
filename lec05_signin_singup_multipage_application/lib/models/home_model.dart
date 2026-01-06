import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:lec05_signin_singup_multipage_application/models/user_model.dart';
import 'package:localstorage/localstorage.dart';

class HomeModel extends ChangeNotifier {
  // local storage
  late LocalStorage storage;

  HomeModel() {
    storage = localStorage;
  }

  // suffix icon is visible or not
  bool _isVisible = false;
  // value in the name text field is valid or not minimum 3 characters validation
  bool _isValid = false;
  // is user want to signup as a new user
  // bool _isSignup = false;
  bool _isValidEmail = false;
  bool _isValidPassword = false;
  bool _isValidConfirmPassword = false;
  // hold users info
  // final List<UserModel> _users = [];

  bool get isVisible => _isVisible;
  set isVisible(bool value) {
    _isVisible = value;
    notifyListeners();
  }

  bool get isValid => _isValid;
  set isValid(bool value) {
    _isValid = value;
    notifyListeners();
  }

  // bool get isSignup => _isSignup;
  // set isSignup(bool value) {
  //   _isSignup = value;
  //   notifyListeners();
  // }

  bool get isValidEmail => _isValidEmail;
  set isValidEmail(bool value) {
    _isValidEmail = value;
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

  void verifyConfirmPassword(String value, String pwd) {
    if (value == pwd) {
      _isValidConfirmPassword = true;
    } else {
      _isValidConfirmPassword = false;
    }
    notifyListeners();
  }

  bool addUser(String name, String email, String password) {
    UserModel user = UserModel();
    user.name = name;
    user.email = email;
    user.password = password;
    String userJsonStr = jsonEncode(user);
    storage.setItem('user_info', userJsonStr);
    return true;
    // if (!(_isExistingUser())) {

    // } else {
    //   return false;
    // }
  }

  bool _isExistingUser() {
    String? userJsonString = storage.getItem('user_info');
    if (userJsonString != null) {
      return true;
    }
    return false;
  }

  UserModel? getValidUser(String email, String password) {
    String? userJsonString = storage.getItem('user_info');
    if (userJsonString != null) {
      Map<String, dynamic> userMap = jsonDecode(userJsonString);
      if (email == userMap['email'] && password == userMap['password']) {
        return UserModel.fromJson(userMap);
      }
    }
    return null;
  }
}
