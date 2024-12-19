import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../dependencies/college_dependencies.dart';
import 'college_detail_screen_title_and_description_widget.dart';
import 'detail_on_off_button.dart';

class CollegeSubjectsWidget extends StatefulWidget {
  const CollegeSubjectsWidget(
      {super.key,
      required this.eligibility,
      required this.subjectList,
      required this.collegeId,
      required this.index});

  final String eligibility;
  final List<dynamic>? subjectList;
  final String collegeId;
  final int index;

  @override
  State<CollegeSubjectsWidget> createState() => _CollegeSubjectsWidgetState();
}

class _CollegeSubjectsWidgetState extends State<CollegeSubjectsWidget> {
  RxBool showSubjectsDetails = false.obs;
  List<Map<String, dynamic>> perSubOfCollegeList = [];
  List<String> subNamesList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    List subList = widget.subjectList as List<dynamic>;

    for (var i = 0; i < subList.length; i++) {
      if (subList[i]["collegeid"] == widget.collegeId) {
        print("your i === $i");
        perSubOfCollegeList.add(subList[i]);
        subNamesList.add(subList[i]["subjectname"]);
        print("clg id ====== ${subList[i]["collegeid"]}");
        print("clgid = ${widget.collegeId}");
      }
    }
    print("subject List === $subNamesList");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(
          () => DetailOnOffButton(
            name: "Subject’s",
            isDetailDisplayed: kCollegeController.sectionVisibility[widget.index].value,
            onTap: () {
              kCollegeController.expandDetailWhenTapOnTab(widget.index);
              // showSubjectsDetails.value = !showSubjectsDetails.value;
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 35.w),
          child: Obx(
            () => Visibility(
              visible: kCollegeController.sectionVisibility[widget.index].value,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    itemCount: subNamesList.length,
                    // itemCount: kCollegeController.subjectList.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisExtent: 65,
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 5.w,
                        ),
                        decoration: BoxDecoration(
                            color: const Color.fromRGBO(255, 253, 233, 1),
                            borderRadius: BorderRadius.circular(3)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              perSubOfCollegeList[index]["subjectname"],
                              // widget.subjectList![index]["subjectname"] ,
                              // kCollegeController.subjectList[index],
                              style: TextStyle(
                                  fontSize: 10.sp,
                                  color: const Color.fromRGBO(102, 102, 102, 1),
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w700),
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              perSubOfCollegeList[index]["description"],
                              // widget.subjectList![index]["description"],
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
                  ),
                  SizedBox(height: 5.h),
                  if (widget.eligibility.isEmpty)
                    Text(
                      "Eligibility Criteria Data is empty",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18.sp,
                        // Add more styles as needed
                      ),
                    )
                  else
                    CollegeDetailScreenTitleAndDescriptionWidget(
                        title: "Eligibility Criteria",
                        description: widget.eligibility
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
