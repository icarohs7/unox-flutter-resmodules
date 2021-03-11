import 'dart:async';

import 'package:flutter/material.dart';

Future<T?> showSimpleAlert<T>(
  BuildContext context, {
  Widget? title,
  Widget? content,
  String? confirmText,
  Function()? onConfirm,
}) {
  return showDialog(
    context: context,
    builder: (context) => SimpleAlert(
      title: title,
      content: content,
      confirmText: confirmText,
      onConfirm: onConfirm,
    ),
  );
}

class SimpleAlert extends StatelessWidget {
  final Widget? title;
  final Widget? content;
  final String? confirmText;
  final Function()? onConfirm;

  const SimpleAlert({
    Key? key,
    this.title,
    this.content,
    this.onConfirm,
    this.confirmText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: title,
      content: content,
      actions: <Widget>[
        TextButton(
          child: Text(confirmText ?? 'Ok'),
          onPressed: () => onConfirm?.call() ?? Navigator.pop(context),
        ),
      ],
    );
  }
}

Future<bool> showConfirmDialog(
  BuildContext context, {
  Widget? title,
  Widget? content,
  FutureOr<void> Function()? onConfirm,
  FutureOr<void> Function()? onCancel,
  String? cancelText,
  String? confirmText,
}) async {
  return (await showDialog<bool>(
        context: context,
        builder: (context) {
          return ConfirmDialog(
            title: title,
            content: content,
            onConfirm: onConfirm,
            onCancel: onCancel,
            cancelText: cancelText,
            confirmText: confirmText,
          );
        },
      )) ??
      false;
}

class ConfirmDialog extends StatelessWidget {
  final Widget? title;
  final Widget? content;
  final FutureOr<void> Function()? onConfirm;
  final FutureOr<void> Function()? onCancel;
  final String? cancelText;
  final String? confirmText;

  const ConfirmDialog({
    this.title,
    this.content,
    this.onConfirm,
    this.onCancel,
    this.cancelText,
    this.confirmText,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: title,
      content: content,
      actions: <Widget>[
        TextButton(
          child: Text(cancelText ?? 'Cancelar'),
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor),
          ),
          onPressed: onCancel ?? () => Navigator.of(context).pop(false),
        ),
        TextButton(
          child: Text(confirmText ?? 'Confirmar'),
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor),
          ),
          onPressed: onConfirm ?? () => Navigator.of(context).pop(true),
        )
      ],
    );
  }
}
