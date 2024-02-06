import 'package:goresy/constants/constants.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

class DialogHeader extends StatelessWidget {
  final String title;
  final bool searchable;
  final Function(String)? onSearchTextChanged;
  final Function()? onTapClose;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final BorderRadius? borderRadius;

  DialogHeader({
    super.key,
    required this.title,
    this.searchable = false,
    this.onSearchTextChanged,
    this.onTapClose,
    this.backgroundColor,
    this.foregroundColor,
    this.borderRadius = const BorderRadius.vertical(top: Radius.circular(16)),
  });

  @override
  Widget build(BuildContext context) {
    final _backgroundColor =
        backgroundColor ?? Theme.of(context).colorScheme.background;
    final titleForegroundColor = foregroundColor ?? _backgroundColor.onColor;

    final textFieldBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(
        width: 0,
        color: Colors.transparent,
      ),
    );

    return Material(
      type: MaterialType.canvas,
      borderOnForeground: false,
      color: _backgroundColor,
      borderRadius: borderRadius,
      child: Container(
        constraints: BoxConstraints(minHeight: kMinInteractiveDimension + 0.5),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 0.5,
              color: Theme.of(context).dividerColor,
            ),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 2.0,
                      bottom: 2.0,
                      left: 20,
                    ),
                    child: Text(
                      title,
                      maxLines: 2,
                      style: TextStyle(
                        color: titleForegroundColor,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                if (onTapClose != null)
                  IconButton(
                    onPressed: onTapClose,
                    icon: Icon(
                      Icons.close_rounded,
                    ),
                    color: titleForegroundColor,
                  ),
              ],
            ),
            if (searchable)
              Padding(
                padding: const EdgeInsets.only(
                  left: 12,
                  right: 12,
                  bottom: 12,
                ),
                child: TextField(
                  cursorColor: titleForegroundColor,
                  onChanged: onSearchTextChanged,
                  style: TextStyle(
                    color: titleForegroundColor,
                  ),
                  decoration: InputDecoration(
                    constraints: BoxConstraints(maxHeight: 42),
                    contentPadding: EdgeInsets.zero,
                    prefixIcon: Icon(
                      Icons.search_rounded,
                      color: titleForegroundColor,
                    ),
                    hintText: "${S.of(context).search}...",
                    hintStyle: TextStyle(
                      color: titleForegroundColor.withOpacity(0.7),
                    ),
                    border: textFieldBorder,
                    enabledBorder: textFieldBorder,
                    focusedBorder: textFieldBorder,
                    fillColor: titleForegroundColor.withOpacity(0.1),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
