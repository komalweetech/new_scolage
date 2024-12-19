import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/theme/common_color.dart';

class NearbyScreenTab extends StatelessWidget {
  const NearbyScreenTab(
      {super.key, required this.onTap, required this.name, required this.icon});
  final VoidCallback onTap;
  final String name;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20.r),
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.h),
        decoration: BoxDecoration(
          border: Border.all(color: grey128Color),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 6.h),
              child: Text(
                name,
                style: TextStyle(color: grey128Color, fontSize: 16.sp,fontFamily: "Poppins",fontWeight: FontWeight.w300),
              ),
            ),
            SizedBox(width: 6.w),
            Image.asset(icon, height: 7.h, color: grey128Color),
          ],
        ),
      ),
    );
  }
}
