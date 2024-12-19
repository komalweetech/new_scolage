import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../utils/theme/common_color.dart';

class OTPField extends StatelessWidget {
  const OTPField({super.key, required this.onChange});
  final void Function(String value) onChange;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: PinCodeTextField(
        keyboardType: TextInputType.number,
        length: 6,
        obscureText: false,
        animationType: AnimationType.fade,
        textStyle: const TextStyle(color: grey128Color),
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(6.r),
          fieldHeight: 48.h,
          fieldWidth: 45.h,
          borderWidth: .7,
          activeColor: grey128Color,
          selectedFillColor: Colors.white,
          disabledColor: Colors.white,
          inactiveColor: grey128Color,
          inactiveFillColor: Colors.white,
          errorBorderColor: grey128Color,
          activeFillColor: Colors.transparent,
        ),
        animationDuration: const Duration(milliseconds: 0),
        enableActiveFill: true,
        controller: TextEditingController(),
        onChanged: onChange,
        appContext: context,
      ),
    );
  }
}
