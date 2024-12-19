import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../utils/collegedatalist.dart';
import '../../../../utils/constant/asset_icons.dart';
import '../../../nearby/model/infrastructure_model.dart';

import '../../dependencies/college_dependencies.dart';
import 'college_detail_screen_title_and_description_widget.dart';
import 'detail_on_off_button.dart';

class CollegeHighlightWidget extends StatefulWidget {
  const CollegeHighlightWidget({super.key,required this.clgId,required this.index});

  final String clgId;
  final int index;

  @override
  State<CollegeHighlightWidget> createState() => _CollegeHighlightWidgetState();
}

class _CollegeHighlightWidgetState extends State<CollegeHighlightWidget> {
  RxBool showHighlightDetails = false.obs;

  List<dynamic> highlightList = [];
  List<dynamic> subHighlightList = [];
  List<dynamic> clgHighlightList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    highlightList.add(AllCollegeData.collegeDataList["highlight"]);
    print("your highlight  data is = $highlightList}");

    subHighlightList = highlightList[0];
    print("highlight data ==== $subHighlightList");
    // ClgInfraData.fetchData() ;
    print("data ==== $subHighlightList");


    for(int i = 0; i < subHighlightList.length; i++ ) {
      print("college ids == ${subHighlightList[i]["collegeid"]} and wid id == ${widget.clgId}");
      if(widget.clgId == subHighlightList[i]["collegeid"]) {
        print("college ids in inner if == ${subHighlightList[i]["collegeid"]}");
        clgHighlightList.add(subHighlightList[i]);
      }
    }
    highlightList[0] = clgHighlightList[0];
    print("highlight data filtered  ==== ${clgHighlightList}");
  }

  @override
  Widget build(BuildContext context) {
    List<InfraModel> collegeHighlightsList = [];
      // InfraModel(
      //     name: "Sport Events", icon: AssetIcons.HIGHLIGHTS_SPOT_EVENTS_ICON,value: clgHighlightList[0]["sport_events"][0]["status"]),
      if(clgHighlightList.isNotEmpty && clgHighlightList[0]["skill_development"] != null && clgHighlightList[0]['skill_development'].isNotEmpty) {
            collegeHighlightsList.add(InfraModel(
                name: "Skill Development",
                icon: AssetIcons.HIGHLIGHTS_SKILL_DEVELOPMENT_ICON,
                value: clgHighlightList[0]["skill_development"][0]["status"]));}

    if(clgHighlightList.isNotEmpty && clgHighlightList[0]["scholarship"] != null && clgHighlightList[0]['scholarship'].isNotEmpty) {
            collegeHighlightsList.add(InfraModel(
                name: "Scholarship",
                icon: AssetIcons.HIGHLIGHTS_SCHOLARSHIP_ICON,
                value: clgHighlightList[0]["scholarship"][0]["status"]));}

    if(clgHighlightList.isNotEmpty && clgHighlightList[0]["career"] != null && clgHighlightList[0]['career'].isNotEmpty) {
            collegeHighlightsList.add(InfraModel(
                name: "Career Counselling",
                icon: AssetIcons.HIGHLIGHTS_SKILL_DEVELOPMENT_ICON,
                value: clgHighlightList[0]["career"][0]["status"]));}
    
    List<InfraModel> filteredHighlightsList = collegeHighlightsList
        .where((item) => item.value == true)
        .toList();
    return Column(
      children: [
        Obx(
          () => DetailOnOffButton(
            name: "Highlights",
            isDetailDisplayed: kCollegeController.sectionVisibility[widget.index].value,
            onTap: () {
              kCollegeController.expandDetailWhenTapOnTab(widget.index);
              // setState(() {
              //   showHighlightDetails.value = !showHighlightDetails.value;
              // });
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
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    itemCount: filteredHighlightsList.length,
                    // itemCount: kCollegeController.collegeHighlightsList.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisExtent: 30,
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      InfraModel data = filteredHighlightsList[index];
                          // kCollegeController.collegeHighlightsList[index];
                      return Container(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              data.icon,
                              height: 16.h,
                              width: 20.h,
                            ),
                            SizedBox(width: 5.w),
                            Expanded(
                                child: Text(
                              data.name,
                              style: TextStyle(fontSize: 13.sp,fontFamily: "Poppins",
                              ),
                            )),
                          ],
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 5.h),
                  const CollegeDetailScreenTitleAndDescriptionWidget(
                    title: "College Specification",
                    description:
                        "Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper ",
                  ),
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
