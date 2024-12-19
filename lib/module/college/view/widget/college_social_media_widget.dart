import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../utils/theme/common_color.dart';
import '../../../nearby/model/infrastructure_model.dart';
import '../../dependencies/college_dependencies.dart';
import 'detail_on_off_button.dart';

class CollegeSocialMediaWidget extends StatefulWidget {
  const CollegeSocialMediaWidget({super.key,this.socialDetails,required this.collegeId,required this.index});
  final List<dynamic>? socialDetails;
  final String collegeId;
  final int index;



  @override
  State<CollegeSocialMediaWidget> createState() => _CollegeSocialMediaWidgetState();
}

class _CollegeSocialMediaWidgetState extends State<CollegeSocialMediaWidget> {
  RxBool showSocialMediaDetails = false.obs;
  // List<Map<String, dynamic>> perSocialList = [];
  // List<String>  subSocialList = [];

  String  website = " ";
  String faceBook = " ";
  String youTube = " ";
  String instagram = " ";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("social Details = ${widget.socialDetails}");

    List subLink = widget.socialDetails as List<dynamic>;

    for(var i = 0; i < subLink.length; i++) {
      if (subLink[i]["collegeid"] == widget.collegeId) {
        print("your i === $i");
        // perSocialList.add(subList[i]);
        // subSocialList.add(subList[i]["_id"]);
        print("clgid = ${widget.collegeId}");
      }
      website = subLink[i]["website"];
      faceBook = subLink[i]["facebook"];
      youTube = subLink[i]["youtube"];
      instagram = subLink[i]["instagram"];

      print("Social Media Website link === $website");
      print("Social Media faceBook link === $faceBook");
      print("Social Media Youtube link === $youTube");
      print("Social Media instagram link ===$instagram");

    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(
          () => DetailOnOffButton(
            name: "Social Media",
            isDetailDisplayed: kCollegeController.sectionVisibility[widget.index].value,
            onTap: () {
              kCollegeController.expandDetailWhenTapOnTab(widget.index);
              // showSocialMediaDetails.value = !showSocialMediaDetails.value;
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.w),
          child: Obx(
            () => Visibility(
              visible: kCollegeController.sectionVisibility[widget.index].value,
              child: widget.socialDetails != null && widget.socialDetails!.isNotEmpty  ?
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(vertical: 14.h),
                itemCount: kCollegeController.socialMediaList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisExtent: 45,
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (BuildContext context, int index) {
                  InfrastructureModel data =
                      kCollegeController.socialMediaList[index];
                      String value = '';

                  switch (data.name) {
                    case "Website":
                      value = website; // Assign website value
                      break;
                    case "Facebook":
                      value = faceBook; // Assign Facebook value
                      break;
                    case "Youtube":
                      value = youTube; // Assign YouTube value
                      break;
                    case "Instagram":
                      value = instagram; // Assign Instagram value
                      break;
                    default:
                      value = ''; // Default value if not found
                      break;
                  }
                  return Center(
                    child: InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(8.r),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 5.h),
                        child: Row(
                          children: [
                            SizedBox(width: 5.w),
                            Image.asset(data.icon, height: 26.h, width: 26.h),
                            SizedBox(width: 5.w),
                            Expanded(
                              child: Text(
                                value,
                                style: TextStyle(fontSize: 13.sp, color: grey102Color,overflow:TextOverflow.ellipsis,fontFamily: "Poppins",fontWeight: FontWeight.w700),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              )
                  : Padding(padding: EdgeInsets.symmetric(vertical: 15.h),
                child: Column(
                  children: [
                    Text(
                      "Social media details are not available.",
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
