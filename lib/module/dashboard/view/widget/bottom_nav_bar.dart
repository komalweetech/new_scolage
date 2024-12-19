import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../utils/enum/ui_enum.dart';
import '../../../../utils/theme/common_color.dart';
import '../../dependencies/dashboard_dependencies.dart';

class BottomNavBarWidget extends StatelessWidget {
  const BottomNavBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
      decoration: BoxDecoration(
        color: kPrimaryColor,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(14.r),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 2.h),
          Container(width: 30.w, height: 1.5.h, color: Colors.white),
          Row(
            children: [
              SizedBox(width: 10.w),
              // HOME .
              BottomNavBarButton(
                buttonData: BottomNavBarMenuEnum.home,
                onTap: () {
                  kDashboardController.selectedBottomNavBarButton.value =
                      BottomNavBarMenuEnum.home;
                },
              ),
              // PROTEST .
              BottomNavBarButton(
                buttonData: BottomNavBarMenuEnum.pretest,
                onTap: () {
                  kDashboardController.selectedBottomNavBarButton.value =
                      BottomNavBarMenuEnum.pretest;
                },
              ),
              // FAVORITE .
              BottomNavBarButton(
                buttonData: BottomNavBarMenuEnum.favorite,
                onTap: () {
                  kDashboardController.selectedBottomNavBarButton.value =
                      BottomNavBarMenuEnum.favorite;
                },
              ),
              // OFFERS .
              BottomNavBarButton(
                buttonData: BottomNavBarMenuEnum.offers,
                onTap: () {
                  kDashboardController.selectedBottomNavBarButton.value =
                      BottomNavBarMenuEnum.offers;
                },
              ),
              // NEED HELP
              BottomNavBarButton(
                buttonData: BottomNavBarMenuEnum.needHelp,
                onTap: () {
                  kDashboardController.selectedBottomNavBarButton.value =
                      BottomNavBarMenuEnum.needHelp;
                },
              ),
              SizedBox(width: 10.w),
            ],
          ),
          SizedBox(height: 2.h),
        ],
      ),
    );
  }
}

class BottomNavBarButton extends StatelessWidget {
  const
  BottomNavBarButton(
      {super.key, required this.buttonData, required this.onTap});
  final BottomNavBarMenuEnum buttonData;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12.r),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Obx(
                  () => Image.asset(
                    kDashboardController.selectedBottomNavBarButton.value ==
                            buttonData
                        ? buttonData.selectedIconLink
                        : buttonData.iconLink,
                    height: 28.h,
                    width: 28.w,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  buttonData.displayName,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10.sp,
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
