import 'package:intl/intl.dart';

extension TimeExtensions on DateTime {
  ///Convert the given DateTime object to
  ///string using the given [format]
  ///and [locale]
  String string([String? format, String? locale]) => DateFormat(format, locale).format(this);

  ///Modify the value of the given DateTime object
  DateTime update({
    int? year,
    int? month,
    int? day,
    int? hour,
    int? minute,
    int? second,
    int? millisecond,
    int? microsecond,
  }) {
    return DateTime(
      year ?? this.year,
      month ?? this.month,
      day ?? this.day,
      hour ?? this.hour,
      minute ?? this.minute,
      second ?? this.second,
      millisecond ?? this.millisecond,
      microsecond ?? this.microsecond,
    );
  }
}
