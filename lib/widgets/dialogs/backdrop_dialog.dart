import 'package:goresy/router/app_router.dart';
import 'package:goresy/widgets/dialogs/dialogs.dart';
import 'package:goresy/widgets/responsive.dart';
import 'package:flutter/material.dart';

import 'dart:math' as Math;

class BackdropDialog extends StatelessWidget {
  final Widget body;
  final String? title;
  final Function()? onTapClose;
  const BackdropDialog({
    super.key,
    required this.body,
    this.title,
    this.onTapClose,
  });

  static Future show({
    required BuildContext context,
    required Widget body,
    String? title,
    bool showCloseButton = true,
    Color barrierColor = Colors.transparent,
    Duration? animationDuration,
    double? heightFactor,
    double? height,
  }) {
    assert(height == null || heightFactor == null);

    if (height != null)
      heightFactor =
          Math.min(height / (MediaQuery.of(context).size.height), 1.0);

    var curveTween = CurveTween(curve: Curves.ease);

    var child = Responsive(
      child: BackdropDialog(
        body: body,
        title: title,
        onTapClose: showCloseButton
            ? () {
                context.pop();
              }
            : null,
      ),
    );

    return showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "BackdropDialogLabel",
      barrierColor: barrierColor,
      transitionBuilder: (context, a1, a2, widget) {
        return Transform.translate(
          offset: Offset(0, (1 - curveTween.transform(a1.value)) * 1000),
          child: widget,
        );
      },
      transitionDuration: animationDuration == null
          ? const Duration(milliseconds: 500)
          : animationDuration,
      pageBuilder: (context, anim1, anim2) => heightFactor == null
          ? child
          : FractionallySizedBox(
              heightFactor: heightFactor,
              alignment: Alignment.bottomCenter,
              child: child,
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var header = title == null && onTapClose == null
        ? null
        : DialogHeader(title: title ?? "", onTapClose: onTapClose);
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
      child: Material(
        color: Theme.of(context).dialogBackgroundColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        child: header == null
            ? body
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  header,
                  Expanded(
                    child: body,
                  ),
                ],
              ),
      ),
    );
  }
}
