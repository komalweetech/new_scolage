import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
// Remove import for the old controller from the parent controllers directory
// import '../../../../controllers/college_controller.dart';
import '../../../../utils/collegedatalist.dart';
import '../../../../utils/theme/common_color.dart';
// Keep import for the renamed controller file (contains definition)
import '../../controller/CollegeController.dart';
// Keep import for the dependency file (provides kCollegeController)
import '../../dependencies/college_dependencies.dart';
import '../../model/college_detail_model.dart';
import 'college_detail_screen_title_and_description_widget.dart';
import 'detail_on_off_button.dart';

class CollageDetailWidget extends StatefulWidget {
  const CollageDetailWidget({super.key,this.clgDetails,required this.clgId,this.open,this.close,this.days,
    this.clgType,this.academicType,this.affiliated,this.classType,this.classrooms,this.totalSeats,this.totalFloors,this.totalArea,this.clgCode,
    this.description,this.history,this.more_info,required this.index});
  final List<dynamic>? clgDetails;
  final String clgId;
  final String? open;
  final String? close;
  final String? days;
  final String? description;
  final String? history;
  final String? more_info;
  final int index;

  // College Details
  final String? clgType;
  final String? academicType;
  final String? affiliated;
  final String? classType;
  final String? classrooms;
  final String? totalSeats;
  final String? totalFloors;
  final String? totalArea;
  final String? clgCode;


  @override
  State<CollageDetailWidget> createState() => _CollageDetailWidgetState();
}

class _CollageDetailWidgetState extends State<CollageDetailWidget> {
  // Remove the incorrect Get.find line
  // var  value = Get.find<CollegeController>().collegeBasicDetailList.toString();
  RxBool showCollegeDetails = false.obs;

  final Map<String,dynamic> clgDetailsList = AllCollegeData.collegeBaseDataList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("List ========== $clgDetailsList");
    print("description === ${widget.description}");
    print("description === ${widget.more_info}");
    print("description === ${widget.history}");

    // Optional: Trigger fetch if needed, though CollegeDetailController fetches onInit
    // kCollegeController.fetchCollegeDetails();
  }

  @override
  Widget build(BuildContext context) {
    // Remove the local recreation of the list
    /*
    List<CollegeDetailModel> collegeBasicDetailList = [
      CollegeDetailModel(type: "College Type", value: widget.clgType),
      CollegeDetailModel(type: "Academic Type", value:widget.academicType),
      CollegeDetailModel(type: "Affiliated", value:widget.affiliated),
      CollegeDetailModel(type: "Type", value: widget.classType),
      CollegeDetailModel(type: "Class Rooms", value: widget.classrooms),
      CollegeDetailModel(type: "No. of Seats", value: widget.totalSeats),
      CollegeDetailModel(type: "No. of Floors", value: widget.totalFloors),
      CollegeDetailModel(type: "Total Area", value: widget.totalArea),
      CollegeDetailModel(type: "College Code", value: widget.clgCode),
    ];
    */

    return Column(
      children: [
        Obx(
          () => DetailOnOffButton(
            name: "College Details",
            isDetailDisplayed: kCollegeController.sectionVisibility[widget.index].value,
            onTap: () {
              kCollegeController.expandDetailWhenTapOnTab(widget.index);
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          child: Obx(
            () => Visibility(
              visible: kCollegeController.sectionVisibility[widget.index].value,
              child: Column(
                crossAxisAlignment:CrossAxisAlignment.start,
                children: [
                  // COLLEGE CATEGORIES LIST
                  // Use Obx here to react to changes in the controller's list
                  Obx(() => GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    // Use the list directly from the kCollegeController
                    itemCount: kCollegeController.collegeBasicDetailList.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisExtent: 35,
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      // Access the item from the controller's list
                      CollegeDetailModel data = kCollegeController.collegeBasicDetailList[index];

                      return Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 5.w,
                        ),
                        decoration: BoxDecoration(
                            color: const Color.fromRGBO(253, 233, 241, 1),
                            borderRadius: BorderRadius.circular(3)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              data.type, // Use data from the controller list item
                              style: TextStyle(
                                  fontSize: 10.sp,
                                  color: const Color.fromRGBO(102, 102, 102, 1),
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              data.value.toString(), // Use data from the controller list item
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 10.sp,
                                color: const Color.fromRGBO(166, 168, 171, 1),
                                  fontFamily: "Poppins",
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  )),
                  SizedBox(height: 16.h),
                  Text(
                    "College Timings",
                    style: TextStyle(color: grey102Color, fontSize: 13.sp,fontFamily: "Poppins",fontWeight: FontWeight.w700),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    "Open : ${widget.open} | Close : ${widget.close} | ${widget.days}",
                    style: TextStyle(color: grey88Color, fontSize: 13.sp,fontFamily: "Poppins",),
                  ),
                  SizedBox(height: 5.h),
                  Text(widget.more_info ?? " ",
                    style: TextStyle(color: grey88Color, fontSize: 11.sp,fontFamily: "Poppins",),
                  ),
                  SizedBox(height: 20.h),
                   CollegeDetailScreenTitleAndDescriptionWidget(
                    title: "Description",
                    description: widget.description!,
                  ),
                  SizedBox(height: 20.h),
                   CollegeDetailScreenTitleAndDescriptionWidget(
                    title: "History & Achievements",
                    description: widget.history!,
                  )
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 20.h),
      ],
    );
  }
}
