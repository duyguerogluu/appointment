import 'package:flutter/material.dart';

class ProgressIndicatorButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final ValueChanged<bool>? onHover;
  final ValueChanged<bool>? onFocusChange;
  final ButtonStyle? style;
  final FocusNode? focusNode;
  final bool? autofocus;
  final Clip? clipBehavior;
  final MaterialStatesController? statesController;
  final IconData? icon;
  final String labelText;
  final bool loading;

  final MaterialStatesController _statesController;

  ProgressIndicatorButton({
    super.key,
    this.onPressed,
    this.onLongPress,
    this.onHover,
    this.onFocusChange,
    this.style,
    this.focusNode,
    this.autofocus,
    this.clipBehavior,
    this.statesController,
    this.icon,
    required this.labelText,
    required this.loading,
  }) : _statesController = statesController ?? MaterialStatesController();

  @override
  Widget build(BuildContext context) {
    final button = icon != null
        ? FilledButton.icon(
            onPressed: loading ? null : onPressed,
            onLongPress: loading ? null : onLongPress,
            onHover: onHover,
            onFocusChange: onFocusChange,
            style: style,
            focusNode: focusNode,
            autofocus: autofocus,
            clipBehavior: clipBehavior,
            statesController: _statesController,
            icon: Icon(
              icon,
              color: loading ? Colors.transparent : null,
            ),
            label: Text(
              labelText,
              style: TextStyle(color: loading ? Colors.transparent : null),
            ),
          )
        : FilledButton(
            onPressed: loading ? null : onPressed,
            onLongPress: loading ? null : onLongPress,
            onHover: onHover,
            onFocusChange: onFocusChange,
            style: style,
            focusNode: focusNode,
            autofocus: autofocus ?? false,
            clipBehavior: clipBehavior ?? Clip.none,
            statesController: _statesController,
            child: Text(labelText),
          );
    return Stack(
      alignment: Alignment.center,
      children: [
        button,
        if (loading)
          SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2.5,
              color: button
                  .defaultStyleOf(context)
                  .foregroundColor!
                  .resolve({MaterialState.disabled}),
            ),
          )
      ],
    );
  }
}
