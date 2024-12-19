

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../utils/commonWidget/common_sq_text_button.dart';
import '../../../../utils/constant/asset_icons.dart';
import '../../../../utils/theme/common_color.dart';
import '../../dependencies/auth_dependencies.dart';
import '../widget/otp_field.dart';

class OtpBottom extends StatefulWidget {
  const OtpBottom(
      {super.key, required this.verificationId, required this.mobileNumber});
  final String verificationId;
  final String mobileNumber;

  @override
  State<OtpBottom> createState() => _OtpBottomState();
}

class _OtpBottomState extends State<OtpBottom> {
  @override
  void initState() {
    kAuthController.isLoading.value = true;
    kAuthController.startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 25.w,
                    top: 14.h,
                    bottom: 16.h,
                    right: 25.w,
                  ),
                  // ignore: prefer_const_constructors
                  child: Row(
                    children: [
                      const Text(
                        "Detecting passcode ",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      Obx(
                        () => Visibility(
                          visible: kAuthController.isLoading.value,
                          child: Text(
                            "(${kAuthController.duration.value} s)",
                            style: const TextStyle(
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Image.asset(
                  AssetIcons.BOTTOM_SHEET_CLOSE_ICON,
                  height: 16.h,
                  width: 16.h,
                ),
              ),
              SizedBox(width: 10.w),
            ],
          ),
          SizedBox(height: 6.h),

          Padding(
            padding: EdgeInsets.only(left: 25.w, right: 80.w),
            child: RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                    text:
                        'We have sent a 4-digit passcode on your mobile number + 91 ${widget.mobileNumber}',
                    style: TextStyle(
                      color: grey128Color,
                      fontSize: 14.sp,
                    ),
                  ),
                  TextSpan(
                    text: '  Edit  ',
                    style: TextStyle(
                      height: 2.h,
                      color: Colors.blue,
                      fontSize: 13.sp,
                    ),
                    recognizer: TapGestureRecognizer()..onTap = () {},
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 40.h),
          // OTP FIELD
          Padding(
            padding: EdgeInsets.only(left: 25.w, right: 25.w),
            child: OTPField(
              onChange: (value) {
                if (value.length == 6) {
                  kAuthInfrastructure.otpVerification(
                    context: context,
                    mobileNumber: "+91${widget.mobileNumber}",
                    otp: value,
                    verificationId: widget.verificationId,
                  );
                }
              },
            ),
          ),
          SizedBox(height: 10.h),
          // RESEND OTP BUTTON
          Obx(
            () => Material(
              color: Colors.transparent,
              child: CommonSqTextButton(
                onTap: kAuthController.isLoading.value ? null : () {},
                name: "Resend OTP",
                isSelected: false,
                color: kAuthController.isLoading.value
                    ? grey128Color
                    : Colors.blue,
              ),
            ),
          ),

          SizedBox(height: 45.h),
        ],
      ),
    );
  }

  @override
  void dispose() {
    kAuthController.timerInstance.cancel();
    super.dispose();
  }
}
