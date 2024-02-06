import 'package:goresy/constants/constants.dart';
import 'package:goresy/router/app_router.dart';
import 'package:goresy/widgets/custom_error.dart';
import 'package:goresy/widgets/highlight_text.dart';
import 'package:flutter/material.dart';

import 'dialog_header.dart';

class SelectionDialog<ItemType> extends StatefulWidget {
  final String title;
  final Iterable<ItemType> items;
  final String Function(ItemType) itemLabelBuilder;
  final Function(ItemType) onSubmit;
  final Function()? onCancel;
  final ItemType? selectedItem;
  final bool searchable;
  final EdgeInsets padding;
  final Color? headerBackgroundColor;
  final bool? shrinkWrap;
  final AlignmentGeometry? alignment;

  const SelectionDialog({
    super.key,
    required this.title,
    required this.items,
    required this.itemLabelBuilder,
    required this.onSubmit,
    this.onCancel,
    this.selectedItem,
    this.searchable = false,
    this.padding = const EdgeInsets.all(32),
    this.headerBackgroundColor,
    this.shrinkWrap,
    this.alignment,
  });

  @override
  State<SelectionDialog<ItemType>> createState() =>
      _SelectionDialogState<ItemType>();

  static Future<ItemType?> show<ItemType>({
    required BuildContext context,
    required String title,
    required Iterable<ItemType> items,
    required String Function(ItemType) itemLabelBuilder,
    Function(ItemType)? onSubmit,
    bool showCancelButtons = true,
    ItemType? selectedItem,
    bool searchable = false,
    AlignmentGeometry? alignment,
  }) {
    return showDialog<ItemType>(
      context: context,
      barrierDismissible: false,
      useRootNavigator: true,
      builder: (context) => SelectionDialog<ItemType>(
        title: title,
        items: items,
        itemLabelBuilder: itemLabelBuilder,
        onSubmit: (val) {
          context.pop<ItemType?>(val);
          onSubmit?.call(val);
        },
        onCancel: showCancelButtons
            ? () {
                context.pop<ItemType?>(null);
              }
            : null,
        selectedItem: selectedItem,
        searchable: searchable,
        alignment: alignment,
      ),
    );
  }
}

class _SelectionDialogState<ItemType> extends State<SelectionDialog<ItemType>> {
  ItemType? _value;
  String _searchText = "";

  @override
  void initState() {
    super.initState();

    _value = widget.selectedItem;
  }

  @override
  Widget build(BuildContext context) {
    var filteredItems = widget.items.where(
        (e) => widget.itemLabelBuilder(e).toLowerCase().contains(_searchText));
    final onCancel = widget.onCancel;

    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      insetPadding: widget.padding,
      buttonPadding: EdgeInsets.zero,
      titlePadding: EdgeInsets.zero,
      actionsPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
      title: DialogHeader(
        searchable: widget.searchable,
        title: widget.title,
        onSearchTextChanged: (val) => setState(() {
          _searchText = val.toLowerCase();
        }),
        onTapClose: onCancel,
        backgroundColor: widget.headerBackgroundColor,
      ),
      actions: <Widget>[
        if (onCancel != null)
          TextButton(
            child: Text(S.of(context).dialogCancel),
            onPressed: () {
              onCancel();
            },
          ),
        if (onCancel != null)
          SizedBox(
            width: 6,
          ),
        TextButton(
          child: Text(S.of(context).dialogConfirm),
          onPressed: _value == null
              ? null
              : () {
                  widget.onSubmit(_value!);
                },
        ),
      ],
      content: Container(
        width: Dimens.maxDialogWidth,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Theme.of(context).dividerColor,
              width: 0.5,
            ),
          ),
        ),
        child: filteredItems.length > 0
            ? ListView.builder(
                shrinkWrap: widget.shrinkWrap ?? !widget.searchable,
                itemCount: filteredItems.length,
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) => RadioListTile<ItemType>(
                  title: HighlightText(
                    widget.itemLabelBuilder(filteredItems.elementAt(index)),
                    highlight: _searchText,
                    highlightStyle: TextStyle(
                      backgroundColor: Theme.of(context).highlightColor,
                      color: Theme.of(context).primaryColor,
                    ),
                    ignoreCase: true,
                  ),
                  value: filteredItems.elementAt(index),
                  groupValue: _value,
                  selected: _value == filteredItems.elementAt(index),
                  onChanged: (val) => setState(() {
                    _value = val;
                  }),
                ),
              )
            : Center(
                child: CustomError.noResultsFound(context: context),
              ),
      ),
    );
  }
}
