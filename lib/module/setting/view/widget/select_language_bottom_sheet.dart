import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../utils/enum/setting_enum.dart';
import '../../../../utils/size/app_sizing.dart';
import '../../../profile/view/widget/common_bottom_sheet_value_selection_tile.dart';
import '../../dependencies/setting_dependencies.dart';

class SelectLanguageBottomSheet extends StatelessWidget {
  const SelectLanguageBottomSheet({super.key});

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
        SizedBox(
          height: kScreenHeight(context) / 3.5,
          child: ListView.builder(
            itemCount: LanguagesEnum.values.length,
            itemBuilder: (context, index) {
              LanguagesEnum data = LanguagesEnum.values[index];
              return Obx(
                () => CommonBottomSheetValueSelectionTile(
                  name: data.displayName,
                  isSelected: kSettingController.selectedLanguage.value == data,
                  onTap: () {
                    kSettingController.selectedLanguage.value = data;
                    Navigator.pop(context);
                  },
                ),
              );
            },
          ),
        ),

        SizedBox(height: 50.h),
      ],
    );
  }
}
