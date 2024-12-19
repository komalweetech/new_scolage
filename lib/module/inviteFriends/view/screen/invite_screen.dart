// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../utils/commonFunction/common_function.dart';
import '../../../../utils/commonFunction/common_toast.dart';
import '../../../../utils/commonWidget/common_screen_content_title.dart';
import '../../../../utils/commonWidget/common_sq_text_button.dart';
import '../../../../utils/commonWidget/common_sub_screen_app_bar.dart';
import '../../../../utils/commonWidget/common_vertical_divider.dart';
import '../../../../utils/commonWidget/status_bar_theme.dart';
import '../../../../utils/constant/asset_icons.dart';
import '../../../../utils/enum/ui_enum.dart';
import '../../dependencies/invite_screen_dependencies.dart';
import '../widget/share_button_ui.dart';

class InviteScreen extends StatefulWidget {
  const InviteScreen({super.key});

  @override
  State<InviteScreen> createState() => _InviteScreenState();
}

class _InviteScreenState extends State<InviteScreen> {
  @override
  Widget build(BuildContext context) {
    return StatusBarTheme(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        appBar: const CommonSubScreenAppBar(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CommonScreenContentTitle(title: "Invite"),
            SizedBox(height: 20.h),
            Row(
              children: [
                // INVITE .
                Obx(
                  () => CommonSqTextButton(
                    name: InviteScreenTabEnum.invite.displayName,
                    onTap: () {
                      kInviteController.selectedTab.value =
                          InviteScreenTabEnum.invite;
                    },
                    isSelected: kInviteController.selectedTab.value ==
                        InviteScreenTabEnum.invite,
                    color: kInviteController.selectedTab.value == InviteScreenTabEnum.invite ? Colors.black  : Colors.grey,

                  ),
                ),
                // FAQ .
                Obx(
                  () => CommonSqTextButton(
                    name: InviteScreenTabEnum.faq.displayName,
                    onTap: () {
                      kInviteController.selectedTab.value =
                          InviteScreenTabEnum.faq;
                    },
                    isSelected: kInviteController.selectedTab.value ==
                        InviteScreenTabEnum.faq,

                    color: kInviteController.selectedTab.value == InviteScreenTabEnum.faq ? Colors.black  : Colors.grey,
                  ),
                ),
              ],
            ),
            CommonDivider(thickness: .3.h,color: Colors.grey,),
            SizedBox(height: 22.h),
            Row(
              children: [
                SizedBox(width: 50.w),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Your invitation code",
                      style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 10,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 5.h),
                    Text(
                      "RAJAR5M6EQ",
                      style: TextStyle(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 3,
                          fontFamily: "Poppins"),
                    ),
                  ],
                ),
                Spacer(),
                Image.asset(AssetIcons.INVITE_IMAGE_ICON, height: 100.h),
                SizedBox(width: 50.w),
              ],
            ),
            SizedBox(height: 22.h),
            CommonDivider(thickness: .5.h,color: Colors.grey,),
            SizedBox(height: 16.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ShareButtonUi(
                  onTap: () async {
                    await CommonFunction.openWhatsApp("RAJAR5M6EQ");
                  },
                  icon: Image.asset(
                    AssetIcons.WHATSAPP_ICON,
                    height: 35.h,
                    color: Colors.black,
                  ),
                  name: "Whatsapp",
                  centerPadding: 0,
                ),
                ShareButtonUi(
                  onTap: () async {
                    await Clipboard.setData(ClipboardData(text: "RAJAR5M6EQ"));
                    CommonToast.showToast("Copied", StatusType.info);
                  },
                  icon: Icon(Icons.copy),
                  name: "Copy Code",
                ),
                ShareButtonUi(
                  onTap: () async {
                    await Share.share('RAJAR5M6EQ');
                  },
                  icon: Icon(Icons.share_outlined),
                  name: "Share",
                ),
              ],
            ),
            SizedBox(height: 16.h),
            CommonDivider(thickness: .5.h,color: Colors.grey,),

          ],
        ),
      ),
    );
  }
}
