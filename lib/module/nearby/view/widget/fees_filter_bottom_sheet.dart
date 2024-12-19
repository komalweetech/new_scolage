// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:get/get.dart';
import '../../../../utils/collegedatalist.dart';
import '../../../../utils/commonWidget/common_bottom_sheet_title.dart';
import '../../../../utils/constant/asset_icons.dart';
import '../../../../utils/size/app_sizing.dart';
import '../../../../utils/theme/common_color.dart';
import '../../dependencies/nearby_dependencies.dart';
import 'clear_and_apply_button_row.dart';

import 'fees_list_widget.dart';

class FeesFilterBottomSheet extends StatefulWidget {
  const FeesFilterBottomSheet({super.key,required this.onFeesSelected,required this.onApplyFilter});
  final void Function(String)? onFeesSelected;
  final void Function(List<dynamic>)? onApplyFilter;

  @override
  State<FeesFilterBottomSheet> createState() => _FeesFilterBottomSheetState();
}

class _FeesFilterBottomSheetState extends State<FeesFilterBottomSheet> {
  final List<dynamic> feesList = AllCollegeData.collegeDataList["subject"] ?? [];
  final List<Map<String,dynamic>> filterFeesList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("feesList == ${feesList}");
    print("all fees data lungth == ${feesList.length}");

  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kScreenHeight(context) / 2.4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonBottomSheetTitle(name: "College Fees"),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  SizedBox(height: 5.h),
                  // FEE RANGE LIST
                  // FeesListWidget(onFeesSelected: widget.onFeesSelected,),
                  FeesListWidget(onFeesSelected: (selectedFees) {
                    widget.onFeesSelected?.call(selectedFees);
                  },),
                  SizedBox(height: 24.h),
                  // FEES RANGE
                  Row(
                    children: [
                      SizedBox(width: 5.w),
                      Text(
                        "Fee range",
                        style: const TextStyle(
                          fontSize: 20,fontFamily: "Poppins",fontWeight: FontWeight.w600
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Obx(
                                () => Text(
                              "${kNearbyController.feesRangeStartValue.value.toInt()}-${kNearbyController.feesRangeEndValue.value.toInt()}",
                              style: const TextStyle(fontSize: 20,fontFamily: "Poppins",
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 20.w),
                    ],
                  ),
                  // SLIDER WIDGET
                  Container(
                    alignment: Alignment.centerLeft,
                    child: FlutterSlider(
                      touchSize: 06,
                      values: [
                        kNearbyController.feesRangeStartValue.value,
                        kNearbyController.feesRangeEndValue.value
                      ],
                      rangeSlider: true,
                      max: 1100000,
                      //for testing value
                      min: 10000,
                      step: FlutterSliderStep(step: 500),
                      jump: true,
                      trackBar: FlutterSliderTrackBar(
                        activeTrackBarHeight: 2,
                        activeTrackBar: BoxDecoration(color: Colors.black),
                        activeDisabledTrackBarColor: grey128Color,
                      ),
                      tooltip: FlutterSliderTooltip(
                        textStyle:
                        TextStyle(fontSize: 12.sp, color: Colors.white),
                        boxStyle: FlutterSliderTooltipBox(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.black,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                        ),
                      ),
                      handler: FlutterSliderHandler(
                        decoration: BoxDecoration(),
                        child: Image.asset(
                          AssetIcons.RANGE_SLIDER_HANDLE_ICON,
                          height: 20.h,
                        ),
                      ),
                      rightHandler: FlutterSliderHandler(
                        decoration: BoxDecoration(),
                        child: Image.asset(
                          AssetIcons.RANGE_SLIDER_HANDLE_ICON,
                          height: 20.h,
                        ),
                      ),
                      onDragging: (handlerIndex, lowerValue, upperValue) {
                        kNearbyController.feesRangeStartValue.value = lowerValue;
                        kNearbyController.feesRangeEndValue.value = upperValue;
                      },
                    ),
                  ),

                  // CLEAR AND APPLY BUTTON
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: ClearAndApplyButtonRow(
                        onClearButtonTap: () {
                          kNearbyController.clearFeesBottomSheetValue();
                          setState(() {});
                        },
                        onApplyButtonTap: () {
                          // This code is get slider fees range value.
                          if (kNearbyController.selectedFeeRangeChipList.isEmpty) {
                            // get min/start  fees in this code.
                            String startValue = kNearbyController.feesRangeStartValue.value.toString();
                            double parsedValue = double.tryParse(startValue) ?? 0.0;
                            kNearbyController.minFee.value = parsedValue.round();
                            print("startvalue = $startValue");
                            print("parsedValue = $parsedValue");


                            // Get max/end value in this cide.
                            String endValue = kNearbyController.feesRangeEndValue.value.toString();
                            double parsedendValue = double.tryParse(endValue) ?? 0.0;
                            print("endvalue = $endValue");
                            print("parsedendValue = $parsedendValue");
                            kNearbyController.maxFee.value = parsedendValue.round();

                          } else {
                            // This code is get fees Range in select fees in box.
                            kNearbyController.minFee.value = int.parse(kNearbyController.selectedFeeRangeChipList.first.split("-").first);
                            print("minFees = ${kNearbyController.minFee.value }");
                            kNearbyController.maxFee.value = int.parse(kNearbyController.selectedFeeRangeChipList.first.split("-").last);
                            print("maxfees = ${ kNearbyController.maxFee.value}");
                          }
                          if (widget.onFeesSelected != null) {
                            widget.onFeesSelected!("${kNearbyController.minFee.value}-${kNearbyController.maxFee.value}",);
                            print("select fee value = ${"${kNearbyController.minFee.value}-${kNearbyController.maxFee.value}"}");

                            // Get filter in Range vise..
                            filterFeesList.clear();
                            for (var i = 0; i < feesList.length; i++) {
                              int minFees = int.tryParse(feesList[i]["minFees"].toString()) ?? 0;
                              int maxFees = int.tryParse(feesList[i]["maxFees"].toString()) ?? 0;

                              if (minFees >= kNearbyController.minFee.value &&
                                  maxFees <= kNearbyController.maxFee.value) {
                                // filterFeesList.add(feesList[i]);
                                filterFeesList.add({
                                  "collegeid": feesList[i]["collegeid"],
                                  "minFees": minFees,
                                  "maxFees": maxFees,
                                });
                              }
                            }
                            print("final filter fees  == $filterFeesList");
                            print("final filter lungth == ${filterFeesList.length}");
                            if (widget.onApplyFilter != null) {
                              widget.onApplyFilter!(filterFeesList);
                              print("final filter == $filterFeesList");
                            } else {
                              Center(child: Text("Any college not available for ${widget.onFeesSelected}"),);
                            }

                          }

                          log("${kNearbyController.minFee.value} ${kNearbyController.maxFee.value}");
                          kNearbyController.update();
                          Navigator.pop(context);

                        },
                      ),
                    ),
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
