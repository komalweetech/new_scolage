abstract class AllRegExp {
  static RegExp amountRegExp = RegExp(r'^\d+\.?\d{0,2}');
  static RegExp mobileNumberRegExp = RegExp(r'(^(?:[+0]9)?[0-9]{10}$)');
  static RegExp fullNameRegExp = RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%\s-]');
}
