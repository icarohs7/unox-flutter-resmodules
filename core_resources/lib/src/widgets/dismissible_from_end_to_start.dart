import 'package:flutter/material.dart';

class DismissibleFromEndToStart extends StatelessWidget {
  const DismissibleFromEndToStart({
    required this.itemKey,
    required this.onDismissed,
    required this.child,
    this.confirmDismiss,
    this.background,
  });

  final Key itemKey;
  final Future<bool> Function()? confirmDismiss;
  final void Function() onDismissed;
  final Widget? background;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: itemKey,
      direction: DismissDirection.endToStart,
      confirmDismiss: (_) => confirmDismiss?.call() ?? Future.value(true),
      onDismissed: (_) => onDismissed(),
      background: background ??
          Container(
            alignment: Alignment.centerRight,
            color: Color(0xFFE3000F),
            child: Container(
              padding: const EdgeInsets.all(8),
              child: Icon(
                Icons.delete,
                size: 24,
                color: Colors.white,
              ),
            ),
          ),
      child: child,
    );
  }
}
