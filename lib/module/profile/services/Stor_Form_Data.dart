import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class  StorFormData{
  static const _keyName = 'formDetails'; // Unique key for storing form data

  static Future<bool> saveFormData(Map<String, dynamic> formData) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return await prefs.setString(_keyName, json.encode(formData));
    } catch (e) {
      print('Error saving form data: $e');
      return false;
    }
  }

  static Future<Map<String, dynamic>?> getSavedFormData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final data = prefs.getString(_keyName);
      if (data != null) {
        return json.decode(data);
      }
      return null;
    } catch (e) {
      print('Error getting form data: $e');
      return null;
    }
  }
}