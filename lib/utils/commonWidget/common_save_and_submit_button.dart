import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/common_color.dart';

class CommonSaveAndSubmitButton extends StatelessWidget {
  const CommonSaveAndSubmitButton(
      {super.key, required this.name, required this.onTap, this.padding});
  final String name;
  final VoidCallback onTap;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.symmetric(horizontal: 20.w),
      child: Material(
        color: kPrimaryColor,
        borderRadius: BorderRadius.circular(8.r),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8.r),
          child: SizedBox(
            width: double.infinity,
            height: 55.h,
            child: Center(
              child: Text(
                name,
                style: TextStyle(
                  fontSize: 17.5.sp,
                  color: Colors.white,fontFamily: "Poppins",fontWeight: FontWeight.w600
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
