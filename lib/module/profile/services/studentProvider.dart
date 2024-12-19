import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/student_formdata.dart';

class StudentProvider extends ChangeNotifier {
  late StudentFormData _student;

  StudentFormData get student => _student;

  void updateStudent(StudentFormData newStudent) {
    _student = newStudent;
    notifyListeners();
  }

  // Save student data to SharedPreferences
  Future<void> saveStudentToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final studentString = prefs.getString('student');
    if (studentString != null) {
      final studentMap = jsonDecode(studentString);
      updateStudent(StudentFormData.fromMap(studentMap));
    }
  }

  // Load student data from SharedPreferences
  Future<void> loadStudentFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final studentString = prefs.getString('student');
    if (studentString != null) {
      final studentMap = jsonDecode(studentString);
      updateStudent(StudentFormData.fromMap(studentMap));
    }
  }
}