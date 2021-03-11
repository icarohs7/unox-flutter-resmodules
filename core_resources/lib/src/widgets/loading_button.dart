import 'package:core_resources/src/extensions/object_extensions.dart';
import 'package:flutter/material.dart';

class LoadingRaisedButton extends StatelessWidget {
  const LoadingRaisedButton({
    required this.onPressed,
    this.child,
    this.isLoading = false,
    this.color,
    this.textColor,
    this.progressIndicatorColor,
    this.shape,
    this.padding,
  });

  final Widget? child;
  final void Function()? onPressed;
  final bool isLoading;
  final Color? color;
  final Color? textColor;
  final Color? progressIndicatorColor;
  final OutlinedBorder? shape;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: isLoading,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: color?.materialProperty,
          foregroundColor: textColor?.materialProperty,
          shape: shape?.materialProperty,
          padding: padding?.materialProperty,
        ),
        child: _ButtonContent(
          isLoading: isLoading,
          child: child,
          progressIndicatorColor:
              progressIndicatorColor ?? textColor ?? Theme.of(context).colorScheme.onPrimary,
        ),
      ),
    );
  }
}

class LoadingFlatButton extends StatelessWidget {
  const LoadingFlatButton({
    required this.onPressed,
    this.child,
    this.isLoading = false,
    this.color,
    this.textColor,
    this.progressIndicatorColor,
    this.shape,
    this.padding,
  });

  final Widget? child;
  final void Function() onPressed;
  final bool isLoading;
  final Color? color;
  final Color? textColor;
  final Color? progressIndicatorColor;
  final OutlinedBorder? shape;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: isLoading,
      child: TextButton(
        onPressed: onPressed,
        style:ButtonStyle(
          foregroundColor: color?.materialProperty,
          backgroundColor: textColor?.materialProperty,
          shape: shape?.materialProperty,
          padding: padding?.materialProperty,
        ),
        child: _ButtonContent(
          isLoading: isLoading,
          child: child,
          progressIndicatorColor:
              progressIndicatorColor ?? textColor ?? Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}

class LoadingFloatingActionButton extends StatelessWidget {
  const LoadingFloatingActionButton({
    required this.onPressed,
    this.child,
    this.isLoading = false,
    this.backgroundColor,
    this.progressIndicatorColor,
    this.shape,
    this.padding,
  });

  final Widget? child;
  final void Function()? onPressed;
  final bool isLoading;
  final Color? backgroundColor;
  final Color? progressIndicatorColor;
  final ShapeBorder? shape;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: isLoading,
      child: FloatingActionButton(
        backgroundColor: backgroundColor,
        onPressed: onPressed,
        shape: shape,
        child: _ButtonContent(
          isLoading: isLoading,
          child: child,
          progressIndicatorColor: progressIndicatorColor ?? Theme.of(context).colorScheme.onPrimary,
        ),
      ),
    );
  }
}

class _ButtonContent extends StatelessWidget {
  const _ButtonContent({
    Key? key,
    required this.isLoading,
    required this.child,
    required this.progressIndicatorColor,
  }) : super(key: key);

  final bool isLoading;
  final Widget? child;
  final Color progressIndicatorColor;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      switchInCurve: Curves.easeOut,
      switchOutCurve: Curves.easeIn,
      duration: Duration(milliseconds: 300),
      child: isLoading
          ? Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Opacity(
                  opacity: 0,
                  child: child,
                ),
                Padding(
                  padding: const EdgeInsets.all(6),
                  child: Container(
                    height: 16,
                    width: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(progressIndicatorColor),
                    ),
                  ),
                ),
              ],
            )
          : child,
    );
  }
}
