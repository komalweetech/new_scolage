import 'package:intl/intl.dart';

class CommonDateFormats {
  // DT TO DD-MM-YYYY
  static String dtToDDMMYYYY(DateTime dateTime) {
    return DateFormat('dd-MM-yyyy').format(dateTime);
  }
}
