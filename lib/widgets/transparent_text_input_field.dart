import 'package:flutter/material.dart';

class TransparentTextInputField extends StatelessWidget {
  final IconData? icon;
  final String? initialValue;
  final String? hint;
  final bool isObscure;
  final bool enabled;
  final TextInputType? inputType;
  final TextEditingController? textController;
  final FocusNode? focusNode;
  final Function(String)? onFieldSubmitted;
  final Function(String)? onChanged;
  final bool autoFocus;
  final TextInputAction? inputAction;
  final String? Function(String?)? validator;

  const TransparentTextInputField({
    super.key,
    required this.icon,
    this.initialValue,
    this.textController,
    this.enabled = true,
    this.inputType,
    this.hint,
    this.isObscure = false,
    this.focusNode,
    this.onFieldSubmitted,
    this.onChanged,
    this.autoFocus = false,
    this.inputAction,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final defaultBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(
        width: 1,
        color: Color.fromARGB(64, 255, 255, 255),
      ),
    );
    final errorBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(
        width: 2,
        color: Color.fromARGB(128, 250, 70, 70),
      ),
    );

    return TextFormField(
      initialValue: initialValue,
      controller: textController,
      focusNode: focusNode,
      onFieldSubmitted: onFieldSubmitted,
      onChanged: onChanged,
      autofocus: autoFocus,
      textInputAction: inputAction,
      obscureText: isObscure,
      maxLength: 25,
      enabled: enabled,
      keyboardType: inputType,
      validator: validator,
      style: Theme.of(context)
          .textTheme
          .bodyMedium!
          .copyWith(color: Colors.grey.shade200),
      cursorColor: Colors.grey.shade200,
      decoration: InputDecoration(
        enabledBorder: defaultBorder,
        errorBorder: errorBorder,
        focusedBorder: defaultBorder,
        focusedErrorBorder: defaultBorder,
        filled: true,
        fillColor: Color.fromARGB(64, 0, 0, 0),
        hintText: this.hint,
        hintStyle: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(color: Colors.grey.shade300),
        errorStyle: TextStyle(
          color: Colors.red,
        ),
        counterText: '',
        prefixIcon: this.icon != null
            ? Icon(
                this.icon,
                color: Colors.grey.shade200,
                size: 20,
              )
            : null,
      ),
    );
  }
}
