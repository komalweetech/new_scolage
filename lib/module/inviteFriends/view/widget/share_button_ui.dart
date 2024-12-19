import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShareButtonUi extends StatelessWidget {
  const ShareButtonUi(
      {super.key,
      required this.name,
      required this.icon,
      required this.onTap,
      this.centerPadding});

  final String name;
  final Widget icon;
  final VoidCallback onTap;
  final double? centerPadding;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              icon,
              SizedBox(height: centerPadding ?? 7.h),
              Text(
                name,
                style: TextStyle(fontSize: 10.sp, fontFamily: "Poppins"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
