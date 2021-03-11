import 'dart:async';

import 'package:core_resources/src/utils/ui.dart';
import 'package:flutter/material.dart';

class SplashWidget<T> extends StatefulWidget {
  const SplashWidget({
    Key? key,
    required this.future,
    required this.child,
    required this.onComplete,
  }) : super(key: key);

  final Future<T> future;
  final Widget child;
  final FutureOr<void> Function(BuildContext context, T? value) onComplete;

  @override
  _SplashWidgetState createState() => _SplashWidgetState<T>();
}

class _SplashWidgetState<T> extends State<SplashWidget<T>> {
  _SplashWidgetState();

  @override
  void initState() {
    super.initState();
    hideTopSystemOverlay();
    Future(() async {
      T? result;
      try {
        result = await widget.future;
      } catch (e) {
        print('Error on Splash loading:\n$e');
      }
      await showSystemOverlays();
      await widget.onComplete(context, result);
    }).then((_) => null);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
