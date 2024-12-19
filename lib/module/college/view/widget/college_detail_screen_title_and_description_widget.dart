import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/theme/common_color.dart';

class CollegeDetailScreenTitleAndDescriptionWidget extends StatelessWidget {
  const CollegeDetailScreenTitleAndDescriptionWidget(
      {super.key, required this.title, required this.description});
  final String title;
  final String description;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            title,
            style: TextStyle(color: grey102Color, fontSize: 13.sp,fontFamily: "Poppins",fontWeight: FontWeight.w700),
          ),
        ),
        SizedBox(height: 5.h),
        Text(
          description,
          style: TextStyle(color: grey88Color, fontSize: 11.sp,fontFamily: "Poppins",),
        ),
      ],
    );
  }
}
