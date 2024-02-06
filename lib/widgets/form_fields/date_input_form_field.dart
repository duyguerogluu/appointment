import 'package:goresy/constants/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'input_form_field.dart';

class DateInputFormField extends InputFormField<DateTime> {
  final Function(DateTime?)? onChanged;

  final DateTime firstDate;
  final DateTime lastDate;
  final Locale locale;
  final String dateFormat;

  DateInputFormField({
    super.key,
    required super.labelText,
    this.onChanged,
    super.icon,
    super.focusNode,
    super.hintText,
    super.readOnly,
    super.enabled,
    super.value,
    required this.firstDate,
    required this.lastDate,
    required this.locale,
    this.dateFormat = "yMMMd",
    super.validate,
  }) : super(
          suffixIcon: value != null
              ? IconButton(
                  icon: Icon(Icons.clear_rounded),
                  onPressed: () {
                    onChanged?.call(null);
                  },
                )
              : Icon(Icons.calendar_month_rounded),
          onFocusChange: (hasFocus, state) async {
            if (hasFocus) {
              FocusScope.of(state.context).requestFocus(FocusNode());
              await _pickDate(
                context: state.context,
                labelText: labelText,
                hintText: hintText,
                value: value,
                firstDate: firstDate,
                lastDate: lastDate,
                locale: locale,
                onChanged: (DateTime? value) {
                  state.didChange(value);
                  if (onChanged != null) {
                    onChanged(value);
                  }
                },
              );
            }
          },
          builder: (InputFormFieldState<DateTime> field) {
            return Text(
              dateToString(value, dateFormat, locale) ?? "",
              style: TextStyle(fontSize: 16),
            );
          },
        );

  static String? dateToString(
      DateTime? date, String dateFormat, Locale locale) {
    return date == null
        ? null
        : DateFormat(
            dateFormat,
            locale.toString(),
          ).format(date);
  }

  static _pickDate({
    required BuildContext context,
    required String labelText,
    String? hintText,
    DateTime? value,
    required DateTime firstDate,
    required DateTime lastDate,
    required Locale locale,
    Function(DateTime?)? onChanged,
  }) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: value ?? DateTime.now(),
      firstDate: firstDate,
      lastDate: lastDate,
      locale: locale,
      fieldLabelText: labelText,
      fieldHintText: hintText,
      helpText: labelText,
      confirmText: S.of(context).dialogConfirm,
      cancelText: S.of(context).dialogCancel,
    );

    if (selectedDate != null) {
      onChanged?.call(selectedDate);
    }
  }
}
