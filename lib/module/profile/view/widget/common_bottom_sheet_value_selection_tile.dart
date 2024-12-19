import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/constant/asset_icons.dart';

class CommonBottomSheetValueSelectionTile extends StatelessWidget {
  const CommonBottomSheetValueSelectionTile(
      {super.key,
      required this.isSelected,
      required this.name,
      required this.onTap});
  final bool isSelected;
  final String name;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 10.h),
        child: Row(
          children: [
            Expanded(
              child: Text(
                name,
                style: const TextStyle(
                  fontSize: 20,
                  color: Color.fromRGBO(128, 128, 128, 1),
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
