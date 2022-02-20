import 'package:intl/intl.dart';

final dayMonthYearDateFormatter = DateFormat('dd MMMM yyyy', 'id');
final standardDateTimeFormatter = DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'");
final yearMonthYearDateFormatter = DateFormat('yyyy-MM-dd');

extension DateTimeStringFormatter on String {
  DateTime get toCompleteDate => standardDateTimeFormatter.parse(this);

  String get toDayMonthYearFormat =>
      dayMonthYearDateFormatter.format(toCompleteDate);
}

extension DateTimeFormatter on DateTime {
  String get toDayMonthYearFormat => dayMonthYearDateFormatter.format(this);

  String get toYearMonthDayFormat => yearMonthYearDateFormatter.format(this);
}
