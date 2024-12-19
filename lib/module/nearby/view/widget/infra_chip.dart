import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/theme/common_color.dart';
import '../../model/infrastructure_model.dart';

class InfraChip extends StatelessWidget {
  const InfraChip(
      {super.key,
        required this.infraData,
        required this.onTap,
        required this.isSelected});
  final InfrastructureModel infraData;
  final VoidCallback onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(100),
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 11.w, vertical: 2.h),
          decoration: BoxDecoration(
            color: isSelected ? Colors.black : null,
            borderRadius: BorderRadius.circular(100),
            border: Border.all(color: grey128Color, width: .5),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                infraData.icon,
                height: 16.h,
                color: isSelected ? Colors.white : grey128Color,
              ),
              SizedBox(width: 10.w),
              Text(
                infraData.name,
                style: TextStyle(
                  color: isSelected ? Colors.white : grey128Color,
                  fontSize: 14.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
