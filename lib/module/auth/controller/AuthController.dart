import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/validator/validator_const.dart';
import '../../../utils/StudentDetails.dart';
import '../../../utils/commonFunction/common_snackbar.dart';
import '../../../utils/enum/ui_enum.dart';
import '../services/databaseHelper.dart';

class AuthController extends GetxController {
  var isAuthenticated = false.obs;
  final DatabaseHelper dbHelper = DatabaseHelper.instance;

  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController =  TextEditingController();

  late Timer timerInstance;
  RxInt duration = 30.obs;
  RxBool isLoading = false.obs;
  RxMap<String, dynamic> userData = <String, dynamic>{}.obs;

  void startTimer() {
    duration.value = 30;
    const oneSec = Duration(seconds: 1);
    timerInstance = Timer.periodic(
      oneSec,
          (Timer timer) {
        if (duration.value == 0) {
          // setState(() {
          timer.cancel();
          isLoading.value = false;
          isLoading.refresh();
          // });
        } else {
          // setState(() {
          duration.value--;
          // });
        }
      },
    );
  }

  // MOBILE NUMBER VALIDATOR
  bool isValidMobileNumber(
      {required String mobileNumber, required BuildContext context}) {
    String? error = ValidatorConst.validateMobileNumber(mobileNumber);
    if (error != null) {
      CommonSnackbar.showSnackBar(context, error, StatusType.error);
      return false;
    } else {
      return true;
    }
  }

  // Check if a user is logged in
  Future<void> checkLoginStatus() async {
    List<Map<String, dynamic>> users = await dbHelper.getAllUsers();

    // Find a user marked as logged in
    Map<String, dynamic>? loggedInUser =
    users.firstWhereOrNull((user) => user['isLoggedIn'] == 1);

    if (loggedInUser != null) {
      StudentDetails.updateFromMap(loggedInUser);
      isAuthenticated.value = true;
    } else {
      isAuthenticated.value = false;
    }
  }

  // Update the login status for a user
  Future<void> updateLoginStatus(String mobileNumber, bool status) async {
    final dbHelper = DatabaseHelper.instance;
    Map<String, dynamic>? user = await dbHelper.getUser(mobileNumber);

    if (user != null) {
      final updatedUser = Map<String, dynamic>.from(user);

      // Update the isLoggedIn field
      updatedUser['isLoggedIn'] = status ? 1 : 0;

      // Update the user in the database
      await dbHelper.updateUser(updatedUser, updatedUser['studentid']); // Ensure `user_id` is correctly referenced.
    }
  }

  // void setUserData(Map<String, dynamic> data) {
  //   userData.value = data;
  // }
  //
  // void updateUserDataLocally(Map<String, dynamic> updatedData) {
  //   userData.value = updatedData;
  // }
  Future<void> login(String mobile, String password) async {
    final user = await dbHelper.getUser(mobile);

    if (user != null && user['password'] == password) {
      await dbHelper.setLoggedInStatus(mobile, 1); // Set user as logged in
      isAuthenticated.value = true;
    } else {
      isAuthenticated.value = false;
      throw Exception('Invalid credentials');
    }
  }

  Future<void> logout(String mobile) async {
    await dbHelper.setLoggedInStatus(mobile, 0); // Set user as logged out
    isAuthenticated.value = false;
  }
}