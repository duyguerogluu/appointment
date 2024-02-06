import 'package:goresy/constants/constants.dart';
import 'package:goresy/data/network/exceptions/network_exceptions.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

class ActionBox extends StatelessWidget {
  final String? message;
  final IconData icon;
  final Color backgroundColor;
  final Color foregroundColor;
  final EdgeInsetsGeometry margin;

  ActionBox.success({
    super.key,
    required BuildContext context,
    required this.message,
    this.margin = const EdgeInsets.all(16),
  })  : icon = Icons.check_circle_outline_rounded,
        backgroundColor = Colors.green.shade100,
        foregroundColor = Colors.green.shade600;

  ActionBox.errorMessage({
    super.key,
    required BuildContext context,
    required this.message,
    this.margin = const EdgeInsets.all(16),
  })  : icon = Icons.error_outline_rounded,
        backgroundColor = Theme.of(context).colorScheme.errorContainer,
        foregroundColor = Theme.of(context).colorScheme.onErrorContainer;

  ActionBox.error({
    super.key,
    required BuildContext context,
    Object? error,
    this.margin = const EdgeInsets.all(16),
  })  : message = error == null
            ? S.of(context).customErrorSomethingWentWrong
            : (error is UserFriendlyException
                ? error.message
                : error.toString()),
        icon = Icons.error_outline_rounded,
        backgroundColor = Theme.of(context).colorScheme.errorContainer,
        foregroundColor = Theme.of(context).colorScheme.onErrorContainer;

  static ActionBox errorAutoDetect({
    required BuildContext context,
    required Object? error,
    EdgeInsetsGeometry margin = const EdgeInsets.all(16),
  }) {
    if (error == null) {
      return ActionBox.errorMessage(
        context: context,
        message: S.of(context).customErrorSomethingWentWrong,
        margin: margin,
      );
    } else if (error is UserFriendlyException) {
      if (error.statusCode == 401)
        return ActionBox.errorMessage(
          context: context,
          message: S.of(context).customErrorUnauthorizedAccess,
          margin: margin,
        );
      else if ((error.statusCode ?? 1000) < 500)
        return ActionBox.errorMessage(
          context: context,
          message: error.message,
          margin: margin,
        );
    }

    return ActionBox.errorMessage(
      context: context,
      message: error.toString(),
      margin: margin,
    );
  }

  ActionBox.warning({
    super.key,
    required BuildContext context,
    required this.message,
    this.margin = const EdgeInsets.all(16),
  })  : icon = Icons.error_outline_rounded,
        backgroundColor = Colors.yellow.shade300,
        foregroundColor = Colors.yellow.shade900;

  ActionBox.info({
    super.key,
    required BuildContext context,
    required this.message,
    this.margin = const EdgeInsets.all(16),
  })  : icon = Icons.info_outline_rounded,
        backgroundColor = Theme.of(context).colorScheme.surfaceVariant,
        foregroundColor = Theme.of(context).colorScheme.primary;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: this.margin,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: backgroundColor.blend(foregroundColor, 20),
          width: 0.5,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: foregroundColor,
            size: 30,
          ),
          if (message != null)
            SizedBox(
              width: 12,
            ),
          if (message != null)
            Expanded(
              child: Text(
                message!,
                style: TextStyle(
                  color: foregroundColor,
                  fontSize: 13,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
