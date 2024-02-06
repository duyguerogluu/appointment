import 'package:goresy/constants/dimens.dart';
import 'package:goresy/constants/l10n/l10n.dart';
import 'package:goresy/router/app_router.dart';
import 'package:flutter/material.dart';

class InformationDialog extends AlertDialog {
  InformationDialog({
    super.key,
    required BuildContext context,
    String? title,
    required String message,
    Function()? onClose,
  }) : super(
          title: title == null ? null : Text(title),
          content: Container(
            width: Dimens.maxDialogWidth,
            child: Text(message),
          ),
          actions: <Widget>[
            if (onClose != null)
              TextButton(
                onPressed: onClose,
                child: Text(S.of(context).dialogConfirm),
              ),
          ],
        );

  static Future<void> show({
    required BuildContext context,
    String? title,
    required String message,
    Function()? onClose,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => InformationDialog(
        context: context,
        title: title,
        message: message,
        onClose: () {
          context.pop();
          onClose?.call();
        },
      ),
    );
  }
}
