import 'all_reg_exp.dart';

abstract class ValidatorConst {
  // VALIDATE MOBILE NUMBER
  static String? validateMobileNumber(String value) {
    if (value.isEmpty || value == '') {
      return 'Enter a Mobile Number';
    } else if (!AllRegExp.mobileNumberRegExp.hasMatch(value)) {
      return 'Please enter valid Mobile Number';
    } else {
      return null;
    }
  }

  // VALIDATE FULL NAME
  static String? validateFullName(String value, String fieldName) {
    value = value.trim();

    if (value.isEmpty) {
      return 'Enter a $fieldName';
    } else if (!AllRegExp.fullNameRegExp.hasMatch(value)) {
      return 'Enter a valid $fieldName';
    } else {
      return null;
    }
  }

  // EMPTY STRING VALIDATOR
  static String? validEmptyString(String value, String fieldName) {
    if (value.isEmpty || value == '') {
      return 'Enter $fieldName';
    } else {
      return null;
    }
  }

  //REFERENCE CODE VALIDATOR
  static String? validateReferenceCode(String value) {
    if (value.isEmpty || value == '') {
      return 'Enter a Invite Code';
    } else if (value.length < 8) {
      return 'Please enter valid Invite Code';
    } else {
      return null;
    }
  }
}
