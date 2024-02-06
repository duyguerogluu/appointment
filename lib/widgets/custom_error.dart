import 'package:goresy/constants/l10n/l10n.dart';
import 'package:goresy/data/network/exceptions/network_exceptions.dart';
import 'package:flutter/material.dart';

class CustomError extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String message;
  final Color? foregroundColor;
  final Color? backgroundColor;
  final Function()? onPressRetry;

  CustomError({
    super.key,
    required BuildContext context,
    this.icon = Icons.error_outline_rounded,
    required this.message,
    this.onPressRetry,
  })  : iconColor = Theme.of(context).colorScheme.error,
        backgroundColor = Theme.of(context).colorScheme.background,
        foregroundColor = null;

  static CustomError autoDetech({
    required BuildContext context,
    Function()? onPressRetry,
    required Object? error,
  }) {
    if (error != null) {
      if (error is UserFriendlyException) {
        if (error.statusCode == 401)
          return CustomError.unauthorized(
            context: context,
            message: error.message,
            onPressRetry: onPressRetry,
          );
        else if (error.statusCode == 404)
          return CustomError.noResultsFound(context: context);
        else
          return CustomError(
            context: context,
            message: error.message,
            onPressRetry: onPressRetry,
          );
      }
    }

    return CustomError.somethingWentWrong(
      context: context,
      onPressRetry: onPressRetry,
    );
  }

  CustomError.somethingWentWrong({
    super.key,
    required BuildContext context,
    this.onPressRetry,
  })  : icon = Icons.error_outline_rounded,
        iconColor = Theme.of(context).colorScheme.error,
        message = S.of(context).customErrorSomethingWentWrong,
        foregroundColor = Theme.of(context).colorScheme.onBackground,
        backgroundColor = Theme.of(context).colorScheme.background;

  CustomError.noResultsFound({
    super.key,
    String? message,
    required BuildContext context,
  })  : icon = Icons.web_asset_off_rounded,
        iconColor = Theme.of(context).hintColor,
        message = message ?? S.of(context).customErrorNoResultsFound,
        foregroundColor = Theme.of(context).colorScheme.onBackground,
        backgroundColor = Theme.of(context).colorScheme.background,
        this.onPressRetry = null;

  CustomError.unauthorized({
    super.key,
    required BuildContext context,
    this.onPressRetry,
    String? message,
  })  : icon = Icons.lock_person_outlined,
        iconColor = Colors.yellow,
        message = message ?? S.of(context).customErrorUnauthorizedAccess,
        foregroundColor = Theme.of(context).colorScheme.onBackground,
        backgroundColor = Theme.of(context).colorScheme.background;

  @override
  Widget build(BuildContext context) {
    var messageTextStyle =
        Theme.of(context).textTheme.titleMedium ?? TextStyle();
    if (foregroundColor != null) {
      messageTextStyle = messageTextStyle.copyWith(color: foregroundColor);
    }
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: backgroundColor,
      ),
      padding: const EdgeInsets.all(32.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 64,
            color: iconColor,
          ),
          SizedBox(
            height: 12,
          ),
          Text(
            message,
            style: messageTextStyle,
            textAlign: TextAlign.center,
          ),
          if (onPressRetry != null)
            SizedBox(
              height: 12,
            ),
          if (onPressRetry != null)
            TextButton.icon(
              icon: Icon(
                Icons.refresh_rounded,
                color: foregroundColor,
              ),
              label: Text(
                S.of(context).refresh,
                style: TextStyle(
                  color: foregroundColor,
                ),
              ),
              style: ButtonStyle(
                surfaceTintColor: MaterialStatePropertyAll(foregroundColor),
                overlayColor: MaterialStatePropertyAll(
                    foregroundColor?.withOpacity(0.05)),
              ),
              onPressed: onPressRetry,
            ),
        ],
      ),
    );
  }
}
