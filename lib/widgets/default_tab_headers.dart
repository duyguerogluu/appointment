import 'package:goresy/constants/dimens.dart';
import 'package:flutter/material.dart';

class DefaultTabHeaders extends StatelessWidget {
  final List<TabHeader> headers;
  const DefaultTabHeaders({super.key, required this.headers});

  @override
  Widget build(BuildContext context) {
    final isLargeLayout = Dimens.isLarge(context);
    final tabHeaderBackgroundColor = isLargeLayout
        ? Theme.of(context).colorScheme.background
        : Theme.of(context).appBarTheme.backgroundColor;
    final tabHeaderForegroundColor = isLargeLayout
        ? Theme.of(context).colorScheme.onBackground
        : Theme.of(context).appBarTheme.foregroundColor;

    final tabHeaderHeight = kMinInteractiveDimension;
    final tabIndicatorWeight = 2.0;

    return Material(
      color: tabHeaderBackgroundColor,
      shape: Border(
        bottom: BorderSide(
          width: 0.5,
          color: Theme.of(context).dividerColor,
        ),
      ),
      child: Center(
        child: TabBar(
          isScrollable: true,
          indicatorColor: tabHeaderForegroundColor,
          indicatorWeight: tabIndicatorWeight,
          tabs: headers.map((h) {
            final textWidget = Text(
              h.text,
              style: TextStyle(
                color: tabHeaderForegroundColor,
              ),
            );

            return Tab(
              height: tabHeaderHeight - tabIndicatorWeight + 0.5,
              child: h.icon == null
                  ? textWidget
                  : Row(
                      children: [
                        Icon(
                          h.icon,
                          color: tabHeaderForegroundColor,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        textWidget
                      ],
                    ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class TabHeader {
  final IconData? icon;
  final String text;
  const TabHeader({this.icon, required this.text});
}
