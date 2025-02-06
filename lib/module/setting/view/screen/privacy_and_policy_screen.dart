import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../../utils/commonWidget/common_screen_content_title.dart';
import '../../../../utils/commonWidget/common_sub_screen_app_bar.dart';
import '../../../../utils/commonWidget/common_vertical_divider.dart';
import '../../../../utils/constant/asset_icons.dart';
import '../../../../utils/constant/ui_string_const.dart';

class PrivacyAndPolicyScreen extends StatefulWidget {
  const PrivacyAndPolicyScreen({super.key});

  @override
  State<PrivacyAndPolicyScreen> createState() => _PrivacyAndPolicyScreenState();
}

class _PrivacyAndPolicyScreenState extends State<PrivacyAndPolicyScreen> {
  final String url = 'https://sites.google.com/weetechsolution.com/scolage/home';

  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted) // Enable JavaScript if needed
      ..loadRequest(Uri.parse(url));

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonSubScreenAppBar(),
      body: WebViewWidget(controller: controller),
      // ListView(
      //   children: [
      //     const CommonScreenContentTitle(
      //       title: "Privacy policy",
      //     ),
      //     SizedBox(height: 20.h),
      //     Padding(
      //       padding: EdgeInsets.symmetric(horizontal: 22.w),
      //       child: Column(
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         children: [
      //           const CommonDivider(),
      //           // LOGO .
      //           Padding(
      //             padding: EdgeInsets.symmetric(vertical: 13.h),
      //             child: Center(
      //               child: SizedBox(
      //                 height: 45.h,
      //                 child: Image.asset(
      //                     AssetIcons.PRIVACY_POLICY_SCREEN_APP_LOGO_ICON),
      //               ),
      //             ),
      //           ),
      //           const CommonDivider(),
      //           SizedBox(height: 18.h),
      //           //! 1
      //           Text(
      //             UiStringConst
      //                 .privacyAndPolicyStringConst.scolagePrivacyNoticeTitle,
      //             style: TextStyle(
      //               fontSize: 19.sp,
      //             ),
      //           ),
      //           SizedBox(height: 16.h),
      //           Text(
      //             "last pdated:15/08/2025",
      //             style: TextStyle(
      //               fontSize: 8.5.sp,
      //             ),
      //           ),
      //           SizedBox(height: 6.h),
      //           Text(
      //             UiStringConst.privacyAndPolicyStringConst.privacyNotice,
      //             style: TextStyle(
      //               fontSize: 11.sp,
      //             ),
      //           ),
      //           SizedBox(height: 20.h),
      //           const CommonDivider(),
      //
      //           //! 2
      //           SizedBox(height: 10.h),
      //           Text(
      //             UiStringConst
      //                 .privacyAndPolicyStringConst.infoAboutScolageTitle,
      //             style: TextStyle(
      //               fontSize: 19.sp,
      //             ),
      //           ),
      //           SizedBox(height: 16.h),
      //           Text(
      //             UiStringConst.privacyAndPolicyStringConst.scolageInformation,
      //             style: TextStyle(
      //               fontSize: 11.sp,
      //             ),
      //           ),
      //           SizedBox(height: 20.h),
      //
      //           const CommonDivider(),
      //
      //           //! 3
      //           SizedBox(height: 10.h),
      //           Text(
      //             UiStringConst
      //                 .privacyAndPolicyStringConst.scopeOfPolicyNoticeTitle,
      //             style: TextStyle(
      //               fontSize: 19.sp,
      //             ),
      //           ),
      //           SizedBox(height: 16.h),
      //           Text(
      //             UiStringConst.privacyAndPolicyStringConst.scopeOfPolicyNotice,
      //             style: TextStyle(
      //               fontSize: 11.sp,
      //             ),
      //           ),
      //         ],
      //       ),
      //     )
      //   ],
      // ),
    );
  }
}
