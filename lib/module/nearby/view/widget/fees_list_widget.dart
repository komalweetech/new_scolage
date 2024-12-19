import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/enum/nearby_screen_enum.dart';
import '../../dependencies/nearby_dependencies.dart';
import 'common_filter_sheet_chip.dart';

class FeesListWidget extends StatefulWidget {
  const FeesListWidget({super.key,this.onFeesSelected});
  final void  Function(String)? onFeesSelected;

  @override
  State<FeesListWidget> createState() => _FeesListWidgetState();
}

class _FeesListWidgetState extends State<FeesListWidget> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 14.w,
      runSpacing: 14.h,
      children: List.generate(
        FeesRangeEnum.values.length, (index) {
          FeesRangeEnum data = FeesRangeEnum.values[index];
          return CommonFilterSheetChip(
            name: data.displayName,
            onTap: () {
              print("Before: ${kNearbyController.selectedFeeRangeChipList}");

                kNearbyController.selectValueAndDeselectOthers(
                  value: data.displayName,
                  list: kNearbyController.selectedFeeRangeChipList,
                  onTap: () {
                    widget.onFeesSelected?.call(data.displayName);
                  },
                  onDeselect: () {
                    // Additional logic to perform when a chip is deselected
                  },
                );

              print("After: ${kNearbyController.selectedFeeRangeChipList}");
            },
            isSelected: kNearbyController.isThisValueSelected(
              value: data.displayName,
              list: kNearbyController.selectedFeeRangeChipList,
            ),
          );

          // return CommonFilterSheetChip(
          //   name: data.displayName,
          //   onTap: () {
          //     if (kNearbyController.isThisValueSelected(
          //       value: data.displayName,
          //       list: kNearbyController.selectedFeeRangeChipList,
          //     )) {
          //       // REMOVE FROM LIST
          //       kNearbyController.selectedFeeRangeChipList
          //           .remove(data.displayName);
          //     } else {
          //       // ADD TO LIST
          //       kNearbyController.selectedFeeRangeChipList
          //           .add(data.displayName);
          //     }
          //     setState(() {});
          //   },
          //   isSelected: kNearbyController.isThisValueSelected(
          //     value: data.displayName,
          //     list: kNearbyController.selectedFeeRangeChipList,
          //   ),
          // );
        },
      ),
    );
  }
}
