import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../../../utils/StudentDetails.dart';
import '../../../../utils/commonFunction/common_toast.dart';
import '../../../../utils/commonWidget/common_save_and_submit_button.dart';
import '../../../../utils/constant/asset_icons.dart';
import '../../../../utils/enum/ui_enum.dart';
import '../../../../utils/theme/common_color.dart';
import '../../dependencies/auth_dependencies.dart';
import '../../services/databaseHelper.dart';
import '../../services/otp_Api.dart';
import '../widget/continue_with_button.dart';
import 'otp_ButtomSheet.dart';
import '../../../dashboard/view/screen/dashboard_screen.dart';
import '../../controller/AuthController.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController phoneNumberController = TextEditingController();
  final authController = Get.find<AuthController>();
  List<Map<String, dynamic>> allUsers = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("otp screen == ${phoneNumberController.text}");
  }

  String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Mobile number is required';
    }
    if (value.length != 10 || !RegExp(r'^[6789]\d{9}$').hasMatch(value)) {
      return 'Invalid mobile number';
    }
    return null;
  }

  void otpApi() async {
    final mobileNumber = kAuthController.phoneNumberController.text;

    if (mobileNumber.isEmpty) {
      CommonToast.showToast('Mobile number is required', StatusType.info);
      return;
    }

    // Validate mobile number
    String? validationResult = validatePhoneNumber(mobileNumber);
    if (validationResult != null) {
      CommonToast.showToast(validationResult, StatusType.info);
      return;
    }

    // Check if the number exists and is already logged in
    final dbHelper = DatabaseHelper.instance;
    final user = await dbHelper.getUser(mobileNumber);

    if (user != null ) {
      Fluttertoast.showToast(
        msg: "This number is already logged in.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: kPrimaryColor,
        textColor: Colors.white,
        timeInSecForIosWeb: 1,
        fontSize: 16.0,
      );
      return;
    }

    // Proceed to send OTP
    final otpResponse = await OtpApi.postApi(mobileNumber, "signUp");

    if (otpResponse != null) {
      setState(() {
        showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (BuildContext context) =>
          const OtpBottomSheet(isFromForgotPasscode: false),
        );
      });
    } else {
      Fluttertoast.showToast(
        msg: "Failed to send OTP. Please try again later.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: kPrimaryColor,
        textColor: Colors.white,
        timeInSecForIosWeb: 1,
        fontSize: 16.0,
      );
    }
  }

  Future<void> _handleGoogleSignIn() async {
    try {
      // Show loading indicator
      Get.dialog(
        const Center(
          child: CircularProgressIndicator(),
        ),
        barrierDismissible: false,
      );

      final userCredential = await authController.signInWithGoogle();
      
      // Close loading indicator
      Get.back();

      if (userCredential != null) {
        Fluttertoast.showToast(
          msg: "Successfully Signed Up with Google",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: kPrimaryColor,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        Get.offAll(() => const DashboardScreen());
      } else {
        Fluttertoast.showToast(
          msg: "Google Sign-In was cancelled",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.orange,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    } catch (e) {
      // Close loading indicator if it's still showing
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }

      print('Google Sign-In Error: $e');
      Fluttertoast.showToast(
        msg: "Failed to sign up with Google: ${e.toString()}",
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
        resizeToAvoidBottomInset: false,
        body: SafeArea(
            child: SingleChildScrollView(
          child: SingleChildScrollView(
            child: Column(children: [
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
                    TextFormField(
                      controller: kAuthController.phoneNumberController,
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
                      validator: validatePhoneNumber,
                    ),
                    SizedBox(height: 10.h),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: CommonSaveAndSubmitButton(
                        name: "Sent Otp",
                        onTap: () {
                          StudentDetails.mobile = kAuthController.phoneNumberController.text;
                          otpApi();
                        },
                        padding: EdgeInsets.zero,
                      ),
                    ),
                    SizedBox(height: 15.h),
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
                          style: TextStyle(fontSize: 18.sp, color: grey88Color),
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
                    SizedBox(height: 15.h),
                    // CONTINUE WITH WHATSAPP
                    ContinueWithButton(
                      name: "Continue with Whatsapp",
                      icon: AssetIcons.LOGIN_WHATSAPP_ICON,
                      onTap: () async {
                        CommonToast.showComingSoonToast();
                      },
                    ),
                    SizedBox(height: 20.h),
                    // CONTINUE WITH GOOGLE
                    ContinueWithButton(
                      name: "Continue with Google",
                      icon: AssetIcons.GOOGLE_ICON,
                      onTap: _handleGoogleSignIn,
                    ),
                    // SizedBox(height: 20.h),
                    // // SIGN IN WITH CODE BUTTON
                    // Padding(
                    //   padding: const EdgeInsets.only(left: 30, right: 30),
                    //   child: CommonSaveAndSubmitButton(
                    //     onTap: () {
                    //       Get.to(const SingUpScreen());
                    //     },
                    //     name: "Sign Up",
                    //   ),
                    // ),
                    SizedBox(height: 30.h),
                  ],
                ),
              ),
            ]),
          ),
        )));
  }
}
