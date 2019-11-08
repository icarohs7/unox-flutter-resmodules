import 'package:flutter/material.dart';

Future<T> showSimpleAlert<T>(
  BuildContext context, {
  Widget title,
  Widget content,
  Function() onConfirm,
}) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: title,
        content: content,
        actions: <Widget>[
          FlatButton(
            child: Text("Ok"),
            onPressed: () => onConfirm != null ? onConfirm() : Navigator.pop(context),
          ),
        ],
      );
    },
  );
}

Future<T> showConfirmDialog<T>(
  BuildContext context, {
  Widget title,
  Widget content,
  Function() onConfirm,
  Function() onCancel,
}) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: title,
        content: content,
        actions: <Widget>[
          FlatButton(
            child: Text("Cancelar"),
            textColor: Theme.of(context).primaryColor,
            onPressed: onCancel != null ? onCancel() : () => Navigator.of(context).pop(false),
          ),
          FlatButton(
            child: Text("Confirmar"),
            textColor: Theme.of(context).primaryColor,
            onPressed: onConfirm != null ? onConfirm() : () => Navigator.of(context).pop(true),
          )
        ],
      );
    },
  );
}
