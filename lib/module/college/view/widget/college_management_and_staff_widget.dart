import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../utils/theme/common_color.dart';
import '../../dependencies/college_dependencies.dart';
import 'detail_on_off_button.dart';

class CollegeManagementAndStaffWidget extends StatefulWidget {
  const CollegeManagementAndStaffWidget({super.key,required this.staffList,required this.collegeId,required this.index,});

  final String collegeId;
  final List<dynamic> staffList;
  final int index;

  @override
  State<CollegeManagementAndStaffWidget> createState() => _CollegeManagementAndStaffWidgetState();
}


class _CollegeManagementAndStaffWidgetState extends State<CollegeManagementAndStaffWidget> {
  RxBool showManagementAndStaffDetails = false.obs;
  List<Map<String, dynamic>> preStaffList = [];
  List<String>  selectStaffList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("staff list = ${widget.staffList}");
    List<dynamic> subList = widget.staffList;
    print("sub List = $subList");

    // find select staff list from all staff data List..
    for(var i = 0; i < subList.length; i++) {
      if (subList[i]["collegeid"] == widget.collegeId && subList[i]["isOpen"] == true) {
        print("your i === $i");
        preStaffList.add(widget.staffList[i]);
        // selectStaffList.add(subList[i]["name"]);
        // print("clg id ====== ${subList[i]["collegeid"] }");
        // print("clgid = ${widget.collegeId}");
      }
    }
    print("filter staff list = ${preStaffList}");
    print("filter staff list length = ${preStaffList.length}");


  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(
          () => DetailOnOffButton(
            name: "Management & Staff",
            isDetailDisplayed: kCollegeController.sectionVisibility[widget.index].value,
            onTap: () {
              kCollegeController.expandDetailWhenTapOnTab(widget.index);
              // showManagementAndStaffDetails.value = !showManagementAndStaffDetails.value;
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 35.w),
          child: Obx(
            () => Visibility(
              visible: kCollegeController.sectionVisibility[widget.index].value,
              child: widget.staffList != null && widget.staffList.isNotEmpty ?
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(vertical: 20),
                itemCount: preStaffList.length,
                itemBuilder: (context, index) =>
                ManagementAndStaffCard(
                    image:preStaffList[index]["url"],
                    name:preStaffList[index]["name"] ,
                    qualification:preStaffList[index]["qualification"],
                    designation: preStaffList[index]["designation"],
                    experience: preStaffList[index]["experience"],
                    about:preStaffList[index]["about"] ),

                separatorBuilder: (context, index) => SizedBox(
                  height: 16.h,
                ),
              )  :
              Padding(padding: EdgeInsets.symmetric(vertical: 15.h),
                child: Column(
                  children: [
                    Text(
                      "Staff details are not available.",
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

class ManagementAndStaffCard extends StatefulWidget {
  const ManagementAndStaffCard({super.key,required this.image,required this.name,required this.qualification,required this.designation,
    required this.experience, required this.about});
  final String image;
  final String name;
  final String qualification;
  final String designation;
  final List<dynamic> experience;
  final String about;



  @override
  State<ManagementAndStaffCard> createState() => _ManagementAndStaffCardState();
}

class _ManagementAndStaffCardState extends State<ManagementAndStaffCard> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("image = ${widget.image}");
    print("name = ${widget.name}");
    print("qualification = ${widget.qualification}");
    print("designation = ${widget.designation}");
    print("total = ${widget.experience}");
    print("about = ${widget.about}");

  }


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
      decoration: BoxDecoration(
          color: const Color.fromRGBO(225, 244, 253, 1),
          borderRadius: BorderRadius.circular(8.r)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 90.h,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child:Image.network( widget.image,
                // "assets/image/college_professors_blog_post.webp",
                width: 65.w,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Column(
              children: [
                IntrinsicHeight(
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text( widget.name,
                              // widget.staffList[0]["name"],
                              // "Ravindar Narayana",
                              style: TextStyle(
                                color: grey102Color,
                                fontSize: 11.sp,fontFamily: "Poppins",
                                fontWeight: FontWeight.w700
                              ),
                            ),
                            IntrinsicHeight(
                              child: Text("${widget.qualification}  |   ${widget.designation}",
                                // widget.staffList[0]["qualification"],
                                // "Qualification | Designation",
                                style: TextStyle(
                                  color: grey128Color,
                                  fontSize: 9.sp,
                                ),
                              ),
                              ),
            ]
                            )
                      ),
                      const VerticalDivider(
                        width: 0,
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Experience",
                              style: TextStyle(
                                color: grey102Color,
                                fontSize: 11.sp,fontFamily: "Poppins",
                                  fontWeight: FontWeight.w700,
                              ),
                            ),
                            IntrinsicHeight(
                              child: Text(
                                "Total: ${widget.experience[0]["total"]} | Current: ${ widget.experience[0]["current"]}",
                                style: TextStyle(
                                  color: grey128Color,
                                  fontSize: 9.sp,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 6.h),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "About",
                      style: TextStyle(color: grey102Color, fontSize: 10.sp,fontFamily: "Poppins",fontWeight: FontWeight.w700),
                    ),
                    SizedBox(height: 2.5.h),
                    Text(widget.about,
                      // widget.staffList[0]["about"],
                      // "Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper ",
                      style: TextStyle(color: grey88Color, fontSize: 9.sp),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
