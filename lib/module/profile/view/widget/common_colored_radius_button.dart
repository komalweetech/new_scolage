import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonColoredRadiusButton extends StatelessWidget {
  const CommonColoredRadiusButton(
      {super.key,
      required this.title,
      required this.color,
      required this.onTap});
  final String title;
  final Color color;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      borderRadius: BorderRadius.circular(30),
      child: InkWell(
        borderRadius: BorderRadius.circular(30),
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
          ),
          child: Center(child: Text(title,style: TextStyle(fontFamily: "Poppins",fontWeight: FontWeight.w600,fontSize: 13),)),
        ),
      ),
    );
  }
}
