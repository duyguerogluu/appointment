import 'package:flutter/material.dart';

class AnimatedIconWidget extends StatefulWidget {
  final double? size;
  const AnimatedIconWidget({super.key, this.size = 24});

  @override
  State<AnimatedIconWidget> createState() => _AnimatedIconWidgetState();
}

class _AnimatedIconWidgetState extends State<AnimatedIconWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )
      ..forward()
      ..repeat(reverse: true);
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(controller);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: animation,
        size: widget.size ?? 24,
        semanticLabel: 'Show menu',
      ),
    );
  }
}
