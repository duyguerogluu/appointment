import 'package:goresy/widgets/dialogs/multi_selection_dialog.dart';
import 'package:goresy/widgets/form_fields/input_form_field.dart';
import 'package:flutter/material.dart';

class MultiSelectFormField<ItemType> extends InputFormField<List<ItemType>> {
  MultiSelectFormField({
    super.key,
    required super.labelText,
    Function(List<ItemType>)? onChanged,
    super.icon,
    super.readOnly,
    super.enabled,
    super.focusNode,
    super.hintText,
    bool searchable = false,
    bool showCloseButton = true,
    required super.value,
    required Iterable<ItemType> items,
    required String Function(ItemType?) itemLabelBuilder,
    super.suffixIcon = const Icon(
      Icons.arrow_drop_down_rounded,
      size: 42,
    ),
    super.validate,
  }) : super(
          onFocusChange: (hasFocus, state) {
            if (hasFocus) {
              FocusScope.of(state.context).requestFocus(FocusNode());

              MultiSelectionDialog.show(
                context: state.context,
                title: labelText,
                items: items,
                itemLabelBuilder: itemLabelBuilder,
                onSubmit: (List<ItemType> value) {
                  state.didChange(value);
                  if (onChanged != null) {
                    onChanged(value);
                  }
                },
                showCloseButton: showCloseButton,
                searchable: searchable,
              );
            }
          },
          builder: (InputFormFieldState<List<ItemType>> field) {
            return value == null
                ? null
                : Text(
                    value
                        .map((selectedItem) => itemLabelBuilder(selectedItem))
                        .join(", "),
                    style: TextStyle(fontSize: 16),
                  );
          },
        );
}
