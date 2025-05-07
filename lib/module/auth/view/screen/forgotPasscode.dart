import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../utils/StudentDetails.dart';
import '../../../../utils/commonWidget/common_save_and_submit_button.dart';
import '../../../../utils/constant/asset_icons.dart';
import '../../dependencies/auth_dependencies.dart';
import '../../services/otp_Api.dart';
import 'otp_ButtomSheet.dart';


class ForgotPassCode extends StatefulWidget {
  const ForgotPassCode({super.key});

  @override
  State<ForgotPassCode> createState() => _ForgotPassCodeState();
}

class _ForgotPassCodeState extends State<ForgotPassCode> {
  TextEditingController emailController =  TextEditingController();


  Future<bool> otpApi() async {
    final mobileNumber = kAuthController.phoneNumberController.text;
    final email = emailController.text.trim();

    if (mobileNumber.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter your mobile number'),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }
    
    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter your email address'),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }
    // Basic email format validation (optional but recommended)
    if (!GetUtils.isEmail(email)) {
       ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid email address'),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }

    try {
      // Pass the email to the API call
      var response = await OtpApi.postApi(mobileNumber, "forgetPass", email: email);
      print("response of forgot password ==== $response");
      return response != null;
    } catch (e) {
      print("Error sending OTP: $e");
      return false;
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
                      hintText: " Mobile Number",
                    ),
                  ),
                  SizedBox(height: 12.h),
                  // EMAIL FIELD
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      isDense: true,
                      counter: const SizedBox(),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      hintText: " Email Id",
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: CommonSaveAndSubmitButton(
                      name: " Send OTP",
                      onTap: () async {
                        final success = await otpApi();
                        if (success) {
                          StudentDetails.mobile = kAuthController.phoneNumberController.text;
                          setState(() {
                            showModalBottomSheet(
                              isScrollControlled: true,
                              context: context,
                              builder: (BuildContext context) =>
                              const OtpBottomSheet(isFromForgotPasscode: true),
                            );
                          });
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Failed to send OTP. Please try again.'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      },
                      padding: EdgeInsets.zero,
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
