import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CollegeCategory extends StatelessWidget {
  const CollegeCategory({super.key, required this.courseName,required this.description,required this.onTap,required this.collegeId});
  final String courseName;
  final String description;
  final VoidCallback onTap;
  final String collegeId;

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 5.w,
        ),
        decoration: BoxDecoration(
            color: const Color.fromRGBO(232, 215, 233, 1),
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              courseName,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 13,fontFamily: "Poppins",fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 2.h),
            Text(
             description,
              maxLines: 2,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 9,fontFamily: "Poppins",fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
