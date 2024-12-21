import 'package:get/get.dart';

import '../services/databaseHelper.dart';


class SignupController extends GetxController {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  Future<void> saveUser(Map<String, dynamic> userData) async {
    try {
      await _dbHelper.insertUser(userData);
      Get.snackbar("Success", "User registered successfully!",
          snackPosition: SnackPosition.BOTTOM);
    } catch (error) {
      Get.snackbar("Error", "Failed to save user: $error",
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<List<Map<String, dynamic>>> fetchAllUsers() async {
    return await _dbHelper.getAllUsers();
  }
}
