import 'package:flutter/material.dart';

class Dimens {
  Dimens._();

  static const EdgeInsets listPadding =
      const EdgeInsets.symmetric(vertical: 8, horizontal: 8);

  static const double formVerticalSpacing = 12.0;
  static const double formHorizontalSpacing = 8.0;

  static const EdgeInsets formMargin = const EdgeInsets.all(12);
  static const EdgeInsets formPadding = const EdgeInsets.symmetric(
    vertical: 24,
    horizontal: 12,
  );

  static const EdgeInsets bottomPaddingForFAB =
      const EdgeInsets.only(bottom: 58);

  static EdgeInsets safeBottomPaddingOf(BuildContext context) =>
      EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom);

  static bool isMobileLayout(BuildContext context) =>
      MediaQuery.of(context).size.width < 700;
  static bool isLarge(BuildContext context) =>
      MediaQuery.of(context).size.width > _largeLayoutThreshold;

  static const double _largeLayoutThreshold = 1200;
  static const double maxDialogWidth = 600;
  static const double maxContainerWidth = 600;
  static const double drawerWidth = 304;
  static const double masterViewWidth =
      (_largeLayoutThreshold - drawerWidth) / 2;

  static const EdgeInsets miniEndDockedFABPadding = EdgeInsets.only(bottom: 12);
}

extension EdgeInsetsExtensions on EdgeInsets {
  EdgeInsets get double => this + this;
}

extension EdgeInsetsGeometryExtensions on EdgeInsetsGeometry {
  EdgeInsetsGeometry get double => this.add(this);
}
