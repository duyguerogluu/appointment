import 'package:goresy/widgets/dialogs/selection_dialog.dart';
import 'package:goresy/widgets/form_fields/input_form_field.dart';
import 'package:flutter/material.dart';

class SelectFormField<ItemType> extends InputFormField<ItemType> {
  SelectFormField({
    super.key,
    required super.labelText,
    Function(ItemType?)? onChanged,
    super.icon,
    super.readOnly,
    super.enabled,
    super.focusNode,
    super.hintText,
    bool searchable = false,
    required super.value,
    required Iterable<ItemType> items,
    required String Function(ItemType?) itemLabelBuilder,
    super.suffixIcon = const Icon(
      Icons.arrow_drop_down_rounded,
      size: 42,
    ),
    super.validate,
  }) : super(
          onFocusChange: (hasFocus, state) async {
            if (hasFocus) {
              FocusScope.of(state.context).requestFocus(FocusNode());

              ItemType? result = await SelectionDialog.show<ItemType>(
                context: state.context,
                title: labelText,
                items: items,
                itemLabelBuilder: itemLabelBuilder,
                searchable: searchable,
              );

              state.didChange(result);
              if (onChanged != null) {
                onChanged(result);
              }
            }
          },
          builder: (FormFieldState<ItemType> field) {
            return Text(
              itemLabelBuilder(value),
              style: TextStyle(fontSize: 16),
            );
          },
        );
}
