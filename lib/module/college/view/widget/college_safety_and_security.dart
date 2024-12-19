import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../dependencies/college_dependencies.dart';
import 'college_detail_screen_title_and_description_widget.dart';
import 'detail_on_off_button.dart';

class CollegeSafetyAndSecurityWidget extends StatefulWidget {
  const CollegeSafetyAndSecurityWidget({super.key,required this.safety,required this.index});
  final String safety;
  final int index;

  @override
  State<CollegeSafetyAndSecurityWidget> createState() => _CollegeSafetyAndSecurityWidgetState();
}

class _CollegeSafetyAndSecurityWidgetState extends State<CollegeSafetyAndSecurityWidget> {
  RxBool showSafetyAndSecurityDetails = false.obs;


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(
          () => DetailOnOffButton(
            name: "Safety & Security",
            isDetailDisplayed: kCollegeController.sectionVisibility[widget.index].value,
            // isDetailDisplayed: showSafetyAndSecurityDetails.value,
            onTap: () {
              kCollegeController.expandDetailWhenTapOnTab(widget.index);
             // setState(() {
             //   showSafetyAndSecurityDetails.value = !showSafetyAndSecurityDetails.value;
             // });
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 35.w),
          child: Obx(
            () => Visibility(
              visible: kCollegeController.sectionVisibility[widget.index].value,
              // visible: showSafetyAndSecurityDetails.value,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),
                   if(widget.safety.isEmpty)
                     Text(
                       "This Details is not show in This College",
                       style: TextStyle(
                         fontWeight: FontWeight.w700,
                         fontSize: 18.sp,
                         // Add more styles as needed
                       ),
                     ) else
                   CollegeDetailScreenTitleAndDescriptionWidget(
                    title: "Safety",
                    description:  "${widget.safety}",
                        // "Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper ",
                  ),
                  // SizedBox(height: 8.h),
                  // const CollegeDetailScreenTitleAndDescriptionWidget(
                  //   title: "Security",
                  //   description:
                  //       "Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper ",
                  // ),
                  SizedBox(height: 20.h),
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
