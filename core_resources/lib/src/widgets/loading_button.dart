import 'package:flutter/material.dart';

class LoadingRaisedButton extends StatelessWidget {
  const LoadingRaisedButton({
    @required this.onPressed,
    this.child,
    this.isLoading,
    this.isLoadingStream,
    this.color,
  }) : assert(!(isLoading != null && isLoadingStream != null));

  final Widget child;
  final void Function() onPressed;
  final bool isLoading;
  final Stream<bool> isLoadingStream;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return isLoadingStream != null
      ? StreamBuilder(
      stream: isLoadingStream,
      initialData: false,
      builder: (context, snapshot) {
        return _Button(
          isLoading: snapshot.data,
          onPressed: onPressed,
          child: child,
          color: color,
        );
      },
    )
      : _Button(
      isLoading: isLoading ?? false,
      onPressed: onPressed,
      child: child,
      color: color,
    );
  }
}

class _Button extends StatelessWidget {
  const _Button({
    Key key,
    @required this.isLoading,
    @required this.onPressed,
    @required this.child,
    this.color,
  }) : super(key: key);

  final bool isLoading;
  final void Function() onPressed;
  final Widget child;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: isLoading,
      child: RaisedButton(
        color: color,
        onPressed: onPressed,
        child: _ButtonContent(isLoading: isLoading, child: child),
      ),
    );
  }
}

class _ButtonContent extends StatelessWidget {
  const _ButtonContent({
    Key key,
    @required this.isLoading,
    @required this.child,
  }) : super(key: key);

  final bool isLoading;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      switchInCurve: Curves.easeOut,
      switchOutCurve: Curves.easeIn,
      duration: Duration(milliseconds: 300),
      child: isLoading
        ? Stack(alignment: Alignment.center, children: <Widget>[
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
              valueColor: AlwaysStoppedAnimation<Color>(
                Theme
                  .of(context)
                  .colorScheme
                  .onPrimary,
              ),
            ),
          ),
        ),
      ])
        : child,
    );
  }
}
