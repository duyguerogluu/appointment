import 'package:goresy/constants/constants.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:timelines/timelines.dart';

import 'dart:math';

class ProgressSteps extends StatelessWidget {
  final Color? todoColor;
  final Color? inProgressColor;
  final Color? completedColor;
  final Color? onInProgressColor;
  final Color? onCompletedColor;
  final int progressIndex;
  final int activeIndex;
  final List<String> stepTitles;
  final List<IconData> stepIcons;
  final EdgeInsets padding;
  final Function(int)? onTapStep;

  final double dotSize;

  ProgressSteps({
    super.key,
    required BuildContext context,
    this.todoColor,
    this.inProgressColor,
    this.completedColor,
    this.onInProgressColor,
    this.onCompletedColor,
    required this.progressIndex,
    required this.activeIndex,
    required this.stepTitles,
    required this.stepIcons,
    double? dotSize,
    this.onTapStep,
    this.padding = const EdgeInsets.symmetric(vertical: 12),
  }) : dotSize = dotSize ?? (Dimens.isMobileLayout(context) ? 36 : 42);

  ProgressSteps.onBackground({
    super.key,
    required BuildContext context,
    required this.progressIndex,
    required this.activeIndex,
    required this.stepTitles,
    required this.stepIcons,
    double? dotSize,
    this.onTapStep,
    this.padding = const EdgeInsets.symmetric(vertical: 12),
  })  : dotSize = dotSize ?? (Dimens.isMobileLayout(context) ? 36 : 42),
        todoColor = Theme.of(context)
            .colorScheme
            .primary
            .blend(Theme.of(context).colorScheme.onPrimary, 60),
        inProgressColor = Theme.of(context).colorScheme.primary,
        completedColor = Theme.of(context).colorScheme.primary,
        onInProgressColor = Theme.of(context).colorScheme.onPrimary,
        onCompletedColor = Theme.of(context).colorScheme.onPrimary;

  ProgressSteps.onAppBar({
    super.key,
    required BuildContext context,
    required this.progressIndex,
    required this.activeIndex,
    required this.stepTitles,
    required this.stepIcons,
    double? dotSize,
    this.onTapStep,
    this.padding = const EdgeInsets.symmetric(vertical: 12),
  })  : dotSize = dotSize ?? (Dimens.isMobileLayout(context) ? 36 : 42),
        todoColor = Theme.of(context)
            .appBarTheme
            .foregroundColor!
            .blend(Theme.of(context).appBarTheme.backgroundColor!, 60),
        inProgressColor = Theme.of(context).appBarTheme.foregroundColor,
        completedColor = Theme.of(context).appBarTheme.foregroundColor,
        onInProgressColor = Theme.of(context).appBarTheme.backgroundColor,
        onCompletedColor = Theme.of(context).appBarTheme.backgroundColor;

  Color getColor(BuildContext context, int index) {
    final inProgressC = inProgressColor ?? Theme.of(context).highlightColor;
    if (index == progressIndex) {
      return inProgressC;
    } else if (index < progressIndex) {
      return completedColor ?? inProgressC;
    } else {
      return todoColor ??
          (Theme.of(context).brightness == Brightness.dark
              ? inProgressC.darken(50)
              : inProgressC.lighten(50));
    }
  }

  Color getOnColor(BuildContext context, int index) {
    final onInProgressC =
        onInProgressColor ?? Theme.of(context).highlightColor.onColor;
    if (index == progressIndex) {
      return onInProgressC;
    } else if (index < progressIndex) {
      return onCompletedColor ?? onInProgressC;
    } else {
      return Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      child: _buildTimeline(context),
      height: dotSize + 24 + padding.vertical,
    );
  }

  Widget _buildTimeline(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Timeline.tileBuilder(
        theme: TimelineThemeData(
          direction: Axis.horizontal,
          nodePosition: 0,
          connectorTheme: ConnectorThemeData(
            space: dotSize,
            thickness: 5.0,
          ),
        ),
        builder: TimelineTileBuilder.connected(
          connectionDirection: ConnectionDirection.before,
          itemExtentBuilder: (_, __) =>
              constraints.maxWidth / stepTitles.length,
          /*oppositeContentsBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Icon(
              _timelineStepIcons[index],
              color: getColor(index),
            ),
          );
        },*/
          contentsBuilder: (_, index) {
            return Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Text(
                stepTitles[index],
                style: TextStyle(
                  color: getColor(context, index),
                ),
              ),
            );
          },
          indicatorBuilder: (_, index) {
            var color = getColor(context, index);
            var onColor = getOnColor(context, index);
            var child;
            if (index == progressIndex) {
              child = Icon(
                stepIcons[index],
                color: onColor,
                size: dotSize * 0.5,
              );
            } else if (index < progressIndex) {
              child = Icon(
                Icons.check_rounded,
                color: onColor,
                size: dotSize * 0.5,
              );
            }

            if (index <= progressIndex) {
              final size = index == activeIndex ? dotSize : dotSize * 0.75;
              return Stack(
                children: [
                  CustomPaint(
                    size: Size(size, size),
                    painter: _BezierPainter(
                      color: color,
                      drawStart: index > 0,
                      drawEnd: index < progressIndex,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      onTapStep?.call(index);
                    },
                    child: DotIndicator(
                      size: size,
                      color: color,
                      child: child,
                    ),
                  ),
                ],
              );
            } else {
              return Stack(
                children: [
                  CustomPaint(
                    size: Size(dotSize / 2, dotSize / 2),
                    painter: _BezierPainter(
                      color: color,
                      drawEnd: index < stepTitles.length - 1,
                    ),
                  ),
                  OutlinedDotIndicator(
                    size: dotSize / 2,
                    borderWidth: 4.0,
                    color: color,
                  ),
                ],
              );
            }
          },
          connectorBuilder: (_, index, type) {
            if (index > 0) {
              if (index == progressIndex) {
                var prevColor = getColor(context, index - 1);
                var color = getColor(context, index);
                List<Color> gradientColors;
                if (type == ConnectorType.start) {
                  gradientColors = [Color.lerp(prevColor, color, 0.5)!, color];
                } else {
                  gradientColors = [
                    prevColor,
                    Color.lerp(prevColor, color, 0.5)!
                  ];
                }
                return DecoratedLineConnector(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: gradientColors,
                    ),
                  ),
                );
              } else {
                return SolidLineConnector(
                  color: getColor(context, index),
                );
              }
            } else {
              return null;
            }
          },
          itemCount: stepTitles.length,
        ),
      );
    });
  }
}

class _BezierPainter extends CustomPainter {
  const _BezierPainter({
    required this.color,
    this.drawStart = true,
    this.drawEnd = true,
  });

  final Color color;
  final bool drawStart;
  final bool drawEnd;

  Offset _offset(double radius, double angle) {
    return Offset(
      radius * cos(angle) + radius,
      radius * sin(angle) + radius,
    );
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = color;

    final radius = size.width / 2;

    var angle;
    var offset1;
    var offset2;

    var path;

    if (drawStart) {
      angle = 3 * pi / 4;
      offset1 = _offset(radius, angle);
      offset2 = _offset(radius, -angle);
      path = Path()
        ..moveTo(offset1.dx, offset1.dy)
        ..quadraticBezierTo(0.0, size.height / 2, -radius, radius)
        ..quadraticBezierTo(0.0, size.height / 2, offset2.dx, offset2.dy)
        ..close();

      canvas.drawPath(path, paint);
    }
    if (drawEnd) {
      angle = -pi / 4;
      offset1 = _offset(radius, angle);
      offset2 = _offset(radius, -angle);

      path = Path()
        ..moveTo(offset1.dx, offset1.dy)
        ..quadraticBezierTo(
            size.width, size.height / 2, size.width + radius, radius)
        ..quadraticBezierTo(size.width, size.height / 2, offset2.dx, offset2.dy)
        ..close();

      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(_BezierPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.drawStart != drawStart ||
        oldDelegate.drawEnd != drawEnd;
  }
}
