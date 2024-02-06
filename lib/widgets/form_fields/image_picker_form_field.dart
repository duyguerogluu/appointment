import 'dart:io';

import 'package:goresy/widgets/form_fields/input_form_field.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerFormField extends InputFormField<File> {
  final String? savedImageUrl;
  final Function(File?)? onChanged;

  ImagePickerFormField({
    super.key,
    required super.labelText,
    super.hintText,
    super.readOnly,
    super.enabled,
    required this.onChanged,
    super.icon,
    super.focusNode,
    required super.value,
    this.savedImageUrl,
    super.validate,
  }) : super(
          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          onFocusChange: (hasFocus, state) async {
            if (hasFocus) {
              FocusScope.of(state.context).requestFocus(FocusNode());
              await _pickImage(
                (File? value) {
                  state.didChange(value);
                  if (onChanged != null) {
                    onChanged(value);
                  }
                },
              );
            }
          },
          builder: (InputFormFieldState<File> field) {
            return GestureDetector(
              child: Container(
                constraints: const BoxConstraints.expand(height: 300),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  clipBehavior: Clip.antiAlias,
                  child: value != null
                      ? Image.file(
                          value,
                          alignment: Alignment.center,
                          fit: BoxFit.cover,
                        )
                      : (savedImageUrl != null
                          ? Image.network(
                              savedImageUrl,
                              alignment: Alignment.center,
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                return loadingProgress == null
                                    ? child
                                    : Center(
                                        child: SizedBox(
                                          width: 36,
                                          height: 36,
                                          child: CircularProgressIndicator(),
                                        ),
                                      );
                              },
                              errorBuilder: (context, error, stackTrace) {
                                return Icon(
                                  Icons.image_not_supported_outlined,
                                  size: 72,
                                  color: Theme.of(field.context)
                                      .colorScheme
                                      .error
                                      .withOpacity(0.5),
                                );
                              },
                            )
                          : Icon(
                              Icons.image_search_rounded,
                              size: 72,
                              color: Theme.of(field.context)
                                  .primaryColor
                                  .withOpacity(0.3),
                            )),
                ),
              ),
            );
          },
        );

  static Future _pickImage(Function(File?) onChanged) async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    final fileObj = pickedFile == null ? null : File(pickedFile.path);

    onChanged(fileObj);
  }
}
