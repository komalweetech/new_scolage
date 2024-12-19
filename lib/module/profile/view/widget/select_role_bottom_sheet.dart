import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../utils/enum/ui_enum.dart';
import '../../dependencies/profile_dependencies.dart';
import 'common_bottom_sheet_value_selection_tile.dart';

class SelectRoleBottomSheet extends StatelessWidget {
  const SelectRoleBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: 25.w,
            top: 22.h,
            bottom: 16.h,
            right: 25.w,
          ),
          child: const Text(
            "Parents Or Student",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
        // PARENTS .
        Obx(
          () => CommonBottomSheetValueSelectionTile(
            name: ParentsOrStudentEnum.parents.displayName,
            isSelected: kProfileController.selectedRole.value ==
                ParentsOrStudentEnum.parents,
            onTap: () {
              kProfileController.selectedRole.value =
                  ParentsOrStudentEnum.parents;
              Navigator.pop(context);
            },
          ),
        ),
        // STUDENT .
        Obx(
          () => CommonBottomSheetValueSelectionTile(
            name: ParentsOrStudentEnum.student.displayName,
            isSelected: kProfileController.selectedRole.value ==
                ParentsOrStudentEnum.student,
            onTap: () {
              kProfileController.selectedRole.value =
                  ParentsOrStudentEnum.student;
              Navigator.pop(context);
            },
          ),
        ),
        SizedBox(height: 50.h),
      ],
    );
  }
}
