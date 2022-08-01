import 'package:intl/intl.dart';

class AppDateFormatter{

  static const String fullDateFormat = 'yMMMd';
  static String getReleaseDate(String receive){
    final DateTime date = DateTime.parse(receive);
    return date.year.toString();
  }
  static String getFullReleaseDate({required String receive, String format = fullDateFormat}){
    final DateTime date = DateTime.parse(receive);
    return DateFormat(format).format(date);
  }
}
