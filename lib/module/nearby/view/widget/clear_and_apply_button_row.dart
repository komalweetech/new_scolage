import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/commonWidget/common_sq_text_button.dart';
import '../../../../utils/theme/common_color.dart';
import 'common_filter_bottom_sheet_apply_button.dart';

class ClearAndApplyButtonRow extends StatelessWidget {
  const ClearAndApplyButtonRow(
      {super.key, required this.onClearButtonTap, required this.onApplyButtonTap});
  final VoidCallback onClearButtonTap;
  final VoidCallback onApplyButtonTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 20.w),
        // CLEAR ALL BUTTON
        CommonSqTextButton(
          onTap: onClearButtonTap,
          name: "Clear All",
          isSelected: false,
          color: kPrimaryColor,
        ),
        const Spacer(),
        // APPLY BUTTON
        CommonFilterApplyBottomSheetApply(
          onTap: onApplyButtonTap,
          name: "Apply",
        ),

        SizedBox(width: 14.w),
      ],
    );
  }
}
