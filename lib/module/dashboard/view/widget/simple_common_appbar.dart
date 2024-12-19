import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../utils/commonWidget/keyboard_off.dart';
import '../../../../utils/constant/asset_icons.dart';
import '../../../../utils/theme/common_color.dart';

class SimpleCommonAppBar extends StatelessWidget {
  const SimpleCommonAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return KeyBoardOff(
        child: Stack(
         children: [
           Container(
             height: 130 + MediaQuery.of(context).padding.top,
             margin: EdgeInsets.only(bottom: 10),
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
                   Center(
                     child: Padding(
                       padding:  EdgeInsets.only(right: 20),
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           IconButton(style: IconButton.styleFrom(iconSize: 30),
                             onPressed: () {
                               Get.back();},
                             icon: const Icon(Icons.arrow_back ,
                               color: Colors.white,
                             ),
                           ),
                           Expanded(
                             child: Image.asset(
                               AssetIcons.APP_BAR_APP_LOGO_ICON,
                               height: 40,

                             ),
                           ),

                         ],
                       ),
                     ),
                   ),
                 ],
               ),
             ),
           ),
         ],
        ),);
  }
}
