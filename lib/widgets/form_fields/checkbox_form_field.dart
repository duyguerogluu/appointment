import 'package:goresy/constants/l10n/l10n.dart';
import 'package:goresy/utils/validator.dart';
import 'package:flutter/material.dart';

class CheckboxFormField extends FormField<bool?> {
  final String? labelText;
  final Widget? label;
  final bool? value;

  final FocusNode? focusNode;
  final bool readOnly;

  final Function(bool?)? onChanged;
  final Validator<bool?> Function(Validator<bool?>)? validate;

  final Widget? suffixIcon;

  CheckboxFormField({
    super.key,
    this.labelText,
    this.label,
    this.value,
    this.readOnly = false,
    this.focusNode,
    super.enabled,
    this.onChanged,
    this.validate,
    this.suffixIcon,
  })  : assert(label != null || labelText != null,
            "label or labelText must be passed"),
        super(
          autovalidateMode: AutovalidateMode.always,
          validator: (val) => validate
              ?.call(Validator<bool?>(labelText ?? S.current.thisField))
              .build(val),
          initialValue: value,
          builder: (FormFieldState<bool?> field) {
            final _CheckboxFormFieldState state =
                field as _CheckboxFormFieldState;

            Widget labelWidget = label ??
                Text(
                  labelText!,
                  style: Theme.of(state.context).textTheme.bodyMedium,
                );

            labelWidget = enabled
                ? labelWidget
                : Opacity(
                    opacity: 0.5,
                    child: labelWidget,
                  );

            String? errorText =
                state._userReachedBefore ? state.errorText : null;

            final onChangeHandler = enabled
                ? (bool? value) {
                    field.didChange(value);
                    if (onChanged != null) {
                      onChanged(value);
                    }
                  }
                : null;

            final checkBoxWidget = readOnly
                ? Padding(
                    padding: const EdgeInsets.all(9),
                    child: Icon(
                      value == true ? Icons.check_rounded : Icons.clear_rounded,
                      color: Theme.of(state.context)
                          .textTheme
                          .bodyMedium!
                          .color!
                          .withOpacity(0.5),
                      size: 22,
                    ),
                  )
                : Checkbox(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    onChanged: onChangeHandler,
                    value: value,
                    focusNode: focusNode,
                  );

            return Focus(
              onFocusChange: (hasFocus) {
                if (!state._userReachedBefore && hasFocus == false) {
                  // ignore: invalid_use_of_protected_member
                  state.setState(() {
                    state._userReachedBefore = true;
                  });
                }
              },
              child: InputDecorator(
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  isDense: true,
                  isCollapsed: true,
                  errorText: errorText,
                  enabled: enabled,
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  focusedErrorBorder: InputBorder.none,
                  fillColor: Colors.transparent,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                  suffixIcon: suffixIcon,
                ),
                child: Transform.translate(
                  offset: const Offset(-12, 0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      checkBoxWidget,
                      Expanded(
                        child: labelWidget,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );

  @override
  FormFieldState<bool?> createState() => _CheckboxFormFieldState();
}

class _CheckboxFormFieldState extends FormFieldState<bool?> {
  bool _userReachedBefore = false;

  @override
  bool validate() {
    _userReachedBefore = true;
    return super.validate();
  }
}
