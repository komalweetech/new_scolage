import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:new_scolage/module/auth/view/screen/resetPasscode.dart';
import 'package:new_scolage/module/auth/view/screen/sing_up_screen.dart';
import 'package:new_scolage/utils/StudentDetails.dart';

import '../../../../utils/commonWidget/common_sq_text_button.dart';
import '../../../../utils/theme/common_color.dart';
import '../../dependencies/auth_dependencies.dart';
import '../../services/otp_Api.dart';

class OtpBottomSheet extends StatefulWidget {
  const OtpBottomSheet({super.key,required this.isFromForgotPasscode});

  final bool isFromForgotPasscode;

  @override
  _OtpBottomSheetState createState() => _OtpBottomSheetState();
}

class _OtpBottomSheetState extends State<OtpBottomSheet> {
  String verificationOtp = '';
  int resendTimer = 30;
  late Timer _timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
  }
  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (resendTimer > 0) {
        setState(() {
          resendTimer--;
        });
      } else {
        _timer.cancel(); // Cancel the timer when it reaches 0 or desired time
        // Perform the action here (e.g., allow resending passcode)
      }
    });
  }
  @override
  void dispose() {
    // Cancel the timer when the widget is disposed
    _timer.cancel();
    super.dispose();
  }

  void otpApi() async {
    final mobileNumber = kAuthController.phoneNumberController.text;

    var response = await OtpApi.postApi(mobileNumber, widget.isFromForgotPasscode ? "forgetPass" : "signUp");
    print("response of login ==== $response");
  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      reverse: true,
      child: Padding(
        padding:  EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 10,right: 10),
        child: Container(
          color: Colors.transparent,
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Padding(
                         padding:  EdgeInsets.only(left: 12.w),
                         child: Text(
                          'Detecting passcode ($resendTimer s)',
                          style: const TextStyle(
                            fontSize: 20,fontFamily: "Poppins",
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.start,
                           overflow: TextOverflow.ellipsis
                         ),
                       ),
                       IconButton(
                         onPressed: () {
                           Navigator.pop(context); // Close the bottom sheet
                         },
                         icon: const Icon(Icons.close), // Close icon
                       ),
                     ],
                   ),
                  // const SizedBox(height: 15),
                   // Text(
                   //  'We have sent a 4-digit passcode on your mobile \nnumber +91-${kAuthController.phoneNumberController.text}. Edit',
                   //  style: const TextStyle(
                   //    fontSize: 15,
                   //  ),
                   //  textAlign: TextAlign.start,
                   //   maxLines: 2,
                   //   overflow: TextOverflow.ellipsis,
                   // ),
                  TextButton(
                      onPressed: () {},
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'We have sent a 4-digit passcode on your mobile \nnumber +91-${kAuthController.phoneNumberController.text}.',
                              style: const TextStyle(
                                fontSize: 15,
                                color: Colors.black
                              ),
                            ),
                             TextSpan(
                              text: " Edit",
                              style: TextStyle(
                                fontSize: 15,
                                color: kPrimaryColor,
                              ),

                            )
                          ]
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                      ),

                  ),
                  const SizedBox(height: 30),
                  OtpTextField(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    enabledBorderColor: grey128Color,
                    margin: EdgeInsets.all(10),
                    numberOfFields: 4,
                    borderColor: kPrimaryColor,
                    focusedBorderColor: commonYellowColor,
                    showFieldAsBox: true,
                    borderWidth: 2.0,
                    onCodeChanged: (String code) {
                      //handle validation or checks here if necessary
                    },
                    // onSubmit: (String verificationCode) {
                    //   setState(() {
                    //     verificationOtp = verificationCode;
                    //   });
                    //   Future.delayed(Duration(seconds: 3),() async{
                    //     final verifyNumber = kAuthController.phoneNumberController.text;
                    //     final verifyOtp = verificationOtp;
                    //     print("verify otp is = $verifyOtp");
                    //
                    //     var response = await VerifyOtp.postApi(verifyNumber,verifyOtp);
                    //     print("response of login ==== ${response}");
                    //
                    //     if(widget.isFromForgotPasscode){
                    //       Get.to(const ResetPassCode());
                    //     }else {
                    //       Get.to(const SingUpScreen());
                    //     }
                    //   });
                    //
                    // },
                    onSubmit: (String verificationCode) {
                      setState(() {
                        verificationOtp = verificationCode;
                      });

                      Future.delayed(Duration(seconds: 3), () async {
                        final verifyNumber = kAuthController.phoneNumberController.text;
                        final verifyOtp = verificationOtp;

                        print("Verify OTP is = $verifyOtp");

                        try {
                          // Make the API call
                          var response = await VerifyOtp.postApi(verifyNumber, verifyOtp);

                          if (response == null) {
                            Fluttertoast.showToast(
                              msg: 'Failed to connect to the server. Please try again.',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0,
                            );
                            return;
                          }

                          // Validate the HTTP status code
                          if (response['statusCode'] == 200) {
                            if (response['status'] == 'success') {
                              // Navigate to the appropriate screen
                              if (widget.isFromForgotPasscode) {
                                Get.to(const ResetPassCode());
                              } else {
                                Get.to(const SingUpScreen());
                              }
                            } else {
                              final errorMessage = response['error'] ?? 'OTP validation failed';
                              Fluttertoast.showToast(
                                msg: errorMessage,
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0,
                              );
                            }
                          } else if (response['statusCode'] == 401) {
                            // Unauthorized or invalid OTP
                            Fluttertoast.showToast(
                              msg: 'Invalid OTP. Please try again.',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              backgroundColor: Colors.orange,
                              textColor: Colors.white,
                              fontSize: 16.0,
                            );
                          } else if (response['statusCode'] == 500) {
                            // Internal server error
                            Fluttertoast.showToast(
                              msg: 'Server error. Please try again later.',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0,
                            );
                          } else {
                            // Generic error handling for other status codes
                            Fluttertoast.showToast(
                              msg: 'Unexpected error occurred. Status code: ${response['statusCode']}',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0,
                            );
                          }
                        } catch (e) {
                          print("Error occurred: $e");
                          Fluttertoast.showToast(
                            msg: 'Something went wrong. Please try again.',
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                        }
                      });
                    },


                  ),
                  const SizedBox(height: 20),
                  // Padding(
                  //   padding:  const EdgeInsets.only(left: 30,right: 30),
                  //   child: CommonSaveAndSubmitButton(
                  //     onTap: () async {
                  //       final verifyNumber = kAuthController.phoneNumberController.text;
                  //       final verifyOtp = verificationOtp;
                  //       print("verify otp is = $verifyOtp");
                  //
                  //       var response = await VerifyOtp.postApi(verifyNumber,verifyOtp);
                  //       print("response of login ==== ${response}");
                  //
                  //       if(widget.isFromForgotPasscode){
                  //         Get.to(const ResetPassCode());
                  //       }else {
                  //         Get.to(const SingUpScreen());
                  //       }
                  //       },
                  //     name: "Submit",
                  //   ),
                  // ),
              const SizedBox(height: 15,),
              CommonSqTextButton(
                  name: "Resend passcode",
                  isSelected: false,
                  onTap: (){
                    if(mounted){
                      otpApi();
                      setState(() {
                        resendTimer = 30; // Reset the timer
                      });
                      startTimer();
                    }
                    } ,
                  fontSize: 18 ,),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


