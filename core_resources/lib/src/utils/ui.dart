import 'dart:async';

import 'package:core_resources/src/widgets/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<bool> askConfirmation(
  BuildContext context, {
  String? titleText,
  Widget? title,
  Widget? content,
  FutureOr<void> Function()? onConfirm,
  FutureOr<void> Function()? onCancel,
  String? cancelText,
  String? confirmText,
}) async {
  return showConfirmDialog(
    context,
    title: titleText != null ? Text(titleText) : title,
    content: content,
    onConfirm: onConfirm,
    onCancel: onCancel,
    cancelText: cancelText,
    confirmText: confirmText,
  );
}

Future<void> showSystemOverlays() async {
  await SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
}

Future<void> hideTopSystemOverlay() async {
  await SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
}

Future<void> hideSystemOverlays() async => await SystemChrome.setEnabledSystemUIOverlays([]);

///Create a material swatch with variations of
///a base color, credits to [Filip Veličković](https://medium.com/@filipvk/creating-a-custom-color-swatch-in-flutter-554bcdcb27f3)
MaterialColor createMaterialColor(Color color) {
  final strengths = <double>[.05];
  final swatch = <int, Color>{};
  final r = color.red, g = color.green, b = color.blue;

  for (var i = 1; i < 10; i++) strengths.add(0.1 * i);

  for (final strength in strengths) {
    final ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}
