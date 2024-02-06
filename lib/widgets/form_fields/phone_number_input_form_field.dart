import 'package:goresy/widgets/form_fields/text_input_form_field.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class PhoneNumberInputFormField extends TextInputFormField {
  final Function(String)? onChanged;

  static final _inputFormatter = MaskTextInputFormatter(
    mask: '+90 (###) ### ## ##',
    filter: {"#": RegExp(r'[0-9]')},
  );

  PhoneNumberInputFormField({
    super.key,
    required super.labelText,
    super.icon,
    super.suffixIcon = const Icon(Icons.add_ic_call_rounded),
    super.hintText,
    super.focusNode,
    super.readOnly = false,
    super.enabled,
    super.onFieldSubmitted,
    this.onChanged,
    super.autofocus = false,
    super.textInputAction,
    super.validate,
    String? initialValue,
  }) : super(
          inputFormatters: [
            _inputFormatter,
          ],
          keyboardType: TextInputType.phone,
          initialValue: initialValue == null
              ? null
              : _inputFormatter.maskText(initialValue),
          onChanged: (val) {
            onChanged?.call(_inputFormatter.unmaskText(val));
          },
        );

  @override
  FormFieldState<String> createState() => TextInputFormFieldState();
}
