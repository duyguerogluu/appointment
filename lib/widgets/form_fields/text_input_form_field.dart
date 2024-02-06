import 'package:goresy/utils/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextInputFormField extends FormField<String> {
  final String labelText;
  final String? hintText;
  final IconData? icon;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? counterText;

  final FocusNode? focusNode;
  final bool readOnly;
  final bool useFloatingLabel;

  final bool obscureText;
  final bool userCanSeeObscureText;
  final Function(String)? onFieldSubmitted;
  final Function(String)? onChanged;
  final bool autofocus;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final Validator<String?> Function(Validator<String?>)? validate;

  TextInputFormField({
    super.key,
    required this.labelText,
    this.icon,
    this.suffixIcon = const Icon(Icons.keyboard_rounded),
    this.prefixIcon,
    this.hintText,
    this.counterText,
    this.focusNode,
    this.readOnly = false,
    this.useFloatingLabel = true,
    super.enabled,
    this.keyboardType,
    this.obscureText = false,
    this.userCanSeeObscureText = false,
    this.onFieldSubmitted,
    this.onChanged,
    this.autofocus = false,
    this.textInputAction,
    this.inputFormatters,
    this.validate,
    int? minLines,
    int? maxLines = 1,
    super.initialValue,
  }) : super(
          autovalidateMode: AutovalidateMode.always,
          validator: (val) => validate?.call(Validator(labelText)).build(val),
          builder: (FormFieldState<String> field) {
            final state = field as TextInputFormFieldState;

            final theme = Theme.of(state.context);
            final textStyle = theme.textTheme.titleMedium!.copyWith(
                color: theme.textTheme.titleMedium!.color!
                    .withOpacity(enabled ? 1 : 0.5));

            /*if (readOnly) {
              var readOnlyBorder = Theme.of(state.context)
                  .inputDecorationTheme
                  .enabledBorder!
                  .copyWith(borderSide: BorderSide(color: Colors.transparent));

              return InputDecorator(
                textAlignVertical: TextAlignVertical.center,
                isHovering: false,
                isFocused: false,
                isEmpty: false,
                expands: false,
                child: Text(
                  state._controller.text,
                  style: textStyle,
                ),
                decoration: InputDecoration(
                  contentPadding: Theme.of(state.context)
                      .inputDecorationTheme
                      .contentPadding,
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  enabled: enabled,
                  labelText: labelText,
                  border: readOnlyBorder,
                  errorBorder: readOnlyBorder,
                  enabledBorder: readOnlyBorder,
                  focusedBorder: readOnlyBorder,
                  disabledBorder: readOnlyBorder,
                  focusedErrorBorder: readOnlyBorder,
                  icon: icon != null ? Icon(icon) : null,
                ).applyDefaults(theme.inputDecorationTheme),
              );
            }*/

            void onChangedHandler(String value) {
              field.didChange(value);
              if (onChanged != null) {
                onChanged(value);
              }
            }

            InputDecoration decoration = InputDecoration(
              labelText: labelText,
              enabled: enabled,
              icon: icon != null ? Icon(icon) : null,
            );

            if (readOnly) {
              var readOnlyBorder = Theme.of(state.context)
                  .inputDecorationTheme
                  .enabledBorder!
                  .copyWith(borderSide: BorderSide(color: Colors.transparent));

              decoration = decoration.copyWith(
                labelStyle: Theme.of(state.context)
                    .inputDecorationTheme
                    .floatingLabelStyle!
                    .copyWith(
                        color: Theme.of(state.context).colorScheme.primary),
                contentPadding:
                    Theme.of(state.context).inputDecorationTheme.contentPadding,
                floatingLabelBehavior: FloatingLabelBehavior.always,
                filled: false,
                border: readOnlyBorder,
                errorBorder: readOnlyBorder,
                enabledBorder: readOnlyBorder,
                focusedBorder: readOnlyBorder,
                disabledBorder: readOnlyBorder,
                focusedErrorBorder: readOnlyBorder,
              );
            } else {
              String? errorText =
                  state._userReachedBefore ? state.errorText : null;

              var suffIcon = suffixIcon;

              if (obscureText && userCanSeeObscureText) {
                if (state._controller.text.isNotEmpty) {
                  if (!state._showObscureContent) {
                    suffIcon = IconButton(
                      icon: const Icon(Icons.remove_red_eye_rounded),
                      // ignore: invalid_use_of_protected_member
                      onPressed: () => state.setState(() {
                        state._showObscureContent = true;
                      }),
                    );
                  } else {
                    suffIcon = IconButton(
                      icon: const Icon(Icons.remove_red_eye_outlined),
                      // ignore: invalid_use_of_protected_member
                      onPressed: () => state.setState(() {
                        state._showObscureContent = false;
                      }),
                    );
                  }
                }
              }

              decoration = decoration.copyWith(
                hintText: hintText,
                floatingLabelBehavior: useFloatingLabel
                    ? FloatingLabelBehavior.auto
                    : FloatingLabelBehavior.never,
                counterText: counterText,
                counter: counterText == null ? null : Text(counterText),
                errorText: errorText,
                errorMaxLines: 2,
                prefixIcon: prefixIcon,
                suffixIcon: suffIcon,
              );
            }

            Widget textField = TextField(
              controller: state._controller,
              focusNode: focusNode,
              enabled: enabled,
              keyboardType: keyboardType,
              obscureText: state._showObscureContent ? false : obscureText,
              onSubmitted: onFieldSubmitted,
              onChanged: onChangedHandler,
              autofocus: autofocus,
              textInputAction: textInputAction,
              inputFormatters: inputFormatters,
              style: textStyle,
              minLines: minLines,
              maxLines: maxLines,
              readOnly: readOnly,
              decoration: decoration,
            );

            return Focus(
              onFocusChange: !enabled
                  ? null
                  : (hasFocus) {
                      if (!state._userReachedBefore && hasFocus == false) {
                        // ignore: invalid_use_of_protected_member
                        state.setState(() {
                          state._userReachedBefore = true;
                        });
                      }
                    },
              child: textField,
            );
          },
        );

  @override
  FormFieldState<String> createState() => TextInputFormFieldState();
}

class TextInputFormFieldState extends FormFieldState<String> {
  bool _userReachedBefore = false;
  bool _showObscureContent = false;

  late TextEditingController _controller;

  @override
  bool validate() {
    _userReachedBefore = true;
    return super.validate();
  }

  @override
  void initState() {
    super.initState();

    _controller = TextEditingController(text: widget.initialValue);
  }
}
