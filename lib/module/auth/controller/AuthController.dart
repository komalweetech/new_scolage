import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/validator/validator_const.dart';
import '../../../utils/StudentDetails.dart';
import '../../../utils/commonFunction/common_snackbar.dart';
import '../../../utils/enum/ui_enum.dart';
import '../services/databaseHelper.dart';

class AuthController extends GetxController {
  var isAuthenticated = false.obs;
  final DatabaseHelper dbHelper = DatabaseHelper.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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

  Future<UserCredential?> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) return null;

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the Google credential
      final UserCredential userCredential = await _auth.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null) {
        // Check if user exists in Firestore
        final userDoc = await _firestore.collection('users').doc(user.uid).get();

        if (!userDoc.exists) {
          // Create new user document in Firestore with phone number if available
          Map<String, dynamic> userData = {
            'name': user.displayName,
            'email': user.email,
            'photoURL': user.photoURL,
            'role': 'student',
            'isLoggedIn': 1,
            'createdAt': FieldValue.serverTimestamp(),
          };

          // Add phone number if it exists in StudentDetails
          if (StudentDetails.mobile.isNotEmpty) {
            userData['mobile'] = StudentDetails.mobile;
          }

          await _firestore.collection('users').doc(user.uid).set(userData);

          // Save to local database
          Map<String, dynamic> localUserData = {
            'studentid': user.uid,
            'role': 'student',
            'name': user.displayName,
            'email': user.email,
            'isLoggedIn': 1,
          };

          // Add phone number if it exists
          if (StudentDetails.mobile.isNotEmpty) {
            localUserData['mobile'] = StudentDetails.mobile;
          }

          await dbHelper.insertUser(localUserData);
        } else {
          // Update login status in local database
          await dbHelper.setLoggedInStatus(user.email ?? '', 1);
        }

        // Update StudentDetails
        Map<String, dynamic> studentDetails = {
          'name': user.displayName,
          'studentid': user.uid,
          'email': user.email,
          'role': 'student',
        };

        // Add phone number if it exists
        if (StudentDetails.mobile.isNotEmpty) {
          studentDetails['mobile'] = StudentDetails.mobile;
        }

        StudentDetails.updateFromMap(studentDetails);

        isAuthenticated.value = true;
        return userCredential;
      }
    } catch (e) {
      print('Error signing in with Google: $e');
      rethrow;
    }
    return null;
  }

  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
      isAuthenticated.value = false;
    } catch (e) {
      print('Error signing out: $e');
    }
  }
}