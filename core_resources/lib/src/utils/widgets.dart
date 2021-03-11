import 'package:flutter/cupertino.dart';

RelativeRect? getWidgetPositionAsRelativeRect(BuildContext context, {Offset? offset}) {
  final inkWell = context.findRenderObject();
  final overlay = Overlay.of(context)?.context.findRenderObject();
  if (inkWell is! RenderBox) return null;
  if (overlay == null || overlay is! RenderBox) return null;
  return RelativeRect.fromRect(
    Rect.fromPoints(
      inkWell.localToGlobal(offset ?? Offset.zero, ancestor: overlay),
      inkWell.localToGlobal(inkWell.size.bottomRight(Offset.zero), ancestor: overlay),
    ),
    Offset.zero & overlay.size,
  );
}
