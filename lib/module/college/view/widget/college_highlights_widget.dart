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
    super.initState();

    // Attempt to get highlight data, handle potential errors
    try {
      var allHighlights = AllCollegeData.collegeDataList["highlight"];
      if (allHighlights is List<dynamic>) {
        subHighlightList = allHighlights;
      } else {
        print("Warning: 'highlight' data is not a List.");
        subHighlightList = []; // Initialize as empty list if data is wrong type
      }
    } catch (e) {
      print("Error accessing highlight data: $e");
      subHighlightList = []; // Initialize as empty list on error
    }
    print("All highlight data count: ${subHighlightList.length}");

    // Filter for the current college ID
    clgHighlightList = subHighlightList.where((highlight) => highlight["collegeid"] == widget.clgId).toList();
    print("Filtered highlight data for college ${widget.clgId}: ${clgHighlightList.length}");

    // No need to modify highlightList[0] here, we use clgHighlightList in build
  }

  @override
  Widget build(BuildContext context) {
    // Check if clgHighlightList has data
    final hasHighlightData = clgHighlightList.isNotEmpty;
    Map<String, dynamic>? currentHighlightData = hasHighlightData ? clgHighlightList[0] : null;

    List<InfraModel> collegeHighlightsList = [];

    // Build the highlights list only if data exists
    if (hasHighlightData && currentHighlightData != null) {
      // Safely check and add Skill Development
      var skillDev = currentHighlightData["skill_development"];
      if (skillDev is List && skillDev.isNotEmpty && skillDev[0] is Map && skillDev[0]["status"] == true) {
        collegeHighlightsList.add(InfraModel(
            name: "Skill Development",
            icon: AssetIcons.HIGHLIGHTS_SKILL_DEVELOPMENT_ICON,
            value: true));
      }

      // Safely check and add Scholarship
      var scholarship = currentHighlightData["scholarship"];
      if (scholarship is List && scholarship.isNotEmpty && scholarship[0] is Map && scholarship[0]["status"] == true) {
        collegeHighlightsList.add(InfraModel(
            name: "Scholarship",
            icon: AssetIcons.HIGHLIGHTS_SCHOLARSHIP_ICON,
            value: true));
      }

      // Safely check and add Career Counselling
      var career = currentHighlightData["career"];
      if (career is List && career.isNotEmpty && career[0] is Map && career[0]["status"] == true) {
        collegeHighlightsList.add(InfraModel(
            name: "Career Counselling",
            icon: AssetIcons.HIGHLIGHTS_SKILL_DEVELOPMENT_ICON, // Assuming same icon for now
            value: true));
      }
      
      // Safely check and add Sport Events
      var sportEvents = currentHighlightData["sport_events"];
      if (sportEvents is List && sportEvents.isNotEmpty && sportEvents[0] is Map && sportEvents[0]["status"] == true) {
         collegeHighlightsList.add(InfraModel(
            name: "Sport Events", 
            icon: AssetIcons.HIGHLIGHTS_SPOT_EVENTS_ICON, // Ensure this icon exists
            value: true));
      }
    }

    // The list already contains only items with value: true due to the checks above
    List<InfraModel> filteredHighlightsList = collegeHighlightsList;

    return Column(
      children: [
        Obx(
          () => DetailOnOffButton(
            name: "Highlights",
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Show GridView only if there are highlights to display
                  if (filteredHighlightsList.isNotEmpty)
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      itemCount: filteredHighlightsList.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisExtent: 30,
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        InfraModel data = filteredHighlightsList[index];
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
                    )
                  else
                    // Show message if no highlights are available or enabled
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 15.h),
                      child: Text(
                        "No highlights available for this college.",
                        style: TextStyle(fontSize: 14.sp, color: Colors.grey),
                      ),
                    ),

                  SizedBox(height: 5.h),
                  // Consider making this description dynamic or removing if not needed
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
