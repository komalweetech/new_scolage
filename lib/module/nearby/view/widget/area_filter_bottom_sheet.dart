import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../utils/commonWidget/common_bottom_sheet_title.dart';
import '../../../../utils/size/app_sizing.dart';
import '../../dependencies/nearby_dependencies.dart';
import 'area_list_widget.dart';
import 'clear_and_apply_button_row.dart';

class AreaFilterBottomSheet extends StatefulWidget {
  final Function(String)? onCitySelected;


  const AreaFilterBottomSheet(
      {super.key, this.onCitySelected});

  @override
  State<AreaFilterBottomSheet> createState() => _AreaFilterBottomSheetState();
}

class _AreaFilterBottomSheetState extends State<AreaFilterBottomSheet> {
  @override
  void initState() {
    if (kNearbyController.displayAllAreaList.value == false) {
      kNearbyController.addTop5AreaInDisplayList();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kScreenHeight(context) / 2.4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CommonBottomSheetTitle(name: "Area"),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 5.h),
                  // AREA LIST
                  Expanded(
                    child: SingleChildScrollView(
                      child: AreaListWidget(
                        onCitySelected: (selectedCity) {
                          widget.onCitySelected?.call(selectedCity);
                        },
                      ),
                    ),
                  ),
                  // CLEAR AND APPLY BUTTON
                  ClearAndApplyButtonRow(
                    onClearButtonTap: () {
                      kNearbyController.clearAreaBottomSheetValue();
                      setState(() {});
                    },
                    onApplyButtonTap: () {
                      kNearbyController.reloadCollegesData();
                      Navigator.pop(context);
                      if (widget.onCitySelected == null) {
                        widget.onCitySelected!(
                            kNearbyController.selectedArea.value);
                      }
                    },
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
