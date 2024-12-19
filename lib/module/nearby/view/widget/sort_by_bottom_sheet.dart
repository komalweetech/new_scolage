import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_scolage/module/nearby/view/widget/sort_by_list_widget.dart';

import '../../../../utils/commonWidget/common_bottom_sheet_title.dart';
import '../../../../utils/constant/asset_icons.dart';
import '../../../../utils/size/app_sizing.dart';
import '../../../../utils/theme/common_color.dart';

class SortByBottomSheet extends StatelessWidget {
  const SortByBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kScreenHeight(context) / 2.4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          CommonBottomSheetTitle(name: "Sort by"),
          Expanded(child: ShortByListWidget(isOpenFromAllFilter: false))
        ],
      ),
    );
  }
}

class SortByBottomSheetListTile extends StatelessWidget {
  const SortByBottomSheetListTile(
      {super.key,
        required this.isSelected,
        required this.name,
        required this.onTap,
        required this.icon});

  final bool isSelected;
  final String name;
  final String icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 9.h),
        child: Row(
          children: [
            SizedBox(
              height: 20.h,
              child: Image.asset(
                icon,
                color: grey128Color,
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Text(
                name,
                style: const TextStyle(
                  fontSize: 20,
                  color: grey128Color,
                ),
              ),
            ),
            Visibility(
              visible: isSelected,
              child: Center(
                child: Image.asset(
                  AssetIcons.DONE_BUTTON_ICON,
                  width: 20.w,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
