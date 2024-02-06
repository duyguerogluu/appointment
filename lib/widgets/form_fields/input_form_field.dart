import 'package:goresy/utils/validator.dart';
import 'package:flutter/material.dart';

class InputFormField<T> extends FormField<T> {
  final String labelText;
  final String? hintText;
  final IconData? icon;
  final Widget? suffixIcon;
  final bool readOnly;
  final T? value;
  final Function(bool, InputFormFieldState<T>)? onFocusChange;
  final Validator<T?> Function(Validator<T?>)? validate;
  final FloatingLabelBehavior floatingLabelBehavior;
  final EdgeInsetsGeometry? contentPadding;

  final FocusNode _focusNode;

  InputFormField({
    super.key,
    required this.labelText,
    this.hintText,
    this.icon,
    this.suffixIcon,
    FocusNode? focusNode,
    required this.value,
    this.readOnly = false,
    this.onFocusChange,
    this.validate,
    this.floatingLabelBehavior = FloatingLabelBehavior.auto,
    required Widget? Function(InputFormFieldState<T> state) builder,
    this.contentPadding,
    super.enabled,
    bool useFocusNode = true,
  })  : _focusNode = focusNode ?? FocusNode(),
        super(
          autovalidateMode: AutovalidateMode.always,
          validator: (val) => validate?.call(Validator(labelText)).build(val),
          initialValue: value,
          builder: (FormFieldState<T> field) {
            final InputFormFieldState<T> state =
                field as InputFormFieldState<T>;

            String? errorText =
                state._userReachedBefore ? state.errorText : null;

            if (!enabled || readOnly) {
              if (state.focusNode.hasFocus) {
                state.focusNode.unfocus();
              }
            }

            var child = enabled
                ? builder(state)
                : Opacity(
                    opacity: 0.5,
                    child: builder(state),
                  );

            if (readOnly) {
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
                child: child,
                decoration: InputDecoration(
                  contentPadding: contentPadding ??
                      Theme.of(state.context)
                          .inputDecorationTheme
                          .contentPadding,
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  labelText: labelText,
                  filled: false,
                  enabled: enabled,
                  border: readOnlyBorder,
                  errorBorder: readOnlyBorder,
                  enabledBorder: readOnlyBorder,
                  focusedBorder: readOnlyBorder,
                  disabledBorder: readOnlyBorder,
                  focusedErrorBorder: readOnlyBorder,
                  icon: icon != null ? Icon(icon) : null,
                ).applyDefaults(Theme.of(state.context).inputDecorationTheme),
              );
            }

            return Focus(
              focusNode: useFocusNode ? state.focusNode : null,
              onFocusChange: (hasFocus) {
                if (!hasFocus) {
                  if (!state._userReachedBefore) {
                    // ignore: invalid_use_of_protected_member
                    state.setState(() {
                      state._userReachedBefore = true;
                    });
                  }
                }
                onFocusChange?.call(hasFocus, state);
              },
              child: GestureDetector(
                onTap: enabled && !readOnly
                    ? () => state.focusNode.requestFocus()
                    : null,
                child: InputDecorator(
                  //baseStyle: widget.style,
                  //textAlign: widget.textAlign,
                  isHovering: false,
                  isFocused: state.focusNode.hasFocus,
                  isEmpty: value == null ||
                      (value is String && value.isEmpty) ||
                      (value is Iterable && value.isEmpty),
                  expands: false,
                  child: child,
                  decoration: InputDecoration(
                    enabled: enabled,
                    contentPadding: contentPadding ??
                        Theme.of(state.context)
                            .inputDecorationTheme
                            .contentPadding,
                    floatingLabelBehavior: floatingLabelBehavior,
                    labelText: labelText,
                    hintText: hintText,
                    icon: icon != null ? Icon(icon) : null,
                    suffixIcon: suffixIcon,
                    errorMaxLines: 2,
                    errorText: errorText,
                  ).applyDefaults(Theme.of(state.context).inputDecorationTheme),
                ),
              ),
            );
          },
        );

  @override
  InputFormFieldState<T> createState() {
    return InputFormFieldState<T>();
  }
}

class InputFormFieldState<T> extends FormFieldState<T> {
  bool _userReachedBefore = false;

  FocusNode get focusNode => (widget as InputFormField)._focusNode;

  @override
  bool validate() {
    _userReachedBefore = true;
    return super.validate();
  }
}
