// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../utils/commonWidget/common_bottom_sheet_title.dart';
import '../../../../utils/commonWidget/common_sq_text_button.dart';
import '../../../../utils/commonWidget/common_vertical_divider.dart';
import '../../../../utils/size/app_sizing.dart';
import '../../../../utils/theme/common_color.dart';
import '../../../home/model/college_data.dart';
import '../../dependencies/nearby_dependencies.dart';
import 'area_list_widget.dart';
import 'fees_list_widget.dart';
import 'infra_list_widget.dart';

class AllFilterBottomSheet extends StatefulWidget {
  const AllFilterBottomSheet({super.key, this.collegeData});

  final CollegeData? collegeData;

  @override
  State<AllFilterBottomSheet> createState() => _AllFilterBottomSheetState();
}

class _AllFilterBottomSheetState extends State<AllFilterBottomSheet> {

  @override
  void initState() {
    print("Initializing AllFilterBottomSheet...");
    print("collegeData: ${widget.collegeData}");


    if (kNearbyController.displayAllAreaList.value == false) {
      kNearbyController.addTop5AreaInDisplayList();
    }
    if (kNearbyController.displayAllTrendingList.value == false) {
      kNearbyController.addTop5TrendingInDisplayList();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kScreenHeight(context) - 85.h,
      child: Column(
        children: [
          SizedBox(height: 10.h),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //! AREA
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const CommonBottomSheetTitle(name: "Area"),
                      Spacer(),
                      Padding(
                        padding: EdgeInsets.only(top: 6.h),
                        // CLEAR ALL BUTTON
                        child: CommonSqTextButton(
                          onTap: () {
                            kNearbyController.clearAllFilterValue();
                            setState(() {});
                          },
                          name: "Clear All",
                          isSelected: false,
                          color: kPrimaryColor,
                          fontSize: 13.sp,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: AreaListWidget(
                      onCitySelected: (selectedArea) {
                      kNearbyController.selectedArea.value = selectedArea;
                      setState(() {});
                      print("all filter screen select city == $selectedArea}");

                    },),
                  ),

                  //! FEES
                  const CommonBottomSheetTitle(name: "College Fees"),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: FeesListWidget(onFeesSelected: (selectedFees) {
                      kNearbyController.selectedFees.value = selectedFees;
                      setState(() {});
                      print("all filter screen select Infra = $selectedFees");

                    },),
                  ),

                  //! SORT BY
                  // const CommonBottomSheetTitle(name: "Sort by"),
                  // ShortByListWidget(isOpenFromAllFilter: true),

                  //! TRENDING
                  // const CommonBottomSheetTitle(name: "Trending"),
                  // Padding(
                  //   padding: EdgeInsets.symmetric(horizontal: 20.w),
                  //   child: TrendingListWidget(),
                  // ),

                  //! INFRASTRUCTURE

                  const CommonBottomSheetTitle(name: "Infrastructure"),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: InfraListWidget(onInfraSelected: (selectedInfra) {
                      kNearbyController.selectedTrend.value = selectedInfra;
                      setState(() {});
                      print("all filter screen select Infra = $selectedInfra");
                    },),
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ),
          CommonDivider(thickness: .6),
          SizedBox(height: 6.h),

          // SHOW BUTTON
          SafeArea(
            minimum: EdgeInsets.only(bottom: 16.h),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(100),
                  onTap: () {
                    if (kNearbyController.selectedFeeRangeChipList.isNotEmpty) {
                      kNearbyController.minFee.value = int.parse(
                        kNearbyController.selectedFeeRangeChipList.first.split("-").first,
                      );
                      kNearbyController.maxFee.value = int.parse(
                        kNearbyController.selectedFeeRangeChipList.first.split("-").last,
                      );
                    } else {
                      // Handle the case when the list is empty, set default values or take appropriate action.
                      kNearbyController.minFee.value = 0;
                      kNearbyController.maxFee.value = 0;
                    }

                    kNearbyController.filteredColleges.value =
                        kNearbyController.filterColleges(
                          widget.collegeData!.college!,
                          widget.collegeData!.subject!,
                          // kNearbyController.selectedSortBy.value != null
                          //     ? kNearbyController.selectedSortBy.value!.displayName.isNotEmpty
                          //     ? kNearbyController.selectedSortBy.value!.displayName : null : null,
                          widget.collegeData!.infra!,
                          kNearbyController.selectedAreaList.isNotEmpty ? kNearbyController.selectedAreaList.first : null,
                          kNearbyController.minFee.value,
                          kNearbyController.maxFee.value,
                          kNearbyController.selectedInfrastructureList.isNotEmpty
                              ? kNearbyController.selectedInfrastructureList.first.name.isNotEmpty ? kNearbyController.selectedInfrastructureList.first.name : null : null,
                        );

                    kNearbyController.reloadCollegesData();
                    log("Filtered Colleges length: ${kNearbyController.filteredColleges.length}");
                    Navigator.pop(context, kNearbyController.filteredColleges.value);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(color: grey128Color, width: .5),
                    ),
                    child: Center(
                      child: Text(
                        "Show colleges",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.sp,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
