import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import '../../../../utils/StudentDetails.dart';
import '../../../../utils/commonFunction/common_function.dart';
import '../../../../utils/commonWidget/common_vertical_divider.dart';
import '../../../../utils/commonWidget/status_bar_theme.dart';
import '../../../../utils/theme/common_color.dart';
import '../../dependencies/college_dependencies.dart';
import '../widget/college_detail_widget.dart';
import '../widget/college_highlights_widget.dart';
import '../widget/college_image_and_short_detail_widget.dart';
import '../widget/college_detail_screen_app_bar.dart';
import '../widget/college_management_and_staff_widget.dart';
import '../widget/college_policy_widget.dart';
import '../widget/college_safety_and_security.dart';
import '../widget/college_social_media_widget.dart';
import '../widget/college_subjects_widget.dart';
import '../widget/infrastructure_list_widget.dart';
import 'admission_form_screen.dart';
import 'fee_deatil_screen.dart';

class CollegeDetailScreen extends StatefulWidget {
  const CollegeDetailScreen({super.key,this.clgDetails, this.policy, this.eligibility, required this.clgImage,required this.clgName,
    required this.clgId,this.safety, this.courseDetails,this.staffList,this.socialDetails,this.open,this.close,this.days,
    this.clgType,this.systemType,this.academicType,this.affiliated,this.classType,this.classrooms,this.totalSeats,this.totalFloors,this.totalArea,this.clgCode,
    this.clgImageList,this.videoList,this.webSiteLink,this.clgAdd,this.location,this.description,this.more_info,this.history,
    this.feeTerms,this.collegeStatus,
  });

  final List<dynamic>? clgDetails;
  final String? policy;
  final String? eligibility;
  final String clgImage;
  final List<dynamic>? clgImageList;
  final String clgName;
  final String clgId;
  final String? clgAdd;
  final List<dynamic>? socialDetails;
  final List<dynamic>? staffList;
  final String? safety;
  final List<dynamic>? courseDetails;
  final String? open;
  final String? close;
  final String? days;
  final String? description;
  final String? more_info;
  final String? history;
  final List<dynamic>? videoList;
  final String? webSiteLink;
  final String? feeTerms;

  // College Details
  final String? clgType;
  final String? systemType;
  final String? academicType;
  final String? affiliated;
  final String? classType;
  final String? classrooms;
  final String? totalSeats;
  final String? totalFloors;
  final String? totalArea;
  final String? clgCode;
  final String? location;
  final String? collegeStatus;


  @override
  State<CollegeDetailScreen> createState() => _CollegeDetailScreenState();
}

class _CollegeDetailScreenState extends State<CollegeDetailScreen> {
  final scrollDirection = Axis.vertical;
  late AutoScrollController controller;


  @override
  void initState() {
    super.initState();
    print("222222 = ${widget.clgId}");
    print("222222 = ${widget.clgName}");

    print("student id ==== ${StudentDetails.studentId }");
    print("location from college detail screen == ${widget.location}");


    // LIST .
    controller = AutoScrollController(
        viewportBoundaryGetter: () =>
            Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
        axis: scrollDirection);

    Future.delayed(Duration.zero, () {
      controller.addListener(() {
        if (controller.position.pixels > 300) {
          kCollegeController.showTabBar.value = true;
        } else {
          kCollegeController.showTabBar.value = false;
          kCollegeController.selectedTabInt.value = 0;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return StatusBarTheme(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        body: Stack(
          children: [
            ListView(
              padding: EdgeInsets.zero,
              scrollDirection: scrollDirection,
              controller: controller,
              children: [
                // IMAGE AND BASIC DETAIL
                 CollegeImageAndShortDetailWidget(clgImage: widget.clgImage,clgName: widget.clgName,
                   clgImageList:widget.clgImageList!,clgId: widget.clgId,videoList:widget.videoList!,
                    clgType:widget.clgType ,clgAdd:widget.clgAdd ,clgCode: widget.clgCode,location: widget.location,
                 collegeStatus: widget.collegeStatus,),

                // COLLEGE DETAIL
                Visibility(
                  visible: widget.clgDetails != null && widget.clgDetails!.isNotEmpty,
                  child: AutoScrollTag(
                    key: const ValueKey(0),
                    controller: controller,
                    index: 0,
                    child: CollageDetailWidget(
                      clgDetails: widget.clgDetails,
                      clgId: widget.clgId,
                      open: widget.open,
                      close: widget.close,
                      days: widget.days,
                      description: widget.description,
                      more_info: widget.more_info,
                      history: widget.history,
                      clgType: widget.clgType,
                      academicType: widget.academicType,
                      affiliated: widget.affiliated,
                      classType: widget.classType,
                      classrooms: widget.classrooms,
                      totalSeats: widget.totalSeats,
                      totalFloors: widget.totalFloors,
                      totalArea: widget.totalArea,
                      clgCode: widget.clgCode,
                    index: 0,),
                  ),
                ),
                // INFRASTRUCTURE LIST
                AutoScrollTag(
                  key: const ValueKey(1),
                  controller: controller,
                  index: 1,
                  child: InfrastructureListWidget(CollegeId: widget.clgId,index: 1),
                ),
                // HIGHLIGHTS DETAIL
                AutoScrollTag(
                  key: const ValueKey(2),
                  controller: controller,
                  index: 2,
                  child:  CollegeHighlightWidget(clgId:  widget.clgId,index:2),
                ),
                // SAFETY AND SECURITY DETAIL
                AutoScrollTag(
                  key: const ValueKey(3),
                  controller: controller,
                  index: 3,
                  child: CollegeSafetyAndSecurityWidget(safety:widget.safety!,index: 3,),
                ),
                // MANAGEMENT & STAFF
                AutoScrollTag(
                  key: const ValueKey(4),
                  controller: controller,
                  index: 4,
                  child:  CollegeManagementAndStaffWidget(collegeId: widget.clgId, staffList: widget.staffList!,index: 4),
                ),
                // SUBJECT .
                AutoScrollTag(
                  key: const ValueKey(5),
                  controller: controller,
                  index: 5,
                  child:  CollegeSubjectsWidget(eligibility: widget.eligibility!,subjectList: widget.courseDetails,collegeId: widget.clgId,index:5),
                ),
                // SOCIAL MEDIA
                AutoScrollTag(
                  key: const ValueKey(6),
                  controller: controller,
                  index: 6,
                  child:  CollegeSocialMediaWidget(socialDetails: widget.socialDetails,collegeId: widget.clgId,index:6),
                ),
                // POLICY .
                AutoScrollTag(
                  key: const ValueKey(7),
                  controller: controller,
                  index: 7,
                  child:  CollegePolicyWidget(policy: widget.policy!,collegeId: widget.clgId,index:7),
                ),
              ],
            ),
            // APPBAR .
            CollegeDetailScreenAppBar(controller: controller,clgList: widget.clgDetails!,clgId: widget.clgId,webSiteLink: widget.webSiteLink,),
          ],
        ),
        bottomNavigationBar: SafeArea(
          minimum: EdgeInsets.only(bottom: 16.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CommonDivider(thickness: .7),
              Padding(
                padding: EdgeInsets.only(left: 35.w, right: 35.w, top: 16.h),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Fee’s",
                            style: TextStyle(fontSize: 12.sp,fontFamily: "Poppins",),
                          ),
                          InkWell(
                            onTap: () {
                              CommonFunction.kNavigatorPush(
                                  context,  FeeDetailScreen(eligibility: widget.eligibility,feeTerms: widget.feeTerms ,clgId: widget.clgId,));
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "10,000 to 35,000 INRv",
                                  style: TextStyle(fontSize: 14.sp,fontFamily: "Poppins",fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  "For More Details ",
                                  style: TextStyle(
                                      color: kPrimaryColor,
                                      fontSize: 10.sp,fontFamily: "Poppins",
                                      decoration: TextDecoration.underline,
                                      decorationColor: kPrimaryColor),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(8.r),
                      onTap: () {
                        CommonFunction.kNavigatorPush(context,
                            AdmissionForm(collegeName: widget.clgName,subjectName: widget.courseDetails!, collegeId: widget.clgId,collegeImage: widget.clgImage,));
                      },
                      child: Container(
                        padding: EdgeInsets.fromLTRB(10.w, 8.h, 10.w, 10.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          // boxShadow: [
                          //   BoxShadow(
                          //     color: Colors.grey.withOpacity(.7),
                          //     offset: Offset(2, 3),
                          //     spreadRadius: 1,
                          //     blurRadius: 6,
                          //   )
                          // ],
                          color: kPrimaryColor,
                        ),
                        child: Text(
                          "APPLY NOW",
                          style: TextStyle(
                              color: commonYellowColor, fontSize: 14.sp,fontFamily: "Poppins",fontWeight: FontWeight.w700),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
