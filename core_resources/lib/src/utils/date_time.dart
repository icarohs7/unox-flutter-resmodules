import 'package:dartx/dartx.dart';

/// Convert String of format HH:mm:ss
/// or HH:mm to [Duration] object
Duration parseDuration(String duration) {
  if (!duration.contains(':')) throw FormatException('Invalid duration string');
  final parts = duration.split(':');
  final hours = parts.elementAtOrDefault(0, '0').toIntOrNull() ?? 0;
  final minutes = parts.elementAtOrDefault(1, '0').toIntOrNull() ?? 0;
  final seconds = parts.elementAtOrDefault(2, '0').toIntOrNull() ?? 0;
  return Duration(hours: hours, minutes: minutes, seconds: seconds);
}
