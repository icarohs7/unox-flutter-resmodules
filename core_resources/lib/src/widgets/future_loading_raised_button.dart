import 'package:core_resources/core_resources.dart';
import 'package:flutter/material.dart';

class FutureLoadingRaisedButton extends StatefulWidget {
  const FutureLoadingRaisedButton({
    required this.onPressed,
    this.child,
  });

  final Widget? child;
  final Future<void> Function() onPressed;

  @override
  _FutureLoadingRaisedButtonState createState() => _FutureLoadingRaisedButtonState();
}

class _FutureLoadingRaisedButtonState extends State<FutureLoadingRaisedButton> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return LoadingRaisedButton(
      child: widget.child,
      isLoading: _isLoading,
      onPressed: _isLoading
          ? null
          : () async {
              try {
                setState(() => _isLoading = true);
                await widget.onPressed();
              } finally {
                setState(() => _isLoading = false);
              }
            },
    );
  }
}
