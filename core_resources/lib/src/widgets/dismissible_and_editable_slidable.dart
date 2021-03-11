import 'package:flutter/material.dart';

class DismissibleAndEditableSlidable extends StatelessWidget {
  const DismissibleAndEditableSlidable({
    required this.itemKey,
    required this.onDismissed,
    required this.onEdited,
    required this.child,
    this.confirmDismiss,
    this.backgroundDismiss,
    this.backgroundEdit,
  });

  final Key itemKey;
  final Future<bool> Function()? confirmDismiss;
  final void Function() onDismissed;
  final void Function() onEdited;
  final Widget? backgroundDismiss;
  final Widget? backgroundEdit;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: itemKey,
      direction: DismissDirection.horizontal,
      confirmDismiss: (direction) async {
        switch (direction) {
          case DismissDirection.endToStart:
            return (await confirmDismiss?.call()) ?? true;
          case DismissDirection.startToEnd:
            onEdited();
            return false;
          default:
            return true;
        }
      },
      onDismissed: (direction) => onDismissed(),
      secondaryBackground: backgroundDismiss ??
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
      background: backgroundEdit ??
          Container(
            alignment: Alignment.centerLeft,
            color: Colors.blue,
            child: Container(
              padding: const EdgeInsets.all(8),
              child: Icon(
                Icons.edit,
                size: 24,
                color: Colors.white,
              ),
            ),
          ),
      child: child,
    );
  }
}
