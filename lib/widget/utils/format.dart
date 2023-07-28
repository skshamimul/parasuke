import 'package:intl/intl.dart';

class Format {
  static String hours(double hours) {
    final double hoursNotNegative = hours < 0.0 ? 0.0 : hours;
    final NumberFormat formatter = NumberFormat.decimalPattern();
    final String formatted = formatter.format(hoursNotNegative);
    return '${formatted}h';
  }

  static String date(DateTime date) {
    return DateFormat.yMMMd().format(date);
  }

  static String dayOfWeek(DateTime date) {
    return DateFormat.E().format(date);
  }

  static String currency(double pay) {
    if (pay != 0.0) {
      final NumberFormat formatter = NumberFormat.simpleCurrency(decimalDigits: 0);
      return formatter.format(pay);
    }
    return '';
  }
}
