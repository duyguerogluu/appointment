import 'package:goresy/widgets/window_icons.dart';
import 'package:flutter/material.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:window_manager/window_manager.dart';

class DraggableAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget title;
  final List<Widget>? actions;

  const DraggableAppBar({
    super.key,
    required this.title,
    required this.actions,
  });

  @override
  Widget build(BuildContext context) {
    final actionButtons =
        UniversalPlatform.isWindows || UniversalPlatform.isLinux
            ? [
                if (actions != null) ...actions!,
                ...WindowIcons(),
              ]
            : actions;

    final appBar = AppBar(
      title: title,
      actions: actionButtons,
    );

    if (UniversalPlatform.isDesktop) {
      return DragToMoveArea(
        child: appBar,
      );
    } else {
      return appBar;
    }
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
