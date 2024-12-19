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
import '../../dependencies/auth_dependencies.dart';
import '../../services/databaseHelper.dart';
import '../../services/preflogin.dart';
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
  // String phoneNumber = StudentDetails.mobile;

  // controller
  // TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // StudentLoginApi.postApi("number","password");
    print( 'Flutter SDK Version: $flutterSdkVersion',);
    print('Dart SDK Version: $dartSdkVersion',);

  }

  @override
  void dispose() {
    // phoneController.clear();
    passwordController.clear();
    super.dispose();
  }

  void openWhatsApp() async {
    String phoneNumber = kAuthController.phoneNumberController.text;
    print("whatsApp number == ${kAuthController.phoneNumberController.text}");
    final url = 'https://wa.me/$phoneNumber';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to open Whatsapp, Please check Phone number")));
      print('Could not launch $url');
    }
  }

  Future<void> _login() async {
    String phone =  kAuthController.phoneNumberController.text;
    String password = passwordController.text;

    if(phone.isEmpty || password.isEmpty) {
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

    final users = await DatabaseHelper.instance.getAllUsers();
    print("Users from database: $users");
    bool userFound = false;

    for(var user in users){
      print("Checking user: ${user['mobile']} == $phone, ${user['password']} == $password");

      if(user['mobile'] == phone && user['password'] == password.trim()){
        StudentDetails.studentId = user['id'].toString();
        StudentDetails.mobile = user['mobile'];
        userFound = true;

        print("login student id == ${StudentDetails.studentId}");

      }
    }
    if(userFound){
      Fluttertoast.showToast(
        msg: "Login Successful",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: kPrimaryColor,
        textColor: Colors.white,
        timeInSecForIosWeb: 1,
        fontSize: 16.0,
      );
      // Navigate to the next screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const DashboardScreen()),
      );
    }else {
      Fluttertoast.showToast(
        msg: "Invalid credentials",
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
                    controller: kAuthController.phoneNumberController,
                    maxLength: 10,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      isDense: true,
                      counter: const SizedBox(),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      labelText: " Mobile Number",
                    ),
                  ),
                  SizedBox(height: 12.h),
                  // MOBILE NUMBER FIELD
                  TextField(
                    keyboardType: TextInputType.text,
                    obscureText: isObscure,
                    controller: passwordController,
                    maxLength: 10,
                    decoration: InputDecoration(
                      isDense: true,
                      counter: const SizedBox(),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      labelText: " Password",
                      suffixIcon: IconButton(
                        icon: Icon(
                          isObscure ?  Icons.visibility_off : Icons.visibility ,
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
                  Align(alignment: Alignment.bottomRight,
                      child: CommonSqTextButton(name: "Forgot PASSCODE", isSelected: false,
                          onTap: () => Get.to(const ForgotPassCode()),color: kPrimaryColor)),
                  SizedBox(height: 10.h),
                  CommonSaveAndSubmitButton(
                    name: "Login",
                    // onTap: () async {
                    //   final userNumber = kAuthController.phoneNumberController.text;
                    //   final password = kAuthController.passwordController.text;
                    //   // Perform login API call
                    //   print("mobile num is === ${userNumber.toString()}");
                    //   var response = await StudentLoginApi.postApi(userNumber, password);
                    //
                    //   print("response of login ==== ${response}");
                    //
                    //   if (response[0] == "error") {
                    //     return;
                    //   }
                    //   if(response["error"] != null) {
                    //     Fluttertoast.showToast(
                    //         msg: response["error"],
                    //         toastLength: Toast.LENGTH_LONG,
                    //         gravity: ToastGravity.BOTTOM,
                    //         timeInSecForIosWeb: 1,
                    //         backgroundColor: Colors.red,
                    //         textColor: Colors.white,
                    //         fontSize: 16.0
                    //     );
                    //   } else {
                    //     final SharedPreferences prefs = await _prefs;
                    //     await saveUserCredentials(userNumber, response["data"]["email"],
                    //         response["data"]["studentid"], response["data"]["name"]);
                    //     print("object======= ${response["data"]["studentid"]}");
                    //     StudentDetails.name = response["data"]["name"];
                    //     StudentDetails.mobile = userNumber;
                    //     StudentDetails.email = response["data"]["email"];
                    //     StudentDetails.studentId = response["data"]["studentid"];
                    //     StudentDetails.schoolName = response["data"]["school_name"];
                    //     StudentDetails.role = response["data"]["role"];
                    //
                    //     prefs.setString("name",  response["data"]["name"]);
                    //     prefs.setString("mobile",  userNumber);
                    //     prefs.setString("email",  response["data"]["email"]);
                    //     prefs.setString("studentId",  response["data"]["studentid"]);
                    //     prefs.setString("school_name",  response["data"]["school_name"]);
                    //     prefs.setString("role",  response["data"]["role"]);
                    //     Get.to(const DashboardScreen());
                    //   }
                    //   // Get.to(DashboardScreen());
                    //   // if (kAuthController.isValidMobileNumber(
                    //   //     mobileNumber: kAuthController.phoneNumberController.text,
                    //   //     context: context)) {
                    //   //   CommonFunction.keyboardOff(context);
                    //   //   await kAuthInfrastructure.mobileNumberAuthentication(
                    //   //
                    //   //     mobileNumber:
                    //   //         kAuthController.phoneNumberController.text,
                    //   //     context:context,
                    //   //   );
                    //   // }
                    // },
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
                        style: TextStyle(fontSize: 18.sp, color: grey88Color,fontFamily: "Poppins",fontWeight: FontWeight.w500),
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
                  SizedBox(height: 12.h),
                  // CONTINUE WITH WHATSAPP
                  ContinueWithButton(
                    name: "Continue with Whatsapp",
                    icon: AssetIcons.LOGIN_WHATSAPP_ICON,
                    onTap: ()  {
                      print("whatsApp number == ${kAuthController.phoneNumberController.text}");
                      // CommonToast.showComingSoonToast();
                      openWhatsApp();
                    },
                  ),

                  SizedBox(height: 20.h),
                  // CONTINUE WITH GOOGLE
                  ContinueWithButton(
                    name: "Continue with Google",
                    icon: AssetIcons.GOOGLE_ICON,
                    onTap: () {
                      // CommonToast.showComingSoonToast();
                      launch('https://google.com');
                    },
                  ),
                  SizedBox(height: 40.h),
                  // SIGN IN WITH CODE BUTTON
                  Padding(
                    padding:  EdgeInsets.only(left: 30,right: 30),
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
