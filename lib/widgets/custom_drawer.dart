import 'package:goresy/constants/constants.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  final List<CustomDrawerGroup> groups;
  final List<CustomDrawerItem> items;
  final DrawerHeader? header;
  final Function(CustomDrawerItem)? onItemTap;
  final CustomDrawerItem? selectedItem;

  const CustomDrawer.grouped({
    super.key,
    required this.groups,
    this.header,
    this.onItemTap,
    this.selectedItem,
  })  : items = const [],
        assert(groups.length > 0);

  const CustomDrawer({
    super.key,
    required this.items,
    this.header,
    this.onItemTap,
    this.selectedItem,
  })  : groups = const [],
        assert(items.length > 0);

  Iterable<Widget> _buildDrawerGroup(
    BuildContext context,
    CustomDrawerGroup group,
  ) {
    return [
      Padding(
        padding: const EdgeInsets.only(top: 16.0, left: 16.0, bottom: 8.0),
        child: Text(
          group.titleBuilder(context),
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
                fontSize: 12,
              ),
        ),
      ),
      ...group.items.map((e) => _buildDrawerItem(context, e)),
      Divider(
        indent: 16,
        endIndent: 16,
      ),
    ];
  }

  Widget _buildDrawerItem(BuildContext context, CustomDrawerItem item) {
    var color = selectedItem == item
        ? Theme.of(context).textTheme.bodyMedium!.color
        : Theme.of(context).textTheme.displayMedium!.color;

    return ListTile(
      leading: Icon(item.icon),
      title: Text(
        item.titleBuilder(context),
        style: TextStyle(fontSize: 15),
      ),
      selected: selectedItem == item,
      selectedColor: color,
      textColor: color,
      iconColor: color,
      minLeadingWidth: 0,
      selectedTileColor: Theme.of(context).highlightColor,
      onTap: () {
        if (Dimens.isMobileLayout(context)) Navigator.of(context).pop();
        item.onTap != null ? item.onTap!(item) : onItemTap?.call(item);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];

    if (groups.length > 0) {
      groups.forEach((g) {
        children.addAll(_buildDrawerGroup(context, g));
      });
      children.removeLast();
    } else {
      items.forEach((i) {
        children.add(_buildDrawerItem(context, i));
      });
    }

    return Drawer(
      elevation: 0,
      child: ListView(
        padding:
            Dimens.safeBottomPaddingOf(context) + EdgeInsets.only(bottom: 24),
        children: [
          header ?? DrawerHeader(child: SizedBox()),
          ...children,
        ],
      ),
    );
  }
}

class CustomDrawerGroup {
  final String Function(BuildContext) titleBuilder;
  final List<CustomDrawerItem> items;

  const CustomDrawerGroup({
    required this.titleBuilder,
    required this.items,
  });
}

class CustomDrawerItem {
  final IconData icon;
  final String Function(BuildContext) titleBuilder;
  final bool selected;
  final String? routePath;
  final Function(CustomDrawerItem)? onTap;

  CustomDrawerItem({
    required this.icon,
    required this.titleBuilder,
    this.selected = false,
    this.routePath,
    this.onTap,
  });
}
