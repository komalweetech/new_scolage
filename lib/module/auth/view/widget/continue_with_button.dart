import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/theme/common_color.dart';

class ContinueWithButton extends StatelessWidget {
  const ContinueWithButton(
      {super.key, required this.name, required this.icon, required this.onTap});
  final String name;
  final String icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8.r),
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: grey88Color,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              icon,
              height: 30.h,
              width: 30.w,
            ),
            SizedBox(width: 20.w),
            Text(
              name,
              style: TextStyle(fontSize: 17.sp,fontFamily: "Poppins",fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
