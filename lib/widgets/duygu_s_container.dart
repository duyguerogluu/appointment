import 'package:flutter/material.dart';
import 'package:goresy/constants/constants.dart';

// ignore: must_be_immutable
class DuyguSContainer extends Container {
  final int elevation;
  final Color color;

  DuyguSContainer({
    super.key,
    super.alignment,
    super.padding,
    required this.color,
    super.width,
    super.height,
    super.constraints,
    super.margin,
    super.transform,
    super.transformAlignment,
    super.child,
    super.clipBehavior = Clip.none,
    this.elevation = 1,
  }) : assert(elevation >= 0 && elevation <= 6,
            "If you want more, you can add new ones");

  late BuildContext _context;

  @override
  Decoration? get decoration => ShapeDecoration(
        color: color,
        shape: CustomShape(),
        shadows: elevation == 0
            ? null
            : [
                <int, BoxShadow>{
                  1: AppThemeData.elevation1BoxShadowOf(_context),
                  2: AppThemeData.elevation2BoxShadowOf(_context),
                  3: AppThemeData.elevation3BoxShadowOf(_context),
                  4: AppThemeData.elevation4BoxShadowOf(_context),
                  5: AppThemeData.elevation5BoxShadowOf(_context),
                  6: AppThemeData.elevation6BoxShadowOf(_context),
                }[elevation]!,
              ],
      );

  @override
  Widget build(BuildContext context) {
    _context = context;
    return super.build(context);
  }
}

class CustomShape extends ShapeBorder {
  const CustomShape();

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.zero;

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    final size = rect.size;

    return Path()
      ..moveTo(rect.left, rect.top)
      ..lineTo(rect.left + size.width, rect.top)
      ..lineTo(
          rect.left + size.width - size.height * 0.1, rect.top + size.height)
      ..lineTo(rect.left, rect.top + size.height * 0.97);
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return getInnerPath(rect, textDirection: textDirection);
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    canvas.drawPaint(BorderSide.none.toPaint());
  }

  @override
  ShapeBorder scale(double t) {
    return CustomShape();
  }
}

/*class CustomClipPath extends CustomClipper<Path> {
  var radius = 5.0;
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0.0, 0.0);
    path.lineTo(size.width, 0.0);
    path.lineTo(size.width * 0.98, size.height);
    path.lineTo(0, size.height);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}*/