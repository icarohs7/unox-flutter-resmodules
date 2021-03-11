import 'package:flutter/widgets.dart';

/// Animates the scale of a transformed widget in the X axis.
class HorizontalScaleTransition extends AnimatedWidget {
  const HorizontalScaleTransition({
    Key? key,
    required Animation<double> scale,
    this.alignment = Alignment.center,
    this.child,
  }) : super(key: key, listenable: scale);

  /// The animation that controls the scale of the child.
  ///
  /// If the current value of the scale animation is v, the child will be
  /// painted v times its normal size.
  // ignore: avoid_as
  Animation<double> get scale => listenable as Animation<double>;

  /// The alignment of the origin of the coordinate system in which the scale
  /// takes place, relative to the size of the box.
  ///
  /// For example, to set the origin of the scale to bottom middle, you can use
  /// an alignment of (0.0, 1.0).
  final Alignment alignment;

  /// The widget below this widget in the tree.
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final scaleValue = scale.value;
    final transform = Matrix4.identity()..scale(scaleValue, 1.0, 1.0);
    return Transform(
      transform: transform,
      alignment: alignment,
      child: child,
    );
  }
}

/// Animates the scale of a transformed widget in the Y axis.
class VerticalScaleTransition extends AnimatedWidget {
  const VerticalScaleTransition({
    Key? key,
    required Animation<double> scale,
    this.alignment = Alignment.center,
    this.child,
  }) : super(key: key, listenable: scale);

  /// The animation that controls the scale of the child.
  ///
  /// If the current value of the scale animation is v, the child will be
  /// painted v times its normal size.
  // ignore: avoid_as
  Animation<double> get scale => listenable as Animation<double>;

  /// The alignment of the origin of the coordinate system in which the scale
  /// takes place, relative to the size of the box.
  ///
  /// For example, to set the origin of the scale to bottom middle, you can use
  /// an alignment of (0.0, 1.0).
  final Alignment alignment;

  /// The widget below this widget in the tree.
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final scaleValue = scale.value;
    final transform = Matrix4.identity()..scale(1.0, scaleValue, 1.0);
    return Transform(
      transform: transform,
      alignment: alignment,
      child: child,
    );
  }
}
