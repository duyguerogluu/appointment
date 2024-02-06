import 'package:goresy/constants/l10n/l10n.dart';
import 'package:goresy/widgets/form_fields/input_form_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimeInputFormField extends InputFormField<TimeOfDay> {
  final Locale locale;
  final TimeOfDay initialTime;
  final Function(TimeOfDay?)? onChanged;

  TimeInputFormField({
    super.key,
    required super.labelText,
    super.hintText,
    super.readOnly,
    super.enabled,
    this.onChanged,
    super.icon,
    super.focusNode,
    required super.value,
    required this.locale,
    required this.initialTime,
    super.validate,
  }) : super(
          suffixIcon: value != null
              ? IconButton(
                  icon: Icon(Icons.clear_rounded),
                  onPressed: () {
                    onChanged?.call(null);
                  },
                )
              : Icon(Icons.access_time_rounded),
          onFocusChange: (hasFocus, state) async {
            if (hasFocus) {
              FocusScope.of(state.context).requestFocus(FocusNode());
              await _pickTime(
                state.context,
                initialTime,
                labelText,
                (TimeOfDay? value) {
                  state.didChange(value);
                  if (onChanged != null) {
                    onChanged(value);
                  }
                },
              );
            }
          },
          builder: (FormFieldState<TimeOfDay> field) {
            return Text(
              timeToString(value, field.context) ?? "",
              style: TextStyle(fontSize: 16),
            );
          },
        );

  static _pickTime(BuildContext context, TimeOfDay initialTime,
      String labelText, Function(TimeOfDay?)? onChanged) async {
    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
      helpText: labelText,
      confirmText: S.of(context).dialogConfirm,
      cancelText: S.of(context).dialogCancel,
    );

    if (selectedTime != null) {
      onChanged?.call(selectedTime);
    }
  }

  static TimeOfDay? stringToTime(
    String? text,
  ) {
    if (text != null && text.isNotEmpty) {
      final format = DateFormat.jm(); //"6:00 AM"
      return TimeOfDay.fromDateTime(format.parse(text));
    }

    return null;
  }

  static String? timeToString(TimeOfDay? time, BuildContext context) {
    return time?.format(context);
  }
}
