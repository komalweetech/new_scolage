// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../../utils/StudentDetails.dart';
import '../../../../utils/commonWidget/status_bar_theme.dart';
import '../../../../utils/enum/ui_enum.dart';
import '../../../auth/dependencies/auth_dependencies.dart';
import '../../../favCollege/view/screen/fav_college_screen.dart';
import '../../../home/view/screen/home_screen.dart';
import '../../../need_help/view/widget/need_help_widget.dart';
import '../../../offeres/view/screen/offers_screen.dart';
import '../../../pretest/view/screen/Pretest_screen.dart';
import '../../dependencies/dashboard_dependencies.dart';
import '../widget/bottom_nav_bar.dart';
import '../widget/dashboard_app_bar.dart';
import '../widget/dashboard_drawer.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print("Student ID login Screen: ${StudentDetails.studentId}");
    print("Name: ${StudentDetails.name}");
    print("Mobile: ${StudentDetails.mobile}");
    print("Email: ${StudentDetails.email}");
    print("School: ${StudentDetails.schoolName}");
    print("Role: ${StudentDetails.role}");
    print("number login screen == ${kAuthController.phoneNumberController.text}");

    return StatusBarTheme(
      value: SystemUiOverlayStyle.light,
      child: PopScope(
        canPop: false,
        child: Scaffold(
          backgroundColor: Color.fromRGBO(244, 245, 247, 1),
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(100 + MediaQuery.of(context).padding.top),
            child: DashboardAppBar(),
          ),
          body: Obx(() {
            switch (kDashboardController.selectedBottomNavBarButton.value) {
              case BottomNavBarMenuEnum.home:
                return HomeScreen();

              case BottomNavBarMenuEnum.pretest:
                return PretestScreen();

              case BottomNavBarMenuEnum.favorite:
                return FavCollageScreen();

              case BottomNavBarMenuEnum.offers:
                return  OffersScreen();

              case BottomNavBarMenuEnum.needHelp:
                return NeedHelpWidget(
                  isOpenFromNavBar: true,
                );

              default:
                return HomeScreen();
            }
          }),
          drawer: DashboardDrawer(),
          bottomNavigationBar: BottomNavBarWidget(),
        ),
      ),
    );
  }
}
