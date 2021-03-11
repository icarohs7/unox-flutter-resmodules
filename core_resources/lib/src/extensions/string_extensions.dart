import 'package:dartx/dartx.dart';

extension StringExtensions on String {
  /// Returns the result of the given function
  /// if the string is blank
  String ifBlank(String Function() defaultValue) {
    return isBlank ? defaultValue() : this;
  }

  /// Returns the result of the given function
  /// if the string is empty
  String ifEmpty(String Function() defaultValue) {
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

  /// Returns the substring after the last
  /// occurrence of [pattern], including it
  /// if [patternIncluded] is true
  String afterLast(String pattern, {bool patternIncluded = false}) {
    final index = lastIndexOf(pattern);
    if (index == -1) return '';
    if (index >= length) return patternIncluded ? pattern : '';
    return substring(index + (patternIncluded ? 0 : pattern.length));
  }
}
