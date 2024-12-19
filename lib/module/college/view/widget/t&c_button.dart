import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/theme/common_color.dart';

class TAndCButton extends StatelessWidget {
  const TAndCButton(
      {super.key,
      required this.name,
      required this.isSelected,
      required this.onTap});
  final String name;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 6.h),
            height: 18.h,
            width: 18.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3.r),
              border: Border.all(
                color: kPrimaryColor,
              ),
            ),
            child: Center(
              child: Container(
                height: 10.h,
                width: 10.h,
                decoration: BoxDecoration(
                  color: isSelected ? kPrimaryColor : Colors.transparent,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
          SizedBox(width: 08.w),
          Expanded(
            child: Text(
              name,
              style: TextStyle(fontSize: 12.sp,fontFamily: "Poppins",fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
