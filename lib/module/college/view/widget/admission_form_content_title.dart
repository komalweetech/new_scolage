import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/theme/common_color.dart';

class AdmissionFormContentTitle extends StatelessWidget {
  const AdmissionFormContentTitle({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20.h),
      padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 6.w),
      decoration: BoxDecoration(
        color: commonYellowColor,
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Center(
        child: Text(title,style: TextStyle(fontFamily: "Poppins",fontWeight: FontWeight.w500),),
      ),
    );
  }
}
