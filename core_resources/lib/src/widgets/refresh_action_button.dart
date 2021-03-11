import 'package:flutter/material.dart';

/// Refresh icon button that turns into a
/// [CircularProgressIndicator] according to
/// the parameter [isRefreshing], also disabling
/// its [onTap] when true
class RefreshActionButton extends StatelessWidget {
  const RefreshActionButton({
    this.isRefreshing = false,
    this.onTap,
  });

  final bool isRefreshing;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: isRefreshing
          ? Container(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.white),
                strokeWidth: 2,
              ),
            )
          : Icon(Icons.refresh),
      onPressed: isRefreshing ? null : onTap,
    );
  }
}
