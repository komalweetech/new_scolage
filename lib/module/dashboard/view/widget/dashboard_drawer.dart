// ignore_for_file: prefer_const_constructors
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import '../../../../utils/StudentDetails.dart';
import '../../../../utils/commonFunction/common_function.dart';
import '../../../../utils/commonWidget/common_vertical_divider.dart';
import '../../../../utils/constant/asset_icons.dart';
import '../../../../utils/theme/common_color.dart';
import '../../../inviteFriends/view/screen/invite_screen.dart';
import '../../../need_help/view/screen/need_help_screen.dart';
import '../../../profile/dependencies/profile_dependencies.dart';
import '../../../profile/view/screen/profile_detail_screen.dart';
import '../../../setting/view/screen/languge_setting_screen.dart';
import '../../../setting/view/screen/privacy_and_policy_screen.dart';
import '../widget/drawer_menu_list_tile.dart';

class DashboardDrawer extends StatelessWidget {
  const DashboardDrawer({super.key});

  void _exitApp(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Exit App'),
          content: Text('Are you sure you want to exit?'),
          actions: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: cancelButton,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: exitAppButton),
              onPressed: () {
                // Close the drawer before exiting
                Navigator.of(context).pop();

                // Exit the app
                SystemNavigator.pop();
              },
              child: Text('Exit'),
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    print("drawer screen studentId = ${StudentDetails.studentId}");
    return Drawer(
      // backgroundColor: Color.fromRGBO(242, 242, 242, 1),
      backgroundColor: Color(0xfff1f1f1),
      child: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 35.h),
            // PROFILE .
            InkWell(
              onTap: () {
                CommonFunction.kNavigatorPush(
                  context,
                  ProfileDetailScreen(),
                );
                print("student id in drawer screen: ${StudentDetails.studentId}");
                Scaffold.of(context).closeDrawer();
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(width: 20.w),
                    Container(
                      height: 47.h,
                      width: 47.w,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30)),
                      // child: Center(
                      //   child:
                      //       Image.asset(AssetIcons.PROFILE_ICON, height: 26.h),
                      // ),
                      child: Obx(
                            () => kProfileController
                            .selectedProfilePickLink.value != ''
                            ? ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Obx(
                                () => Image.file(
                              File(
                                kProfileController
                                    .selectedProfilePickLink.value,
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                            : SizedBox(),
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            StudentDetails.name,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,fontFamily: "Poppins",fontWeight: FontWeight.w600
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            "+91 ${StudentDetails.mobile}",
                            style: TextStyle(
                              color: Color.fromRGBO(128, 128, 128, 1),
                              fontSize: 14,fontFamily: "Poppins",
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.keyboard_arrow_right_rounded,
                      size: 20,
                      color: Color.fromRGBO(128, 128, 128, 1),
                    ),
                    SizedBox(width: 20.w),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20.h),
            CommonDivider(),
            SizedBox(height: 20.h),
            // // Favorite Colleges.
            // DrawerMenuListTile(
            //   icon: AssetIcons.FAVORITE_ICON,
            //   name: "view favorite college",
            //   onTap: () {
            //     CommonFunction.kNavigatorPush(
            //       context,
            //         DrawerFavoriteScreen(),
            //     );
            //     Scaffold.of(context).closeDrawer();
            //   },
            // ),
            //Need help.
            DrawerMenuListTile(
              icon: AssetIcons.DRAWER_NEED_HELP_ICON,
              name: "Need help",
              onTap: () {
                CommonFunction.kNavigatorPush(
                  context,
                  NeedHelpScreen()
                );
                Scaffold.of(context).closeDrawer();
              },
            ),
            // PRIVACY AND POLICY
            DrawerMenuListTile(
              icon: AssetIcons.LOCK_ICON,
              name: "Privacy policy",
              onTap: () {
                CommonFunction.kNavigatorPush(
                  context,
                  PrivacyAndPolicyScreen(),
                );
                Scaffold.of(context).closeDrawer();
              },
            ),
            // INVITE FRIENDS
            DrawerMenuListTile(
              icon: AssetIcons.INVITE_FRIEND_ICON,
              name: "Invite Friends",
              onTap: () {
                CommonFunction.kNavigatorPush(
                  context,
                  InviteScreen(),
                );
                Scaffold.of(context).closeDrawer();
              },
            ),
            // SETTING SCREEN
            DrawerMenuListTile(
              icon: AssetIcons.DRAWER_SETTING_ICON,
              name: "Settings",
              onTap: () {
                CommonFunction.kNavigatorPush(context, LanguageSettingScreen(),
                );
                Scaffold.of(context).closeDrawer();
              },
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.only(
                top: 10,
                bottom: 10,
              ),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kPrimaryColor,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    _exitApp(context);
                  },
                  child: Text(
                    " Exit ",
                    style: TextStyle(fontSize: 20),
                  )),
            ),
            Text(
              "Version 2.3",
              style: TextStyle(fontSize: 12),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}
