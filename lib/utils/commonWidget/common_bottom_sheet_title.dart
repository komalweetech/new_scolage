import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonBottomSheetTitle extends StatelessWidget {
  const CommonBottomSheetTitle({super.key, required this.name});
  final String name;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 25.w,
        top: 22.h,
        bottom: 16.h,
        right: 25.w,
      ),
      child: Text(
        name,
        style: const TextStyle(
          fontSize: 20,fontFamily: "Poppins",fontWeight: FontWeight.w600
        ),
      ),
    );
  }
}
