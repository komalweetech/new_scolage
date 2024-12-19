import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../dependencies/college_dependencies.dart';
import 'college_detail_screen_title_and_description_widget.dart';
import 'detail_on_off_button.dart';

class CollegePolicyWidget extends StatefulWidget {
  const CollegePolicyWidget({super.key,required this.policy,required this.collegeId,required this.index});
  final String policy;
  final String collegeId;
  final int index;

  @override
  State<CollegePolicyWidget> createState() => _CollegePolicyWidgetState();
}

class _CollegePolicyWidgetState extends State<CollegePolicyWidget> {
  RxBool showPolicyDetails = false.obs;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(
          () => DetailOnOffButton(
            name: "Policy",
            isDetailDisplayed: kCollegeController.sectionVisibility[widget.index].value,
            onTap: () {
              kCollegeController.expandDetailWhenTapOnTab(widget.index);
              // showPolicyDetails.value = !showPolicyDetails.value;
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 35.w),
          child: Obx(
            () => Visibility(
              visible:kCollegeController.sectionVisibility[widget.index].value,
              child:
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  SizedBox(height: 15.h,),
                  if (widget.policy.isEmpty)
                    Text(
                      "Policy is empty",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18.sp,
                        // Add more styles as needed
                      ),
                    )
                  else
                    CollegeDetailScreenTitleAndDescriptionWidget(
                      title: "Terms & Conditions",
                      description:widget.policy,
                      // "Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper ",
                    ),

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
