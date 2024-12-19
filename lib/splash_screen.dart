import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_scolage/utils/constant/asset_icons.dart';
import 'module/auth/services/databaseHelper.dart';
import 'module/auth/view/screen/login_screen.dart';
import 'module/dashboard/view/screen/dashboard_screen.dart';
 // Import your Login screen

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _checkUserLoginStatus();
  }

  // Check if the user is logged in
  Future<void> _checkUserLoginStatus() async {
    final dbHelper = DatabaseHelper.instance;
    final users = await dbHelper.getAllUsers();

    print("Users from database: $users");

    // Assuming that the first user in the list indicates if the user is logged in
    if (users.isNotEmpty) {
      for (var user in users) {
        if (user['isLoggedIn'] == true) {
          setState(() {
            isLoggedIn = true;
          });
          break; // Exit loop once a logged-in user is found
        }
      }
    }
    print("Is user logged in? $isLoggedIn");

    // Navigate to the appropriate screen after checking the login status
    Future.delayed(const Duration(seconds: 2), () {
      if (isLoggedIn) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const DashboardScreen()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: SizedBox(
          height: 80.h,
          child: Image.asset(
            AssetIcons.PRIVACY_POLICY_SCREEN_APP_LOGO_ICON,
          ),
        ),
      ),
    );
  }
}
