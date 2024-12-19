import 'package:flutter/material.dart';

import '../../../../utils/commonWidget/common_sub_screen_app_bar.dart';
import '../../../../utils/commonWidget/keyboard_off.dart';
import '../widget/need_help_widget.dart';

class NeedHelpScreen extends StatelessWidget {
  const NeedHelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const KeyBoardOff(
      child: Scaffold(
        appBar: CommonSubScreenAppBar(),
        body: NeedHelpWidget(),
      ),
    );
  }
}
