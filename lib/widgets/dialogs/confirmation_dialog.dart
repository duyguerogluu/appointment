import 'package:goresy/constants/constants.dart';
import 'package:goresy/router/app_router.dart';
import 'package:flutter/material.dart';

class ConfirmationDialog extends AlertDialog {
  ConfirmationDialog({
    required BuildContext context,
    super.key,
    String? title,
    required String message,
    Function()? onSubmit,
    Function()? onCancel,
  }) : super(
          title: title != null ? Text(title) : null,
          content: Container(
            width: Dimens.maxDialogWidth,
            child: Text(message),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(S.of(context).dialogYes),
              onPressed: () {
                Navigator.of(context).pop<bool>(true);
                onSubmit?.call();
              },
            ),
            TextButton(
              child: Text(S.of(context).dialogCancel),
              onPressed: () {
                context.pop<bool>(false);
                onCancel?.call();
              },
            ),
          ],
        );

  static Future<bool> show({
    required BuildContext context,
    String? title,
    required String message,
    Function()? onSubmit,
    Function()? onCancel,
  }) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => ConfirmationDialog(
        context: context,
        title: title,
        message: message,
        onSubmit: onSubmit,
        onCancel: onCancel,
      ),
    ).then((value) => value ?? false);
  }
}
