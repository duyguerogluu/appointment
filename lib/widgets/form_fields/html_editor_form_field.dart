import 'package:goresy/widgets/html_content.dart';
import 'package:flutter/material.dart';
import 'package:quill_html_editor/quill_html_editor.dart';

import 'input_form_field.dart';

class HtmlEditorFormField extends InputFormField<String> {
  final Locale? locale;
  final Function(String?)? onChanged;

  HtmlEditorFormField({
    super.key,
    required super.labelText,
    super.readOnly,
    super.enabled,
    super.value,
    super.focusNode,
    super.icon,
    super.hintText,
    this.onChanged,
    this.locale,
    super.suffixIcon = const Icon(Icons.format_align_left_rounded),
    super.validate,
  }) : super(
          onFocusChange: (hasFocus, field) async {
            var state = field as _HtmlEditorFormFieldState;
            if (hasFocus) {
              FocusScope.of(state.context).requestFocus(FocusNode());

              await state.openEditor(
                context: state.context,
                title: labelText,
                hintText: hintText ?? "",
                value: value ?? "",
                readOnly: readOnly,
                locale: locale,
                onChanged: (String? value) {
                  field.didChange(value);
                  if (onChanged != null) {
                    onChanged(value);
                  }
                },
              );
            }
          },
          builder: (FormFieldState<String> field) {
            return HtmlContent(
              data: value ?? "",
              linkTextColor: Theme.of(field.context).primaryColor,
              textColor: Theme.of(field.context).textTheme.bodyMedium?.color ??
                  Theme.of(field.context).colorScheme.onBackground,
            );
          },
        );

  @override
  _HtmlEditorFormFieldState createState() => _HtmlEditorFormFieldState();
}

class _HtmlEditorFormFieldState extends InputFormFieldState<String> {
  late final QuillEditorController _controller;
  final editorPadding = const EdgeInsets.only(left: 10, top: 5);

  void initState() {
    super.initState();

    _controller = QuillEditorController();
  }

  openEditor({
    required BuildContext context,
    String title = "",
    String hintText = "",
    String value = "",
    bool readOnly = false,
    Locale? locale,
    Function(String?)? onChanged,
  }) async {
    _controller.setText(value);
    await showDialog(
      context: context,
      barrierColor: Colors.transparent,
      useSafeArea: true,
      builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: Text(title),
          ),
          backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
          body: Column(
            children: [
              ToolBar(
                toolBarColor: Theme.of(context).colorScheme.surfaceVariant,
                activeIconColor: Theme.of(context).primaryColor,
                iconColor: Theme.of(context).colorScheme.onSurfaceVariant,
                padding: const EdgeInsets.all(8),
                iconSize: 20,
                controller: _controller,
              ),
              Divider(
                height: 1,
              ),
              Expanded(
                child: LayoutBuilder(builder: (context, constraints) {
                  return QuillHtmlEditor(
                    text: value,
                    controller: _controller,
                    isEnabled: widget.enabled,
                    minHeight: constraints.minHeight,
                    textStyle: TextStyle(
                      color: Theme.of(context).textTheme.bodyMedium!.color,
                    ),
                    padding: editorPadding,
                    hintText: hintText,
                    hintTextAlign: TextAlign.start,
                    hintTextPadding: editorPadding,
                    hintTextStyle: TextStyle(
                      color: Theme.of(context).hintColor,
                    ),
                    backgroundColor: Theme.of(context).colorScheme.background,
                  );
                }),
              ),
            ],
          ),
        );
      },
    );

    var htmlText = await _controller.getText();
    onChanged?.call(htmlText.trim());
  }

  @override
  void dispose() {
    super.dispose();

    _controller.dispose();
  }
}
