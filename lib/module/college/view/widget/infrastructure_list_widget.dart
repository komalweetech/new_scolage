// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../utils/collegedatalist.dart';
import '../../../../utils/constant/asset_icons.dart';
import '../../../nearby/model/infrastructure_model.dart';
import '../../dependencies/college_dependencies.dart';
import 'detail_on_off_button.dart';

class InfrastructureListWidget extends StatefulWidget {
  const InfrastructureListWidget({super.key,required this.CollegeId,required this.index});
  final String CollegeId;
  final int index;

  @override
  State<InfrastructureListWidget> createState() =>
      _InfrastructureListWidgetState();
}

class _InfrastructureListWidgetState extends State<InfrastructureListWidget> {
  RxBool showInfrastructureDetails = false.obs;
  List<dynamic> infrastructureList = [];
  List<dynamic> infraList = [];
  List<dynamic> clgInfraList = [];
  List<dynamic> subInfraList =[];




  @override
  void initState() {
    super.initState();

    // Attempt to get infra data, handle potential errors
    try {
      var allInfra = AllCollegeData.collegeDataList["infra"];
      if (allInfra is List<dynamic>) {
        infraList = allInfra;
      } else {
        print("Warning: 'infra' data is not a List.");
        infraList = []; // Initialize as empty list if data is wrong type
      }
    } catch (e) {
      print("Error accessing infra data: $e");
      infraList = []; // Initialize as empty list on error
    }

    print("All infra data count: ${infraList.length}");

    // Filter for the current college ID
    clgInfraList = infraList.where((infra) => infra["collegeid"] == widget.CollegeId).toList();
    print("Filtered infra data for college ${widget.CollegeId}: ${clgInfraList.length}");

    // No need to modify infrastructureList here, we'll use clgInfraList in build
  }

  @override
  Widget build(BuildContext context) {
    // Check if clgInfraList has data
    final hasInfraData = clgInfraList.isNotEmpty;
    Map<String, dynamic>? currentInfraData = hasInfraData ? clgInfraList[0] : null;

    // Create the list of InfraModel only if data exists
    List<InfraModel> infrastructureDisplayList = [];
    if (hasInfraData && currentInfraData != null) {
      infrastructureDisplayList = [
        InfraModel(name: "Smart Class", icon: AssetIcons.INFRA_SMART_CLASS_ICON, value: currentInfraData["smartclass"] ?? false),
        InfraModel(name: "Library", icon: AssetIcons.INFRA_LIBRARY_ICON, value: currentInfraData["library"] ?? false),
        InfraModel(name: "Parking", icon: AssetIcons.INFRA_PARKING_ICON, value: currentInfraData["parking"] ?? false),
        InfraModel(name: "Hostel", icon: AssetIcons.INFRA_PARKING_ICON, value: currentInfraData["hostel"] ?? false),
        InfraModel(name: "Elevator", icon: AssetIcons.INFRA_ELEVATOR_ICON, value: currentInfraData["elevator"] ?? false),
        InfraModel(name: "Auditorium", icon: AssetIcons.INFRA_AUDITORIUM_ICON, value: currentInfraData["auditorium"] ?? false),
        InfraModel(name: "Power Backup", icon: AssetIcons.INFRA_POWER_BACKUP_ICON, value: currentInfraData["powerbackup"] ?? false),
        InfraModel(name: "CCTV", icon: AssetIcons.INFRA_CCTV_ICON, value: currentInfraData["cctv"] ?? false),
        InfraModel(name: "Computer lab", icon: AssetIcons.INFRA_COMPUTER_LAB_ICON, value: currentInfraData["computerlab"] ?? false),
        InfraModel(name: "Canteen", icon: AssetIcons.INFRA_CANTEEN_ICON, value: currentInfraData["canteen"] ?? false),
        InfraModel(name: "Fire Safety", icon: AssetIcons.INFRA_FIRE_SAFETY_ICON, value: currentInfraData["firesafety"] ?? false),
        InfraModel(name: "Play Ground", icon: AssetIcons.INFRA_PLAY_GROUND_ICON, value: currentInfraData["playground"] ?? false),
        InfraModel(name: "Medical Support", icon: AssetIcons.INFRA_MEDICAL_SUPPORT_ICON, value: currentInfraData["medicalsupport"] ?? false),
        InfraModel(name: "Bus Transport", icon: AssetIcons.INFRA_BUS_TRANSPORT_ICON, value: currentInfraData["bustransport"] ?? false),
        InfraModel(name: "Emergency Exit", icon: AssetIcons.INFRA_EMERGENCY_EXIT_ICON, value: currentInfraData["emergencyexit"] ?? false),
      ];
    }

    // Filter the list to only include items where value is true
    final filteredDisplayList = infrastructureDisplayList.where((item) => item.value == true).toList();

    return Column(
      children: [
        Obx( () => DetailOnOffButton(
            name: "Infrastructure",
            isDetailDisplayed: kCollegeController.sectionVisibility[widget.index].value,
            onTap: () {
              kCollegeController.expandDetailWhenTapOnTab(widget.index);
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 35.w),
          child: Obx(
                () => Visibility(
              visible: kCollegeController.sectionVisibility[widget.index].value,
              child: hasInfraData && filteredDisplayList.isNotEmpty
                  ? GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(vertical: 14.h),
                itemCount: filteredDisplayList.length, // Use filtered list length
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisExtent: 35,
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          filteredDisplayList[index].icon,
                          color: const Color.fromRGBO(237, 50, 50, 1),
                          height: 16.h,
                          width: 20.h,
                        ),
                        SizedBox(width: 5.w),
                        Expanded(
                            child: Text(
                              filteredDisplayList[index].name,
                              style: TextStyle(fontSize: 13.sp,fontFamily: "Poppins",
                              ),
                            )),
                      ],
                    ),
                  );
                },
              )
                  : Padding(
                padding: EdgeInsets.symmetric(vertical: 15.h),
                child: Column(
                  children: [
                    Text(
                      "Infrastructure details are not available.",
                      style: TextStyle(fontSize: 16.sp, color: Colors.black),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      "Please check back later for updates.",
                      style: TextStyle(fontSize: 14.sp, color: Colors.grey),
                    ),
                  ],
                ),
              ), // End of Padding (else case)
            ), // End of Visibility
          ), // End of Obx
        ), // End of Padding
        SizedBox(height: 20.h),
      ], // End of Outer Column
    ); // End of build method Column
  } // End of build method
} // End of State class
