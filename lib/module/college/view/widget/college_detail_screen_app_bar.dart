import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../utils/StudentDetails.dart';
import '../../../../utils/commonFunction/common_function.dart';
import '../../../../utils/constant/asset_icons.dart';
import '../../../../utils/theme/common_color.dart';
import '../../../favCollege/services/favorites_Api.dart';
import '../../../favCollege/view/screen/fav_college_screen.dart';
import '../../dependencies/college_dependencies.dart';
import '../screen/review_screen.dart';

class CollegeDetailScreenAppBar extends StatefulWidget {
  const CollegeDetailScreenAppBar({super.key, required this.controller,required this.clgList,required this.clgId,this.webSiteLink});
  final AutoScrollController controller;
  final List<dynamic> clgList;
  final String clgId;
  final String? webSiteLink;

  @override
  State<CollegeDetailScreenAppBar> createState() =>
      _CollegeDetailScreenAppBarState();
}

class _CollegeDetailScreenAppBarState extends State<CollegeDetailScreenAppBar> {

  @override
  void initState() {
    // kCollegeController.expandAllDetail();
    kCollegeController.expandCollegeDetail.value = false;

    kCollegeController.showTabBar.value = false;
    kCollegeController.selectedTabInt.value = 0;
    super.initState();
    print("college share link is == ${widget.webSiteLink}");

  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      child: Obx(
        () => Container(
          color: kCollegeController.showTabBar.value
              ? Colors.white
              : Colors.transparent,
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 12.h),
                Row(
                  children: [
                    SizedBox(width: 20.w),
                    SizedBox(
                      height: 32.h,
                      width: 32.h,
                      child: Material(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.circular(
                          20.r,
                        ),
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Image.asset(
                            AssetIcons.COLLEGE_DETAIL_SCREEN_BACK_ARROW_ICON,
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    Material(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(9.r),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(9.r),
                        onTap: () async {
                          try {
                            if (FavoriteColleges.isFavorite(widget.clgId)) {
                              //  remove from favorites Colleges List
                              await FavoriteApi.deleteApi(widget.clgId, StudentDetails.studentId);
                              print("this college delete in favorite college List");
                            } else {
                              //  add to favorites college List
                              await FavoriteApi.postApi(widget.clgId, StudentDetails.studentId);
                              print("this college add in Favorite college List");
                            }
                            setState(() {
                              FavoriteColleges.toggleFavorite(widget.clgId);
                            });
                          } catch (e) {
                            print('Error: $e');
                          }
                          },
                        child: Container(
                          height: 30.h,
                          width: 30.h,
                          padding: const EdgeInsets.all(6),
                          child:  FavoriteColleges.isFavorite(widget.clgId)
                              ? Image.asset( AssetIcons.BOOKMARK_ICON,color: Colors.red)
                              : Image.asset(AssetIcons.BOTTOM_NAV_BAR_FAVORITE_ICON, color: kPrimaryColor, height: 18.h,),
                        ),
                      ),
                    ),
                    SizedBox(width: 18.w),
                    Material(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(9.r),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(9.r),
                        onTap: () async {
                          print("college social media link is = ${widget.webSiteLink}");
                          await Share.share("Click this link : ${widget.webSiteLink}");
                        },
                        child: Container(
                          height: 30.h,
                          width: 30.h,
                          padding: const EdgeInsets.all(6),
                          child: Image.asset(
                            AssetIcons.SHARE_ICON,
                            height: 18.h,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 30.w),
                  ],
                ),
                SizedBox(height: 6.h),
                Obx(
                  () => Visibility(
                    visible: kCollegeController.showTabBar.value,
                    child: SizedBox(
                      height: 36.h,
                      child: ListView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        scrollDirection: Axis.horizontal,
                        itemCount: kCollegeController.tabViewList.length,
                        itemBuilder: (context, index) => Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () async {
                              kCollegeController.selectedTabInt.value = index;
                              kCollegeController.expandDetailWhenTapOnTab(index);
                              if (index == 8) {
                                CommonFunction.kNavigatorPush(
                                  context,
                                   ReviewScreen(clgId: widget.clgId,),
                                );
                              } else {
                                kCollegeController.expandCollegeDetail.value = true;
                                await widget.controller.scrollToIndex(
                                  index + 1,
                                  preferPosition: AutoScrollPosition.middle,
                                );
                              }
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15.w, vertical: 8.h),
                              child: Obx(
                                () => Text(
                                  kCollegeController.tabViewList[index],
                                  style: TextStyle(
                                    color: kCollegeController.selectedTabInt.value == index
                                        ? const Color.fromRGBO(51, 51, 51, 1)
                                        : const Color.fromRGBO(166, 168, 171, 1),
                                      fontFamily: "Poppins",
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

