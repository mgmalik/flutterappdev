import 'dart:convert';

import 'package:flutter_lec05_expense_tracking_app_riverpod/models/category.dart';
import 'package:flutter_lec05_expense_tracking_app_riverpod/models/expense.dart';
import 'package:flutter_lec05_expense_tracking_app_riverpod/models/tag.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static late SharedPreferences _prefs;

  static Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
  }

  final String expenseKey = 'ExpneseKey';
  final String categoryKey = 'CategoryKey';
  final String tagKey = 'TagKey';

  // save List<Expnese>
  Future<bool> saveExpensesList(List<Expense> expenses) async {
    // convert the objects into a list of maps
    final List<Map<String, dynamic>> jsonList = expenses
        .map((expense) => expense.toJson())
        .toList();

    // Encoding the map into a json string
    final String jsonString = jsonEncode(jsonList);
    return await _prefs.setString(expenseKey, jsonString);
  }

  List<Expense> getExpensesList() {
    final String? jsonString = _prefs.getString(expenseKey);
    if (jsonString == null) {
      return [];
    }
    // decode the json string into Map<String, dynamic>
    final List<dynamic> jsonList = jsonDecode(jsonString);
    // converting the list of map into list of Expnese
    return jsonList
        .map((expnse) => Expense.fromJson(expnse as Map<String, dynamic>))
        .toList();
  }

  Future<bool> saveCategoriesList(List<Category> categories) async {
    // convert the objects into a list of maps
    final List<Map<String, dynamic>> jsonList = categories
        .map((category) => category.toJson())
        .toList();

    // Encoding the map into a json string
    final String jsonString = jsonEncode(jsonList);
    return await _prefs.setString(categoryKey, jsonString);
  }

  List<Category> getCategoriesList() {
    final String? jsonString = _prefs.getString(categoryKey);
    if (jsonString == null) {
      return [];
    }
    // decode the json string into Map<String, dynamic>
    final List<dynamic> jsonList = jsonDecode(jsonString);
    // converting the list of map into list of Expnese
    return jsonList
        .map((category) => Category.fromJson(category as Map<String, dynamic>))
        .toList();
  }

  Future<bool> saveTagsList(List<Tag> tags) async {
    // convert the objects into a list of maps
    final List<Map<String, dynamic>> jsonList = tags
        .map((tag) => tag.toJson())
        .toList();

    // Encoding the map into a json string
    final String jsonString = jsonEncode(jsonList);
    return await _prefs.setString(tagKey, jsonString);
  }

  List<Tag> getTagsList() {
    final String? jsonString = _prefs.getString(tagKey);
    if (jsonString == null) {
      return [];
    }
    // decode the json string into Map<String, dynamic>
    final List<dynamic> jsonList = jsonDecode(jsonString);
    // converting the list of map into list of Expnese
    return jsonList
        .map((tag) => Tag.fromJson(tag as Map<String, dynamic>))
        .toList();
  }
}
