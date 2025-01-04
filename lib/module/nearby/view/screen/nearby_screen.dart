// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../utils/commonFunction/common_bottom_sheet_function.dart';
import '../../../../utils/commonWidget/keyboard_off.dart';
import '../../../../utils/constant/asset_icons.dart';
import '../../../../utils/enum/nearby_screen_enum.dart';
import '../../../../utils/theme/common_color.dart';
import '../../../dashboard/view/widget/Search_screen.dart';
import '../../../home/model/college_data.dart';
import '../../../home/view/widget/college_card.dart';
import '../../controller/NearbyController.dart';
import '../../dependencies/nearby_dependencies.dart';
import '../widget/all_filter_bottom_sheet.dart';
import '../widget/area_filter_bottom_sheet.dart';
import '../widget/fees_filter_bottom_sheet.dart';
import '../widget/nearby_screen_tab_widget.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'map_screen.dart';

class NearbyScreen extends StatefulWidget {
  NearbyScreen({super.key, required this.cityName,});

  final String cityName;

  @override
  State<NearbyScreen> createState() => _NearbyScreenState();
}

class _NearbyScreenState extends State<NearbyScreen> {
  NearbyController nearbyController = Get.put(NearbyController());
  final TextEditingController searchController = TextEditingController();
  List<dynamic> filterFees = [];
  List<dynamic> filterTrend = [];
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _speechText = "";



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    searchController.text = widget.cityName;
    searchController.addListener(() {
      setState(() {});
    });
    _speech = stt.SpeechToText();
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

  // Function to start/stop listening
  void _listen() async {
    if (!_isListening && await _speech.initialize()) {
      setState(() {
        _isListening = true;
      });

      _speech.listen(onResult: (result) {
        setState(() {
          _speechText = result.recognizedWords; // Capture the recognized speech
        });
      });
    } else {
      setState(() {
        _isListening = false;
      });
      _speech.stop(); // Stop listening
    }
  }

  @override
  Widget build(BuildContext context) {
    return KeyBoardOff(
      child: Scaffold(
        appBar: AppBar(
          leadingWidth: 0,
          leading: const SizedBox(width: 0),
          backgroundColor: kPrimaryColor,
          title: Container(
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
            child: Row(
              children: [
                SizedBox(width: 4.w),
                // BACK ARROW
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(100.r),
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Image.asset(
                        AssetIcons.NEARBY_SCREEN_BACK_ARROW_ICON,
                        height: 14,
                      ),
                    ),
                  ),
                ),
                // TEXTFIELD .
                Expanded(
                  child: TextFormField(
                    onChanged: (value) {
                      setState(() {
                        searchData(value: value);
                      });
                    },
                    autofocus: true,
                    controller: searchController,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.only(bottom: 11.h, top: 6.5.h, left: 10),
                      border: InputBorder.none,
                      hintStyle: TextStyle(fontSize: 16.sp),
                      isDense: true,
                    ),
                  ),
                ),
                // MICROPHONE .
                GestureDetector(
                  onTap: _listen,
                  child: Image.asset(
                    AssetIcons.MICROPHONE_ICON,
                    height: 20,
                  ),
                ),
                SizedBox(width: 17.w),
              ],
            ),
          ),
        ),
        body: Stack(
          children: [
            // TAB BAR
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 28,
                        child: ListView.separated(
                          padding: EdgeInsets.only(
                            left: 20.w,
                            right: 4.w,
                          ),
                          scrollDirection: Axis.horizontal,
                          itemCount: 2,
                          itemBuilder: (context, index) => NearbyScreenTab(
                            icon: NearbyScreenTabEnum.values[index].iconLink,
                            name: NearbyScreenTabEnum.values[index].displayName,
                            onTap: () async {
                              // kNearbyController.isAllFilter.value = false;
                              nearbyController.selectedFees.value =
                                  NearbyScreenTabEnum.values[index].displayName;
                              switch (NearbyScreenTabEnum.values[index]) {
                                case NearbyScreenTabEnum.area:
                                  await commonBottomSheetFunction(
                                      context: context,
                                      child: AreaFilterBottomSheet(
                                        onCitySelected: (selectedCity) {
                                          searchController.text = selectedCity;
                                          kNearbyController.reloadCollegesData();
                                          print("select area for filter == $selectedCity");
                                        },
                                      ));
                                  break;
                                case NearbyScreenTabEnum.fees:
                                  await commonBottomSheetFunction(
                                    context: context,
                                    child: FeesFilterBottomSheet(
                                      onFeesSelected: (selectedFees) {
                                        searchController.text = selectedFees;
                                        print("select Fees == $selectedFees");
                                        kNearbyController.reloadCollegesData();
                                      },
                                      onApplyFilter: (filterFeesList) async {
                                        filterFees.clear();
                                        filterFees = filterFeesList;
                                        print("filterFees = $filterFeesList");
                                        print("filterFees lungth = ${filterFees.length}");
                                        await kNearbyController.reloadCollegesData();
                                      },
                                    ),
                                  );
                                //   break;
                                // case NearbyScreenTabEnum.trending:
                                //   await commonBottomSheetFunction(
                                //     context: context,
                                //     child: TrendingFilterBottomSheet(
                                //       onTrendSelected: (selectTrend) {
                                //         searchController.text = selectTrend;
                                //         print("select Trend == $selectTrend");
                                //         kNearbyController.reloadCollegesData();
                                //       },
                                //       onApplyFilter: (filterTrendList) async {
                                //         filterTrend.clear();
                                //         filterTrend = filterTrendList;
                                //         print("filter trend in bottom sheet = $filterTrendList");
                                //         print("filter trend data lungth = ${filterTrend.length}");
                                //
                                //         await kNearbyController.reloadCollegesData();
                                //       },
                                //     ),
                                //   );
                                  break;
                                case NearbyScreenTabEnum.trending:
                                  // TODO: Handle this case.
                                  throw UnimplementedError();
                              }
                            },
                          ),
                          separatorBuilder: (context, index) =>
                              SizedBox(width: 16.w),
                        ),
                      ),
                    ),
                    // ALL FILTER BUTTON
                    FutureBuilder(
                      future: kNearbyController.fetchCollegesData(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return SizedBox(
                              height: 30.h,
                              width: 30.h,
                              child: CupertinoActivityIndicator());
                        } else if (snapshot.hasData) {
                          CollegeData collegeData = snapshot.data!;

                          print("all filter college all data == $collegeData");
                          return Material(
                            color: Colors.white,
                            child: Row(
                              children: [
                                SizedBox(width: 16.w),
                                // ALL FILTER
                                Container(
                                  height: 30.h,
                                  width: 30.h,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(05.r),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.2),
                                          spreadRadius: 3,
                                          blurRadius: 3,
                                          // spreadRadius: 1,
                                          offset: Offset(0, 2),
                                        )
                                      ]),
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(10.r),
                                      onTap: () async {
                                        // ALL FILTER BOTTOM SHEET
                                        kNearbyController.isAllFilter.value = true;
                                        await commonBottomSheetFunction(
                                          context: context,
                                          child: AllFilterBottomSheet(collegeData: collegeData),
                                          isScrollControlled: true,
                                        );
                                      },
                                      child: Center(
                                        child: Image.asset(
                                            AssetIcons.ALL_FILTER_ICON,
                                            height: 15.h),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 16.w),
                              ],
                            ),
                          );
                        } else {
                          return SizedBox();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Positioned(
                child: Padding(
              padding: EdgeInsets.only(top: 25.h),
              child: FutureBuilder(
                future: kNearbyController.fetchCollegesData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                        child: CupertinoActivityIndicator(
                      radius: 12,
                    ));
                  } else if (snapshot.hasError) {
                    log("${snapshot.error}");
                    print("college filter throw error :: ${snapshot.error}");
                    return Center(child: Text("Error : ${snapshot.error}"));
                  } else if (snapshot.hasData && snapshot.data!.college!.isNotEmpty) {
                    CollegeData collegeData = snapshot.data!;
                    print("all college Data == $collegeData");

                    // set Intense of collegeData.managementStaff to a List type and fetch a data value...
                    List<ManagementStaff>? staffList = collegeData.managementStaff;
                    List<Map<String, dynamic>> staffInfoList =
                        staffList?.map((staff) {
                              return <String, dynamic>{
                                "collegeid": staff.collegeid,
                                "url": staff.url,
                                "staffid": staff.staffid,
                                "name": staff.name,
                                "qualification": staff.qualification,
                                "experience": [
                                  {
                                    "total":
                                        staff.experience?[0].total?.toString(),
                                    "current": staff.experience?[0].current
                                        ?.toString(),
                                  }
                                ],
                                "designation": staff.designation,
                                "about": staff.about,
                                "isOpen": staff.isOpen,
                                "isDeleted" : staff.isDeleted,
                                "createdAt": staff.createdAt,
                                "__v": 0.toString(),
                              };
                            }).toList() ?? [];
                    print('List of staff staffInformation: $staffInfoList');

                    List<dynamic> nearbyStaffList = staffInfoList as List;
                    print("Nearby staff List == $nearbyStaffList'}");

                    // set Intense of collegeData.subject to a List type and fetch a data value...
                    List<Subject>? subjectList = collegeData.subject;
                    List<dynamic> subjectInfoList = subjectList?.map((subject) {
                          return <String, dynamic>{
                            "collegeid": subject.collegeid,
                            "subjectid": subject.subjectid,
                            "subjectname": subject.subjectname,
                            "description": subject.description,
                            "no_of_seats": subject.noOfSeats,
                            "minFees": subject.minFees,
                            "maxFees": subject.maxFees,
                            "isDeleted" :subject.isDeleted,
                            "createdAt": subject.createdAt,
                            "__v": 0.toString(),
                          };
                        }).toList() ??
                        [];
                    print('List of subject information: $subjectInfoList');

                    // set Intense of collegeData.socialMedia to a List type and fetch a data value...
                    List<ClgpolicySocialMedia>? socialMedia = collegeData.clgpolicySocialMedia;
                    List<dynamic> socialMediaInfoList = socialMedia?.map((socialMedia) {
                              return <String, dynamic>{
                                "collegeid": socialMedia.collegeid,
                                "clgpolicyid": socialMedia.clgpolicyid,
                                "terms_condition": socialMedia.termsCondition,
                                "website": socialMedia.website,
                                "facebook": socialMedia.facebook,
                                "youtube": socialMedia.youtube,
                                "instagram": socialMedia.instagram,
                                "isDeleted" : socialMedia.isDeleted,
                                "createdAt": socialMedia.createdAt,
                                "__v": 0.toString(),
                              };
                            }).toList() ??
                            [];
                    print('List of social Media List: $socialMediaInfoList');

                    //set Intense of collegeData.clgimage to a List type and fetch a data value..
                    List<Clgimage>? clgImage = collegeData.clgimage;
                    List<dynamic> clgImageInfoList = clgImage?.map((clgImage) {
                          return <String, dynamic>{
                            "clgimageid": clgImage.clgimageid,
                            "collegeid": clgImage.collegeid,
                            "imageUrl": clgImage.imageUrl,
                            "name": clgImage.name,
                            "isDeleted" : clgImage.isDeleted,
                            "createdAt": clgImage.createdAt,
                            "__v": 0.toString(),
                          };
                        }).toList() ?? [];
                    print('List of college Image List: $clgImageInfoList');


                    //set Intense of collegeData.videoUrl to a list type and fetch a data value..
                    List<VideoUrl>? videoUrl = collegeData.videoUrl;
                    List<dynamic> videoUrlInfoList = videoUrl?.map((videoUrl) {
                          return <String, dynamic>{
                            "collegeid": videoUrl.collegeid,
                            "videourlid": videoUrl.videourlid,
                            "videoUrl0": videoUrl.videoUrl0,
                            "videoUrl1": videoUrl.videoUrl1,
                            "videoUrl2": videoUrl.videoUrl2,
                            "videoUrl3": videoUrl.videoUrl3,
                            "videoUrl4": videoUrl.videoUrl4,
                            "isDeleted" : videoUrl.isDeleted,
                            "createdAt": videoUrl.createdAt,
                            "__v": 0.toString(),
                          };
                        }).toList() ??
                        [];
                    print("List of video url: $videoUrlInfoList");

                    return Padding(
                      padding: EdgeInsets.only(top: 25.h),
                      child: ListView.separated(
                        padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0, bottom: 20.0),
                        itemCount: collegeData.college!.length,
                        itemBuilder: (context, index) {
                          final collegeName = collegeData.college?[index].collegename;
                          final collegeAddress = collegeData.college?[index].address;
                          final collegeArea = collegeData.college?[index].collegeArea;

                          final searchTerm = searchController.text.toLowerCase();

                          final collegeMatchesSearchTerm = collegeName!.toLowerCase().contains(searchTerm) ||
                                collegeAddress!.toLowerCase().contains(searchTerm) ||
                                collegeArea!.toLowerCase().contains(searchTerm) ;

                          // filter clgImage ;
                          final clgImageForCurrentCollege = clgImageInfoList.where((imageInfo) =>
                          imageInfo["collegeid"] == collegeData.college![index].collegeid).toList();

                          // Check if clgImageForCurrentCollege is not empty and get the first image URL
                          String? clgImageForCurrentCollegeUrl;
                          if (clgImageForCurrentCollege.isNotEmpty) {
                            clgImageForCurrentCollegeUrl = clgImageForCurrentCollege.first["imageUrl"];
                          }

                          final isCollegeInFilterFees = filterFees.any((filterFeesItem) =>
                                  filterFeesItem['collegeid'] == collegeData.college?[index].collegeid);
                          print("nearBy screen fees List == ${filterFees}");
                          log("near by screen fees filter lungth = ${filterFees.length}");

                          final isCollegeInFilterTrend = filterTrend.any((filterTrendItem) =>
                                  filterTrendItem["collegeid"] == collegeData.college?[index].collegeid);

                          print("nearBy screen trend List = ${filterTrend}");
                          log("near by screen fees filter lungth = ${filterTrend.length}");

                          if (collegeMatchesSearchTerm || isCollegeInFilterFees || isCollegeInFilterTrend) {
                            return CollegeCard(
                              index: index,
                              height: 200.h,
                              width: double.infinity,
                              clgId: collegeData.college?[index].collegeid,
                              clgImage: clgImageForCurrentCollegeUrl,
                              clgName: collegeData.college?[index].collegename,
                              clgAdd: collegeData.college?[index].address,
                              clgDetails: collegeData.college,
                              policy: collegeData.clgpolicySocialMedia?[index].termsCondition,
                              eligibility: collegeData.feeStructure?[index].eligibilityCriteria,
                              feeTerms: collegeData.feeStructure?[index].feeTerms,
                              // feeStructure: collegeData.feeStructure?.toList(),
                              safety: collegeData.highlight?[index].safetySecurity,
                              open: collegeData.college?[index].timings![0].open.toString(),
                              close: collegeData.college?[index].timings![0].close.toString(),
                              days: collegeData.college?[index].timings![0].monToSat.toString(),
                              history: collegeData.college?[index].history_achievements,
                              more_info: collegeData.college?[index].moreInfo,
                              description: collegeData.college?[index].description,
                              location: collegeData.college?[index].location,
                              webSiteLink: collegeData.clgpolicySocialMedia?[index].website,
                              staffList: nearbyStaffList,
                              subjectName: subjectInfoList,
                              socialMedia: socialMediaInfoList,
                              clgImageList: clgImageInfoList,
                              videoList: videoUrlInfoList,

                              // all for College Details.......
                              clgType: collegeData.college?[index].classType,
                              academicType: collegeData.college?[index].academicType,
                              affiliated: collegeData.college?[index].affiliated,
                              classType: collegeData.college?[index].classType,
                              classrooms: collegeData.college?[index].classRooms,
                              totalSeats: collegeData.college?[index].totalSeats,
                              totalFloors: collegeData.college?[index].noOfFloors,
                              totalArea: collegeData.college?[index].collegeArea,
                              clgCode: collegeData.college?[index].collegeCode,
                            );
                          } else {
                            print("not match Data Data Data.. in filter screen");
                            return SizedBox.shrink();
                          }
                        },
                        separatorBuilder: (context, index) => SizedBox(height: 30.0),
                      ),
                    );
                    // } else {
                    //   return Center(
                    //   child: Column(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: const [
                    //       Icon(
                    //         Icons.maps_home_work_outlined,
                    //         size: 40,
                    //         color: Colors.black54,
                    //       ),
                    //       SizedBox(
                    //         height: 10,
                    //       ),
                    //       Text(
                    //         "No Colleges Found",
                    //         style: TextStyle(
                    //             fontSize: 18,
                    //             fontWeight: FontWeight.w700,
                    //             color: Colors.black54),
                    //       )
                    //     ],
                    //   ),
                    // );
                    // }
                  } else {
                    print("not match any college college..");
                    return Center(
                        child: Text(
                      "No Colleges Found",
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ));
                  }
                },
              ),
            )),
            Positioned(
              bottom: 30.h,
              left: MediaQuery.of(context).size.width / 2.5,
              right: MediaQuery.of(context).size.width / 2.5,
              child: Material(
                color: Colors.black,
                borderRadius: BorderRadius.circular(100),
                child: InkWell(
                  // borderRadius: BorderRadius.circular(100),
                  onTap: () {
                    Get.to(MapScreen());
                  },
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 08.h, horizontal: 12.w),
                    child: Row(
                      children: [
                        Icon(
                          Icons.menu_book_rounded,
                          size: 18,
                          color: Colors.white,
                        ),
                        SizedBox(width: 6.w),
                        Text(
                          "Map",
                          style:
                              TextStyle(color: Colors.white, fontSize: 11.sp),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
