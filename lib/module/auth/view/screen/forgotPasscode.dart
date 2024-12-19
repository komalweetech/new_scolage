import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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


  void otpApi() async {
    final mobileNumber = kAuthController.phoneNumberController.text;
    var response = await OtpApi.postApi(mobileNumber);
    print("response of login ==== $response");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child:  ListView(
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
              controller: emailController,
              maxLength: 10,
              decoration: InputDecoration(
                isDense: true,
                counter: const SizedBox(),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
                labelText: " Email Id",

              ),
            ),
            SizedBox(height: 10.h),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: CommonSaveAndSubmitButton(
                name: " Sent Otp",
                onTap: () async {
                  // otpApi();
                  StudentDetails.mobile = kAuthController.phoneNumberController.text;
                  setState(() {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (BuildContext context) =>
                      const OtpBottomSheet(isFromForgotPasscode: true),
                    );
                  });
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
