import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonScreenContentTitle extends StatelessWidget {
  const CommonScreenContentTitle(
      {super.key, required this.title, this.padding});
  final String title;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ??
          EdgeInsets.only(
            left: 20.w,
            right: 10.h,
            top: 30,
          ),
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 28,fontWeight: FontWeight.w700,fontFamily: "Poppins",
          ),
        ),
      ),
    );
  }
}
