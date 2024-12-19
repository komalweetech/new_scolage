import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../utils/commonWidget/status_bar_theme.dart';
import '../../../../utils/constant/asset_icons.dart';
import '../../../../utils/theme/common_color.dart';
import '../../../college/model/college_model.dart';
import '../../../home/services/ClgListApi.dart';
import '../../../home/view/widget/college_card.dart';


List<CollegeDataModel> collegeList = [];
List<CollegeDataModel> collegeBaseList = [];

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key, this.collegeName}) : super(key: key);

  final collegeName;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();

  bool loader = false;
  @override
  void initState() {
    super.initState();
    searchController.text = widget.collegeName ?? "";
    searchController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void searchData({String? value}) {
    collegeList.clear();
    if (value!.trim().isEmpty) {
      collegeList.addAll(collegeBaseList);
      setState(() {});
      return;
    }
  }
  Future<void> _refreshData() async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      ClgListApi.getAttApi();
    });
  }

  // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return StatusBarTheme(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        // key: _scaffoldKey,
        resizeToAvoidBottomInset: true,
        backgroundColor: const Color.fromRGBO(244, 245, 247, 1),
        appBar: PreferredSize(
          preferredSize:
          Size.fromHeight(100 + MediaQuery.of(context).padding.top),
          child: Stack(
            children: [
              Container(
                height: 130 + MediaQuery.of(context).padding.top,
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.elliptical(
                      MediaQuery.of(context).size.width,
                      60.0,
                    ),
                  ),
                ),
                child: SafeArea(
                  child: Stack(
                    children: [
                      Center(
                          child: Image.asset("assets/image/appbar_bg_image.png")),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(width: 6.w),
                          IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            icon: Image.asset(
                              AssetIcons.COLLEGE_DETAIL_SCREEN_BACK_ARROW_ICON,
                              color: Colors.white,
                              height: 15.h,
                            ),
                          ),
                          Expanded(
                            child: Image.asset(
                              AssetIcons.APP_BAR_APP_LOGO_ICON,
                              height: 35,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Image.asset(
                              AssetIcons.NOTIFICATION_ICON,
                              color: Colors.white,
                              height: 29,
                            ),
                          ),
                          SizedBox(width: 6.w),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 10,
                left: 20,
                right: 20,
                child: Center(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 0.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(.1),
                          blurRadius: 20,
                          spreadRadius: 5,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(50.r),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(width: 14.w),
                            Image.asset(
                              AssetIcons.SEARCH_ICON,
                              height: 20.h,
                            ),
                            SizedBox(width: 7.w),
                            Expanded(
                              child: TextFormField(
                                onChanged: (value) {
                                  searchData(value: value);
                                },
                                controller: searchController,
                                textAlignVertical: TextAlignVertical.center,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(bottom: 11.h, top: 6.5.h),
                                  border: InputBorder.none,
                                  hintText: 'Enter city, area or location',
                                  hintStyle: TextStyle(fontSize: 16.sp),
                                  isDense: true,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: (){},
                              child: Image.asset(
                                AssetIcons.MICROPHONE_ICON,
                                height: 20,
                              ),
                            ),
                            SizedBox(width: 17.w),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Builder(
          builder: (BuildContext context) {
            return loader == true
                ? const Center(child: CircularProgressIndicator())
                : RefreshIndicator(
              onRefresh: _refreshData,
                  child: FutureBuilder(
                    future: ClgListApi.getAttApi(),
                    builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return const Center(
                        child: Text("there is an error for search screen"),
                      );
                    } else if (snapshot.hasData) {
                      var data = snapshot.data as Map<dynamic, dynamic>;
                      var collegeList = data["college"] as List<dynamic>;
                      var infraOfCollages = data["infra"] as List<dynamic>;
                      var clgImage = data["clgimage"] as List<dynamic>;
                      print("college image url ===  ${clgImage.length}");
                      var policy = data["clgpolicySocialMedia"] as List<dynamic>;
                      var eligibility = data["feeStructure"] as List<dynamic>;
                      var staff = data["management_staff"] as List<dynamic>;
                      var safety = data["highlight"] as List<dynamic>;
                      var subjectName = data["subject"] as List<dynamic>;
                      var socialMedia = data["clgpolicySocialMedia"] as List<dynamic>;
                      var videos = data["videoUrl"] as List<dynamic>;

                      print("object college list === $collegeList");
                      print("college infra list === $infraOfCollages");
                      return ListView.separated(
                        shrinkWrap: true,
                        padding: EdgeInsets.only(left: 30,right: 30),
                        scrollDirection: Axis.vertical,
                        itemCount: collegeList.length,
                        itemBuilder: (context, index) {
                          final collegeName =
                              collegeList[index]?["collegename"] ?? " ";
                          final collegeAddress =
                              collegeList[index]?["address"] ?? "";
                          final collegeArea =
                              collegeList[index]?["college_area"] ?? "";

                          final searchTerm =
                          searchController.text.toLowerCase();

                          if (collegeName
                              .toLowerCase()
                              .contains(searchTerm) ||
                              collegeAddress
                                  .toLowerCase()
                                  .contains(searchTerm) ||
                              collegeArea
                                  .toLowerCase()
                                  .contains(searchTerm)) {
                            return CollegeCard(
                              index: index,
                              height: 200.h,
                              width: 300.w,
                              clgImageList: clgImage,
                              videoList: videos,
                              clgName: collegeList[index]?["collegename"] ?? "N/A",
                              clgId: collegeList[index]?["collegeid"] ?? "N/A",
                              clgAdd: collegeList[index]?["address"] ?? "N/A",
                              clgDetails: [collegeList],
                              clgImage: clgImage[index]?["imageUrl"] ?? "N/A",
                              policy: policy[index]?["terms_condition"] ?? "N/A",
                              eligibility: eligibility[index]?["eligibility_criteria"] ?? "N/A",
                              feeTerms: eligibility[index]?["fee_terms"] ?? "N/A",
                              // feeStructure: eligibility,
                              staffList: staff,
                              safety: safety[index]?["safety_security"] ?? "N/A",
                              subjectName: subjectName,
                              socialMedia: socialMedia,
                              open: collegeList[index]["timings"][0]["open"] ?? "N/A",
                              close: collegeList[index]["timings"][0]["close"] ?? "N/A",
                              days: collegeList[index]["timings"][0]["Mon_to_Sat"] ?? "N/A",

                              // college Details Screen Data...
                              clgType: collegeList[index]["college_type"] ?? "N/A",
                              academicType: collegeList[index]["academic_type"] ?? "N/A",
                              affiliated: collegeList[index]["affiliated"] ?? "N/A",
                              classType: collegeList[index]["class_type"] ?? "N/A",
                              classrooms: collegeList[index]["class_rooms"].toString(),
                              totalSeats: collegeList[index]["total_seats"].toString(),
                              totalFloors: collegeList[index]["no_of_floors"].toString(),
                              totalArea: collegeList[index]["college_area"].toString(),
                              clgCode: collegeList[index]["college_code"].toString(),
                            );
                          } else {
                            return Container();
                          }
                        },
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 20.h),
                      );
                    }
                  }
                  return const Center(child: CircularProgressIndicator());
                                },
                              ),
                );
          },
        ),


      ),
    );
  }
}



