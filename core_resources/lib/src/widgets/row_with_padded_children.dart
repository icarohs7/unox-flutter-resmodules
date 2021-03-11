import 'package:flutter/material.dart';

/// A [Row] where a padding is applied to each
/// child
class RowWithPaddedChildren extends StatelessWidget {
  const RowWithPaddedChildren({
    Key? key,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.max,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.textDirection,
    this.verticalDirection = VerticalDirection.down,
    this.textBaseline,
    this.children = const <Widget>[],
    this.childrenPadding = EdgeInsets.zero,
  }) : super(key: key);

  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;
  final TextDirection? textDirection;
  final VerticalDirection verticalDirection;
  final TextBaseline? textBaseline;
  final List<Widget> children;
  final EdgeInsets childrenPadding;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      mainAxisSize: mainAxisSize,
      crossAxisAlignment: crossAxisAlignment,
      textDirection: textDirection,
      verticalDirection: verticalDirection,
      textBaseline: textBaseline,
      children: children.map<Widget>((w) {
        return w is Spacer
            ? w
            : w is Expanded
                ? Expanded(child: Padding(padding: childrenPadding, child: w.child))
                : Padding(padding: childrenPadding, child: w);
      }).toList(),
    );
  }
}
