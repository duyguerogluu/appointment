import 'package:goresy/constants/constants.dart';
import 'package:goresy/router/app_router.dart';
import 'package:goresy/widgets/widgets.dart';
import 'package:flutter/material.dart';

class MultiSelectionDialog<ItemType> extends StatefulWidget {
  final String title;
  final Iterable<ItemType> items;
  final String Function(ItemType) itemLabelBuilder;
  final Function(List<ItemType>) onSubmit;
  final Function()? onCancel;
  final List<ItemType> selectedItems;
  final bool searchable;
  final EdgeInsets padding;
  final Color? headerBackgroundColor;
  final bool shrinkWrap;
  final Alignment? alignment;

  const MultiSelectionDialog({
    super.key,
    required this.title,
    required this.items,
    required this.itemLabelBuilder,
    required this.onSubmit,
    this.onCancel,
    this.selectedItems = const [],
    this.searchable = false,
    this.padding = EdgeInsets.zero,
    this.headerBackgroundColor,
    this.shrinkWrap = false,
    this.alignment,
  });

  @override
  State<MultiSelectionDialog<ItemType>> createState() =>
      _MultiSelectionDialogState<ItemType>();

  static Future<List<ItemType>?> show<ItemType>({
    required BuildContext context,
    required String title,
    required Iterable<ItemType> items,
    required String Function(ItemType) itemLabelBuilder,
    Function(List<ItemType>)? onSubmit,
    bool showCloseButton = true,
    List<ItemType> selectedItems = const [],
    bool searchable = false,
  }) {
    return showDialog<List<ItemType>?>(
      context: context,
      barrierDismissible: false,
      builder: (context) => MultiSelectionDialog<ItemType>(
        title: title,
        items: items,
        itemLabelBuilder: itemLabelBuilder,
        selectedItems: selectedItems,
        onSubmit: (val) {
          context.pop<List<ItemType>?>(val);
          onSubmit?.call(val);
        },
        onCancel: showCloseButton
            ? () {
                context.pop<List<ItemType>?>(null);
              }
            : null,
      ),
    );
  }
}

class _MultiSelectionDialogState<ItemType>
    extends State<MultiSelectionDialog<ItemType>> {
  late List<ItemType> _value;
  String _searchText = "";

  @override
  void initState() {
    super.initState();

    _value = widget.selectedItems;
  }

  @override
  Widget build(BuildContext context) {
    final contentDividerBorderSide =
        BorderSide(color: Theme.of(context).dividerColor, width: 0.5);

    var filteredItems = widget.items.where(
        (e) => widget.itemLabelBuilder(e).toLowerCase().contains(_searchText));

    final onCancel = widget.onCancel;

    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      insetPadding: widget.padding,
      buttonPadding: EdgeInsets.zero,
      titlePadding: EdgeInsets.zero,
      actionsPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
      alignment: widget.alignment,
      title: DialogHeader(
        searchable: widget.searchable,
        backgroundColor: widget.headerBackgroundColor,
        title: widget.title,
        onSearchTextChanged: (val) => setState(() {
          _searchText = val;
        }),
        onTapClose: onCancel,
      ),
      actions: <Widget>[
        if (onCancel != null)
          TextButton(
            child: Text(S.of(context).dialogCancel),
            onPressed: onCancel,
          ),
        if (onCancel != null)
          SizedBox(
            width: 6,
          ),
        TextButton(
          child: Text(S.of(context).dialogConfirm),
          onPressed: () => widget.onSubmit(_value),
        ),
      ],
      content: Container(
        width: Dimens.maxDialogWidth,
        decoration: BoxDecoration(
          border: Border(
            bottom: contentDividerBorderSide,
          ),
        ),
        child: filteredItems.length > 0
            ? ListView.builder(
                shrinkWrap: widget.shrinkWrap,
                itemCount: filteredItems.length,
                itemBuilder: (context, index) {
                  ItemType item = filteredItems.elementAt(index);
                  return CheckboxListTile(
                    title: HighlightText(
                      widget.itemLabelBuilder(item),
                      highlight: _searchText,
                      highlightStyle: TextStyle(
                        backgroundColor: Theme.of(context).highlightColor,
                        color: Theme.of(context).primaryColor,
                      ),
                      ignoreCase: true,
                    ),
                    value: _value.contains(item),
                    selected: _value.contains(item),
                    onChanged: (val) => setState(() {
                      if (_value.contains(item)) {
                        _value.remove(item);
                      } else {
                        _value.add(item);
                      }
                    }),
                  );
                },
              )
            : SizedBox.square(
                child: CustomError.noResultsFound(context: context),
              ),
      ),
    );
  }
}
