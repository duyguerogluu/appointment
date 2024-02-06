import 'package:goresy/constants/constants.dart';
import 'package:goresy/utils/validator.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'input_form_field.dart';

enum LetterCase { normal, small, capital }

class MultipleTextInputFormField extends InputFormField<List<String>> {
  final String? hintText;
  final Function(List<String>)? onChanged;
  final Validator<String> Function(Validator<String>)? validateItem;
  final List<String> textSeparators;
  final LetterCase letterCase;
  final double minContentHeight;
  final TextInputFormatter? inputFormatter;
  final bool uniqueItems;
  final void Function()? onSubmitted;

  factory MultipleTextInputFormField.autoSeparate({
    Key? key,
    required String valueSeparator,
    required String labelText,
    Function(String?)? onChanged,
    IconData? icon,
    String? hintText,
    FocusNode? focusNode,
    bool readOnly = false,
    bool enabled = true,
    String? value,
    Widget? suffixIcon = const Icon(Icons.storage_rounded),
    List<String> textSeparators = const [' ', ','],
    LetterCase letterCase = LetterCase.normal,
    Validator<String?> Function(Validator<String?>)? validate,
    Validator<String> Function(Validator<String>)? validateItem,
    double minContentHeight = 0,
    TextInputFormatter? inputFormatter,
    void Function()? onSubmitted,
    bool uniqueItems = true,
  }) {
    return MultipleTextInputFormField(
      key: key,
      labelText: labelText,
      onChanged: onChanged == null
          ? null
          : (val) {
              onChanged(_autoJoin(val, valueSeparator));
            },
      icon: icon,
      hintText: hintText,
      focusNode: focusNode,
      readOnly: readOnly,
      enabled: enabled,
      value: _autoSplit(value, valueSeparator),
      suffixIcon: suffixIcon,
      textSeparators: textSeparators.contains(valueSeparator)
          ? textSeparators
          : [valueSeparator, ...textSeparators],
      letterCase: letterCase,
      validate: (validator) =>
          validate
              ?.call(validator.convertType<String>(
                  (str) => _autoSplit(str, valueSeparator)))
              .convertType<List<String>>(
                  (list) => _autoJoin(list, valueSeparator)) ??
          validator,
      validateItem: validateItem,
      minContentHeight: minContentHeight,
      inputFormatter: inputFormatter,
      onSubmitted: onSubmitted,
      uniqueItems: uniqueItems,
    );
  }

  MultipleTextInputFormField({
    super.key,
    required super.labelText,
    this.onChanged,
    super.icon,
    this.hintText,
    super.focusNode,
    super.readOnly,
    super.enabled,
    List<String>? value,
    super.suffixIcon = const Icon(Icons.storage_rounded),
    this.textSeparators = const [' ', ','],
    this.letterCase = LetterCase.normal,
    super.validate,
    this.validateItem,
    this.minContentHeight = 0,
    this.inputFormatter,
    this.onSubmitted,
    this.uniqueItems = true,
  }) : super(
          useFocusNode: false,
          value: value ?? [],
          contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          onFocusChange: (hasFocus, field) {
            final state = (field as MultipleTextInputFormFieldState);
            state.focusChangeHandler(hasFocus);
          },
          builder: (InputFormFieldState<List<String>> field) {
            final state = (field as MultipleTextInputFormFieldState);
            return state.buildInner();
          },
        );

  static List<String> _autoSplit(String? strValue, String seperator) {
    return strValue?.isNotEmpty == true ? strValue!.split(seperator) : [];
  }

  static String? _autoJoin(List<String>? listValue, String seperator) {
    return listValue?.isNotEmpty == true ? listValue!.join(seperator) : null;
  }

  @override
  MultipleTextInputFormFieldState createState() {
    return MultipleTextInputFormFieldState();
  }
}

class MultipleTextInputFormFieldState
    extends InputFormFieldState<List<String>> {
  late final TextEditingController _textEditingController =
      TextEditingController();

  @override
  MultipleTextInputFormField get widget =>
      super.widget as MultipleTextInputFormField;

  final Key _inputKey = new GlobalKey(debugLabel: 'inputText');
  bool _hintActive = false;

  bool _updateHintVisibility() {
    if (_hintActive !=
        (widget.hintText?.isNotEmpty == true &&
            value?.isEmpty == true &&
            _textEditingController.text.isEmpty &&
            focusNode.hasFocus)) {
      setState(() {
        _hintActive = !_hintActive;
      });
      return true;
    }
    return false;
  }

  void focusChangeHandler(bool hasFocus) {
    String editingText = _textEditingController.text;
    if (!hasFocus) {
      if (editingText.isNotEmpty) {
        _textEditingController.clear();
      }
      _addItemIfValid(editingText);
    }

    if (!_updateHintVisibility()) {
      setState(() {});
    }
  }

  void valueChangeHandler(List<String> value) {
    didChange(value);
    if (widget.onChanged != null) {
      widget.onChanged?.call(value);
      _updateHintVisibility();
    }
  }

  void _onEditingTextChanged(String editingText) {
    final separator = widget.textSeparators.cast<String?>().firstWhere(
        (element) =>
            editingText.contains(element!) && editingText.indexOf(element) != 0,
        orElse: () => null);
    if (separator != null) {
      final splits = editingText.split(separator);
      final indexer = splits.length > 1 ? splits.length - 2 : splits.length - 1;

      String item = splits.elementAt(indexer).trim();
      if (widget.letterCase == LetterCase.small) {
        item = item.toLowerCase();
      } else if (widget.letterCase == LetterCase.capital) {
        item = item.toUpperCase();
      }

      if (_addItemIfValid(item)) {
        _textEditingController.clear();
      }
    }
    _updateHintVisibility();
  }

  String? _validateItem(String item) {
    if (widget.uniqueItems && value?.contains(item) == true) {
      return S.of(context).youHaveAlreadyAddedThis;
    }

    String? errorMessage = widget.validateItem?.call(Validator("")).build(item);

    if (errorMessage != null) {
      final theme = Theme.of(context);
      final snackBarTheme = theme.snackBarTheme;
      Color backgroundColor =
          snackBarTheme.backgroundColor ?? theme.secondaryHeaderColor;

      Fluttertoast.showToast(
        msg: errorMessage,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 4,
        backgroundColor: backgroundColor,
        textColor: backgroundColor.onColor,
        fontSize: 16.0,
      );
    }
    return errorMessage;
  }

  bool _addItemIfValid(String tag) {
    if (tag.isNotEmpty) {
      if (_validateItem(tag) == null) {
        valueChangeHandler.call(value!..add(tag));
        return true;
      }
    }
    return false;
  }

  void _deleteItem(int index) {
    valueChangeHandler.call(value!..removeAt(index));
  }

  Widget buildInner() {
    final ThemeData theme = Theme.of(context);

    final itemBackgroundColor = theme.secondaryHeaderColor;
    final itemForegroundColor = itemBackgroundColor.onColor.isDark
        ? itemBackgroundColor.onColor.lighten(20)
        : itemBackgroundColor.onColor.darken(20);

    final editableTextStyle = theme.textTheme.titleMedium!;
    final itemTextStyle = editableTextStyle.copyWith(
      fontSize: 14,
    );

    return LayoutBuilder(builder: (context, constraints) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            constraints: BoxConstraints(minHeight: widget.minContentHeight),
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              runSpacing: 4,
              spacing: 4,
              children: [
                for (var i = 0; i < value!.length; i++)
                  buildItem(i, constraints.maxWidth, itemTextStyle,
                      itemForegroundColor, itemBackgroundColor),
              ],
            ),
          ),
          Stack(
            children: [
              Container(
                width: focusNode.hasFocus ? constraints.maxWidth : 0,
                alignment: Alignment.bottomLeft,
                padding: EdgeInsets.symmetric(vertical: 4),
                child: EditableText(
                  key: _inputKey,
                  controller: _textEditingController,
                  focusNode: focusNode,
                  inputFormatters: [
                    if (widget.inputFormatter != null) widget.inputFormatter!
                  ],
                  onSubmitted: (text) {
                    if (text.isNotEmpty) {
                      _textEditingController.clear();
                      _addItemIfValid(text);
                      focusNode.requestFocus();
                    } else {
                      widget.onSubmitted?.call();
                    }
                  },
                  onChanged: _onEditingTextChanged,
                  cursorColor:
                      Theme.of(context).textSelectionTheme.cursorColor ??
                          itemForegroundColor,
                  backgroundCursorColor: itemBackgroundColor,
                  style: editableTextStyle,
                ),
              ),
              if (_hintActive)
                Text(
                  widget.hintText ?? "",
                  style: (theme.inputDecorationTheme.hintStyle ??
                          editableTextStyle)
                      .copyWith(
                    color: Theme.of(context).hintColor,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
            ],
          ),
        ],
      );
    });
  }

  Widget buildItem(int itemIndex, double maxWidth, TextStyle itemTextStyle,
      Color itemForegroundColor, Color itemBackgroundColor) {
    const removeIconSize = 16.0;
    const removeIconPadding = const EdgeInsets.all(8);
    const leftPadding = 12.0;
    final itemTextMaximumWidth =
        maxWidth - leftPadding - removeIconSize - removeIconPadding.horizontal;
    return Container(
      constraints: BoxConstraints(
          maxWidth: maxWidth,
          minHeight: removeIconSize + removeIconPadding.vertical),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: itemBackgroundColor.withOpacity(0.5),
      ),
      padding: EdgeInsets.only(left: leftPadding),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: itemTextMaximumWidth),
            child: Text(
              value![itemIndex],
              style: itemTextStyle,
              overflow: TextOverflow.fade,
            ),
          ),
          if (widget.enabled && !widget.readOnly)
            IconButton(
              splashRadius: 5,
              constraints: BoxConstraints.expand(
                height: removeIconSize + removeIconPadding.vertical,
                width: removeIconSize + removeIconPadding.horizontal,
              ),
              padding: EdgeInsets.zero,
              icon: Icon(
                Icons.cancel_rounded,
                size: removeIconSize,
              ),
              color: itemForegroundColor,
              onPressed: () => _deleteItem(itemIndex),
            )
          else
            SizedBox(width: leftPadding)
        ],
      ),
    );
  }
}
