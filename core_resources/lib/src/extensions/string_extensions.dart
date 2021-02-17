import 'package:dartx/dartx.dart';

extension StringExtensions on String {
  /// Returns the result of the given function
  /// if the string if blank
  T ifBlank<T>(T Function() defaultValue) {
    return isBlank ? defaultValue() : this;
  }

  /// Returns the result of the given function
  /// if the string if empty
  T ifEmpty<T>(T Function() defaultValue) {
    return isEmpty ? defaultValue() : this;
  }

  /// Returns the string up to the first
  /// [maxLength] characters, replacing any
  /// extra characters with an elipsis if
  /// the parameter is true
  String truncateTo(int maxLength, {bool elipsis = false}) {
    return (length <= maxLength)
        ? this
        : elipsis
            ? '${substring(0, maxLength)}...'
            : substring(0, maxLength);
  }
}
