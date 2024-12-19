import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../utils/commonWidget/common_sq_text_button.dart';
import '../../../../utils/theme/common_color.dart';
import '../../dependencies/nearby_dependencies.dart';
import 'common_filter_sheet_chip.dart';

class TrendingListWidget extends StatefulWidget {
  const TrendingListWidget({super.key,this.onTrendSelected});
  final Function(String)? onTrendSelected;

  @override
  State<TrendingListWidget> createState() => _TrendingListWidgetState();
}

class _TrendingListWidgetState extends State<TrendingListWidget> {
  @override
  Widget build(BuildContext context) {
    return Obx(
          () => Wrap(
        spacing: 14.w,
        runSpacing: 14.h,
        children: List.generate(
          kNearbyController.displayTrendingList.length + 1, (index) {
            String data = '';
            if (index != kNearbyController.displayTrendingList.length) {
              data = kNearbyController.displayTrendingList[index];
            }

            return index == kNearbyController.displayTrendingList.length
            // CLEAR BUTTON
                ? Column(
              children: [
                Obx(
                      () => Row(
                    children: [
                      CommonSqTextButton(
                        onTap: () {
                          if (kNearbyController.displayAllTrendingList.value) {
                            kNearbyController.displayAllTrendingList.value = false;
                            kNearbyController.addTop5TrendingInDisplayList();
                          } else {
                            kNearbyController.displayAllTrendingList.value = true;
                            kNearbyController.addAllTrendingIntoDisplayTrendingList();
                          }
                        },
                        name: kNearbyController.displayAllTrendingList.value
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
                  list: kNearbyController.selectedTrendingList,
                  onTap: () {
                    setState(() {
                      kNearbyController.selectedTrend.value = data;
                      print("bottom sheet trendList = ${kNearbyController.selectedTrend}");
                      widget.onTrendSelected!.call(data);
                    });
                  },
                  onDeselect: () {},
                );
              },
              isSelected: kNearbyController.isThisValueSelected(
                value: data,
                list: kNearbyController.selectedTrendingList,
              ),
            );
            // : CommonFilterSheetChip(
            //     name: data,
            //     onTap: () {
            //       if (kNearbyController.isThisValueSelected(
            //         value: data,
            //         list: kNearbyController.selectedTrendingList,
            //       )) {
            //         // REMOVE FROM LIST
            //         kNearbyController.selectedTrendingList.remove(data);
            //       } else {
            //         // ADD TO LIST
            //         kNearbyController.selectedTrendingList.add(data);
            //       }
            //       setState(() {});
            //     },
            //     isSelected: kNearbyController.isThisValueSelected(
            //       value: data,
            //       list: kNearbyController.selectedTrendingList,
            //     ),
            //   );
          },
        ),
      ),
    );
  }
}
