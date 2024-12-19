import 'package:get/get.dart';

import '../../../utils/enum/setting_enum.dart';


class SettingController extends GetxController {
  Rx<LanguagesEnum> selectedLanguage = Rx(LanguagesEnum.english);
}
