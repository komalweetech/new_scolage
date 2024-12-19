import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../utils/commonWidget/common_sq_text_button.dart';
import '../../../../utils/theme/common_color.dart';
import '../../dependencies/nearby_dependencies.dart';
import 'common_filter_sheet_chip.dart';

class AreaListWidget extends StatefulWidget {
  const AreaListWidget({super.key, this.onCitySelected} );
  final void Function(String)? onCitySelected;

  @override
  State<AreaListWidget> createState() => _AreaListWidgetState();
}

class _AreaListWidgetState extends State<AreaListWidget> {
  @override
  Widget build(BuildContext context) {
    return Obx(
          () => Wrap(
        spacing: 14.w,
        runSpacing: 14.h,
        children: List.generate(
          kNearbyController.displayAreaList.length + 1,
              (index) {
            String data = '';
            if (index != kNearbyController.displayAreaList.length) {
              data = kNearbyController.displayAreaList[index];
            }

            return index == kNearbyController.displayAreaList.length
            // CLEAR BUTTON
                ? Column(
              children: [
                Obx(() => Row(
                    children: [
                      CommonSqTextButton(
                        onTap: () {
                          if (kNearbyController.displayAllAreaList.value) {
                            kNearbyController.displayAllAreaList.value = false;
                            kNearbyController.addTop5AreaInDisplayList() ;
                            // kNearbyController.addTop5AreaInDisplayList();
                          } else {
                            kNearbyController.displayAllAreaList.value = true;
                            kNearbyController.addAllAreaIntoDisplayAreaList();
                          }
                        },
                        name: kNearbyController.displayAllAreaList.value
                            ? "Show less..."
                            : "Show more...",
                        isSelected: false,
                        color: kPrimaryColor,
                      ),
                    ],
                  ),
                ),
              ],
            )
                : CommonFilterSheetChip(
              name: data,
              onTap: () {
                kNearbyController.selectValueAndDeselectOthers(
                  value: data,
                  list: kNearbyController.selectedAreaList,
                  onTap: () {
                    kNearbyController.selectedArea.value = data;
                    print("bottom sheet area List == ${kNearbyController.selectedAreaList}");
                    widget.onCitySelected!.call(data);
                    setState(() {});
                  },
                  onDeselect: () {},
                );
              },
              isSelected: kNearbyController.isThisValueSelected(
                value: data,
                list: kNearbyController.selectedAreaList,
              ),
            );
          },
        ),
      ),
    );
  }
}
