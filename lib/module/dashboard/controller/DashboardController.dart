// ignore_for_file: file_names

import 'package:get/get.dart';

import '../../../utils/enum/ui_enum.dart';

class DashboardController extends GetxController {
  Rx<BottomNavBarMenuEnum> selectedBottomNavBarButton =
      BottomNavBarMenuEnum.home.obs;
}
