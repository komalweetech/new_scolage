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
    // TODO: implement initState
    super.initState();

    infrastructureList.add(AllCollegeData.collegeDataList["infra"]);
    print("your infra data is = $infrastructureList}");

    infraList = infrastructureList[0];
    print("infra data ==== $infraList");
    // ClgInfraData.fetchData() ;
    print("data ==== $infraList");


    for(int i = 0; i < infraList.length; i++ ) {
      print("college ids == ${infraList[i]["collegeid"]} and wid id == ${widget.CollegeId}");
      if(widget.CollegeId == infraList[i]["collegeid"]) {
        print("college ids in inner if == ${infraList[i]["collegeid"]}");
       clgInfraList.add(infraList[i]);
      }
    }
    infrastructureList[0] = clgInfraList[0];
    print("infra data filtered  ==== ${clgInfraList}");

  }

  @override
  Widget build(BuildContext context) {
    List<InfraModel> infrastructureList = [
      InfraModel(name: "Smart Class", icon: AssetIcons.INFRA_SMART_CLASS_ICON,value: clgInfraList[0]["smartclass"]),
      InfraModel(name: "Library", icon: AssetIcons.INFRA_LIBRARY_ICON,value: clgInfraList[0]["library"]),
      InfraModel(name: "Parking", icon: AssetIcons.INFRA_PARKING_ICON,value: clgInfraList[0]["parking"]),
      InfraModel(name: "Hostel", icon: AssetIcons.INFRA_PARKING_ICON,value: clgInfraList[0]["hostel"]),
      InfraModel(name: "Elevator", icon: AssetIcons.INFRA_ELEVATOR_ICON,value: clgInfraList[0]["elevator"]),
      InfraModel(name: "Auditorium", icon: AssetIcons.INFRA_AUDITORIUM_ICON,value: clgInfraList[0]["auditorium"]),
      InfraModel(name: "Power Backup", icon: AssetIcons.INFRA_POWER_BACKUP_ICON,value: clgInfraList[0]["powerbackup"]),
      InfraModel(name: "CCTV", icon: AssetIcons.INFRA_CCTV_ICON,value: clgInfraList[0]["cctv"]),
      InfraModel(name: "Computer lab", icon: AssetIcons.INFRA_COMPUTER_LAB_ICON,value: clgInfraList[0]["computerlab"]),
      InfraModel(name: "Canteen", icon: AssetIcons.INFRA_CANTEEN_ICON,value: clgInfraList[0]["canteen"]),
      InfraModel(name: "Fire Safety", icon: AssetIcons.INFRA_FIRE_SAFETY_ICON,value: clgInfraList[0]["firesafety"]),
      InfraModel(name: "Play Ground", icon: AssetIcons.INFRA_PLAY_GROUND_ICON,value: clgInfraList[0]["playground"]),
      InfraModel(name: "Medical Support", icon: AssetIcons.INFRA_MEDICAL_SUPPORT_ICON,value: clgInfraList[0]["medicalsupport"]),
      InfraModel(name: "Bus Transport", icon: AssetIcons.INFRA_BUS_TRANSPORT_ICON,value: clgInfraList[0]["bustransport"]),
      InfraModel(name: "Emergency Exit", icon: AssetIcons.INFRA_EMERGENCY_EXIT_ICON,value: clgInfraList[0]["emergencyexit"]),
    ];


    return Column(
      children: [
        Obx( () => DetailOnOffButton(
            name: "Infrastructure",
            isDetailDisplayed: kCollegeController.sectionVisibility[widget.index].value,
            // isDetailDisplayed: showInfrastructureDetails.value,
            onTap: () {
              kCollegeController.expandDetailWhenTapOnTab(widget.index);
             //  setState(() {
             // showInfrastructureDetails.value = !showInfrastructureDetails.value;
             //  });
              },
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 35.w),
          child: Obx(
                () => Visibility(
                  visible:kCollegeController.sectionVisibility[widget.index].value,
              child: infrastructureList != null && infraList.isNotEmpty ?
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(vertical: 14.h),
                itemCount: infrastructureList.where((item) => item.value == true).length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisExtent: 35,
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (BuildContext context, int index) {
                  final filteredList = infrastructureList.where((item) => item.value == true).toList();
                  return Container(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          filteredList[index].icon,
                          color: const Color.fromRGBO(237, 50, 50, 1),
                          height: 16.h,
                          width: 20.h,
                        ),
                        SizedBox(width: 5.w),
                        Expanded(
                            child: Text(
                              filteredList[index].name,
                              style: TextStyle(fontSize: 13.sp,fontFamily: "Poppins",
                              ),
                            )),
                      ],
                    ),
                  );

                },
              ) :
              Padding(padding: EdgeInsets.symmetric(vertical: 15.h),
                child: Column(
                  children: [
                    Text(
                      "Infrastructure  details are not available.",
                      style: TextStyle(fontSize: 16.sp, color: Colors.black),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      "Please check back later for updates.",
                      style: TextStyle(fontSize: 14.sp, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 20.h),
      ],
    );
  }
}
