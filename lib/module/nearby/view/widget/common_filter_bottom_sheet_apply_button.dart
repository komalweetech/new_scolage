import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/theme/common_color.dart';

class CommonFilterApplyBottomSheetApply extends StatelessWidget {
  const CommonFilterApplyBottomSheetApply({
    super.key,
    required this.name,
    required this.onTap,
  });
  final String name;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(100),
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 2.5.h),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(color: grey128Color, width: .5),
          ),
          child: Text(
            name,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.sp,fontFamily: "Poppins",fontWeight: FontWeight.w300
            ),
          ),
        ),
      ),
    );
  }
}
