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

class DashboardScreen extends StatefulWidget {
  final String? scannedCollegeId;
  final bool isFromQrScan;
  const DashboardScreen({
    super.key, 
    this.scannedCollegeId,
    this.isFromQrScan = false,
  });

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    // Set initial tab to home
    kDashboardController.selectedBottomNavBarButton.value = BottomNavBarMenuEnum.home;
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // Reset focus when app is resumed
      SystemChannels.textInput.invokeMethod('TextInput.hide');
      FocusScope.of(context).unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    print("Student ID login Screen: ${StudentDetails.studentId}");
    print("Name: ${StudentDetails.name}");
    print("Mobile: ${StudentDetails.mobile}");
    print("Email: ${StudentDetails.email}");
    print("School: ${StudentDetails.schoolName}");
    print("Role: ${StudentDetails.role}");
    print("Scanned College ID: ${widget.scannedCollegeId}");
    print("Is from QR scan: ${widget.isFromQrScan}");

    return StatusBarTheme(
      value: SystemUiOverlayStyle.light,
      child: PopScope(
        canPop: false,
        onPopInvoked: (didPop) {
          if (didPop) return;
          if (Get.currentRoute == '/dashboard') {
            // If we're at the dashboard and back is pressed, show exit dialog
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text('Exit App?'),
                content: Text('Are you sure you want to exit?'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () => SystemNavigator.pop(),
                    child: Text('Exit'),
                  ),
                ],
              ),
            );
          } else {
            // If we're in any other screen, just go back
            Get.back();
          }
        },
        child: Scaffold(
          backgroundColor: Color.fromRGBO(244, 245, 247, 1),
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(100 + MediaQuery.of(context).padding.top),
            child: DashboardAppBar(),
          ),
          body: GestureDetector(
            onTap: () {
              // Unfocus when tapping outside
              FocusScope.of(context).unfocus();
            },
            child: Obx(() {
              switch (kDashboardController.selectedBottomNavBarButton.value) {
                case BottomNavBarMenuEnum.home:
                  return HomeScreen(
                    collageId: widget.scannedCollegeId,
                    isFromQrScan: widget.isFromQrScan,
                  );

                case BottomNavBarMenuEnum.pretest:
                  return PretestScreen();

                case BottomNavBarMenuEnum.favorite:
                  return FavCollageScreen();

                case BottomNavBarMenuEnum.offers:
                  return OffersScreen();

                case BottomNavBarMenuEnum.needHelp:
                  return NeedHelpWidget(
                    isOpenFromNavBar: true,
                  );

                default:
                  return HomeScreen();
              }
            }),
          ),
          drawer: DashboardDrawer(),
          bottomNavigationBar: BottomNavBarWidget(),
        ),
      ),
    );
  }
}
