import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/collegedatalist.dart';
import '../../../../utils/commonWidget/common_bottom_sheet_title.dart';
import '../../../../utils/size/app_sizing.dart';
import '../../dependencies/nearby_dependencies.dart';
import 'clear_and_apply_button_row.dart';

import 'trending_list_widget.dart';

class TrendingFilterBottomSheet extends StatefulWidget {
  const TrendingFilterBottomSheet({super.key,this.onTrendSelected,this.onApplyFilter});
  final void Function(String)? onTrendSelected;
  final void Function(List<dynamic>)? onApplyFilter;

  @override
  State<TrendingFilterBottomSheet> createState() => _TrendingFilterBottomSheetState();
}

class _TrendingFilterBottomSheetState extends State<TrendingFilterBottomSheet> {

  final List<dynamic> trendList = AllCollegeData.collegeDataList["infra"] ?? [];
  final List<Map<String,dynamic>> filterTrendList = [];

  @override
  void initState() {
    // TODO: implement initState
    if (kNearbyController.displayAllTrendingList.value == false) {
      kNearbyController.addTop5TrendingInDisplayList();
    }
    super.initState();
    print("trendList == ${trendList}");
    print("all trend data lungth == ${trendList.length}");
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kScreenHeight(context) / 2.4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CommonBottomSheetTitle(name: "Trending"),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 5.h),
                  // TRENDING LIST
                  Expanded(
                    child: SingleChildScrollView(
                      child: TrendingListWidget(onTrendSelected: widget.onTrendSelected),
                    ),
                  ),
                  // CLEAR AND APPLY BUTTON
                  ClearAndApplyButtonRow(
                    onClearButtonTap: () {
                      kNearbyController.clearTrendingBottomSheetValue();
                      setState(() {});
                    },
                    onApplyButtonTap: ()  {
                      if (widget.onTrendSelected != null) {
                        String selectedTrendKey = kNearbyController.selectedTrend.value;
                        widget.onTrendSelected!(kNearbyController.selectedTrend.value);

                        // Get filter Trend List.
                        filterTrendList.clear();
                        for(var i = 0; trendList.length > i; i++){
                          if( trendList[i]["$selectedTrendKey"] == true){
                            filterTrendList.add({
                              "collegeid": trendList[i]["collegeid"],
                            });
                          }
                        }
                        if (widget.onApplyFilter != null) {
                          widget.onApplyFilter!(filterTrendList);
                        }
                        log("${filterTrendList}");
                        kNearbyController.update();
                        Navigator.pop(context);
                        print("select infra value == $selectedTrendKey");
                        print("filter Trend = $filterTrendList");
                        print("filter trend lungth == ${filterTrendList.length}");
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
