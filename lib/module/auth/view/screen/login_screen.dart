import 'dart:io';
import 'package:dotted_line/dotted_line.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../utils/StudentDetails.dart';
import '../../../../utils/commonWidget/common_save_and_submit_button.dart';
import '../../../../utils/commonWidget/common_sq_text_button.dart';
import '../../../../utils/constant/asset_icons.dart';
import '../../../../utils/theme/common_color.dart';
import '../../../dashboard/view/screen/dashboard_screen.dart';
import '../../controller/AuthController.dart';
import '../../dependencies/auth_dependencies.dart';
import '../../services/databaseHelper.dart';
import '../../services/preflogin.dart';
import '../../services/student_login_Api.dart';
import '../widget/continue_with_button.dart';
import 'forgotPasscode.dart';
import 'otp_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String flutterSdkVersion = Platform.version.split(' ')[2];
  String dartSdkVersion = Platform.version.split(' ')[0];
  bool isObscure = true;

  // controller
  final authController = Get.find<AuthController>();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    print(
      'Flutter SDK Version: $flutterSdkVersion',
    );
    print(
      'Dart SDK Version: $dartSdkVersion',
    );
    phoneController.text = StudentDetails.mobile;
  }

  void openWhatsApp() async {
    String phoneNumber = phoneController.text;
    print("whatsApp number == $phoneNumber}");
    final url = 'https://wa.me/$phoneNumber';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Failed to open Whatsapp, Please check Phone number")));
      print('Could not launch $url');
    }
  }

  Future<void> _login() async {
    String mobile = phoneController.text.trim();
    String password = passwordController.text.trim();

    if (mobile.isEmpty || password.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please enter both phone and password",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return;
    }

    try {
      var response = await StudentLoginApi.postApi(mobile, password);
      print("API Response: $response");

      if (response['data'] != null && response['message'] == "Login successfully") {
        var userData = response['data'];
        print("Parsed Data: ${response['data']}");

        // Save user data in the local database
        // Save user data in the local database
        await DatabaseHelper.instance.insertUser({
          'studentid': userData['studentid'],
          'role': userData['role'],
          'name': userData['name'],
          'gender': userData['gender'],
          'school_name': userData['school_name'],
          'password': password,
          'confirm_password': password,
          'mobile': mobile,
          'email': userData['email'],
          'isLoggedIn': 1,
        });

        // Update StudentDetails
        StudentDetails.updateFromMap({
          'name': userData['name'],
          'studentid': userData['studentid'],
          'mobile': mobile,
          'email': userData['email'],
          'school_name': userData['school_name'],
          'role': userData['role'],
        });

        // Show success toast
        Fluttertoast.showToast(
          msg: "Login Successful",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: kPrimaryColor,
          textColor: Colors.white,
          timeInSecForIosWeb: 1,
          fontSize: 16.0,
        );

        // Navigate to the DashboardScreen
        print("Navigating to DashboardScreen...");
        Get.offAll(() => DashboardScreen());

      }else {
        print("Invalid credentials");
         // Handle login failure
        Fluttertoast.showToast(
          msg: response['message'] ?? "Invalid credentials",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    } catch (e) {
      print("Login Error: $e");
      Fluttertoast.showToast(
        msg: "An error occurred during login. Please try again.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            SizedBox(height: 100.h),
            // LOGO .
            SizedBox(
              height: 80.h,
              child: Image.asset(
                AssetIcons.PRIVACY_POLICY_SCREEN_APP_LOGO_ICON,
              ),
            ),
            SizedBox(height: 50.h),
            // TEXT .
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 26.w),
              child: Column(
                children: [
                  SizedBox(height: 20.h),
                  // MOBILE NUMBER FIELD
                  TextField(
                    controller: phoneController,
                    maxLength: 10,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      isDense: true,
                      counter: const SizedBox(),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      // labelText: " Mobile Number",
                      hintText: " Mobile Number",
                    ),
                  ),
                  SizedBox(height: 12.h),
                  // MOBILE NUMBER FIELD
                  TextField(
                    keyboardType: TextInputType.text,
                    obscureText: isObscure,
                    controller: passwordController,
                    decoration: InputDecoration(
                      isDense: true,
                      counter: const SizedBox(),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      // labelText: " Password",
                      hintText: " Password",
                      suffixIcon: IconButton(
                        icon: Icon(
                          isObscure ? Icons.visibility_off : Icons.visibility,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            isObscure = !isObscure; // Toggle the value
                          });
                        },
                      ),
                    ),
                  ),
                  Align(
                      alignment: Alignment.bottomRight,
                      child: CommonSqTextButton(
                          name: "Forgot PASSCODE",
                          isSelected: false,
                          onTap: () => Get.to(const ForgotPassCode()),
                          color: kPrimaryColor)),
                  SizedBox(height: 10.h),
                  CommonSaveAndSubmitButton(
                    name: "Login",
                    onTap: _login,
                    padding: EdgeInsets.zero,
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    children: [
                      const Expanded(
                        child: DottedLine(
                          dashColor: grey128Color,
                          lineThickness: 1,
                          dashLength: 1,
                          dashRadius: 2,
                          dashGapLength: 2,
                        ),
                      ),
                      Text(
                        " OR ",
                        style: TextStyle(
                            fontSize: 18.sp,
                            color: grey88Color,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w500),
                      ),
                      const Expanded(
                        child: DottedLine(
                          dashColor: grey128Color,
                          lineThickness: 1,
                          dashLength: 1,
                          dashRadius: 2,
                          dashGapLength: 2,
                        ),
                      ),
                    ],
                  ),
                  // SizedBox(height: 12.h),
                  // // CONTINUE WITH WHATSAPP
                  // ContinueWithButton(
                  //   name: "Continue with Whatsapp",
                  //   icon: AssetIcons.LOGIN_WHATSAPP_ICON,
                  //   onTap: () {
                  //     print("whatsApp number == ${phoneController.text}");
                  //     // CommonToast.showComingSoonToast();
                  //     // openWhatsApp();
                  //   },
                  // ),
                  // SizedBox(height: 20.h),
                  // // CONTINUE WITH GOOGLE
                  // ContinueWithButton(
                  //   name: "Continue with Google",
                  //   icon: AssetIcons.GOOGLE_ICON,
                  //   onTap: () async {
                  //     // try {
                  //     //   final userCredential = await authController.signInWithGoogle();
                  //     //   if (userCredential != null) {
                  //     //     Get.offAll(() => DashboardScreen());
                  //     //   }
                  //     // } catch (e) {
                  //     //   Fluttertoast.showToast(
                  //     //     msg: "Failed to sign in with Google",
                  //     //     toastLength: Toast.LENGTH_LONG,
                  //     //     gravity: ToastGravity.BOTTOM,
                  //     //     backgroundColor: Colors.red,
                  //     //     textColor: Colors.white,
                  //     //     fontSize: 16.0,
                  //     //   );
                  //     // }
                  //   },
                  // ),
                  SizedBox(height: 40.h),
                  // SIGN IN WITH CODE BUTTON
                  Padding(
                    padding: EdgeInsets.only(left: 30, right: 30),
                    child: CommonSaveAndSubmitButton(
                      onTap: () {
                        Get.to(const OtpScreen());
                      },
                      name: "Sign Up",
                    ),
                  ),
                  SizedBox(height: 30.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}