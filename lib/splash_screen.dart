import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'module/auth/controller/AuthController.dart';
import 'module/auth/view/screen/login_screen.dart';
import 'module/dashboard/view/screen/dashboard_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final authController = Get.put(AuthController());

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  // check user login or new??
  Future<void> checkLoginStatus() async {
    await authController.checkLoginStatus();

    if (authController.isAuthenticated.value) {
      Get.offAll(() => DashboardScreen());
    } else {
      Get.offAll(() => LoginScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
