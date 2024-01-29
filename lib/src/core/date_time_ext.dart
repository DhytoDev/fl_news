import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class InvalidDateFormatException implements Exception {}

extension DateTimeExt on String {
  String toDateFormat({
    String dateFormat = 'dd MMM, HH:mm',
    bool toUtc = false,
    bool toLocal = false,
    String? locale = 'id',
  }) {
    if (toUtc && toLocal) throw InvalidDateFormatException();

    initializeDateFormatting(locale, null);

    final format = DateFormat(dateFormat, locale);

    if (!toUtc && !toLocal) return format.format(toDateTime);

    final date = toUtc ? toDateTime.toUtc() : toDateTime.toLocal();

    return format.format(date);
  }

  DateTime get toDateTime => DateTime.parse(this);
}
