import 'package:goresy/constants/dimens.dart';
import 'package:flutter/material.dart';

Responsive({EdgeInsetsGeometry? padding, required Widget child}) {
  return Container(
    alignment: Alignment.topCenter,
    child: Container(
      child: child,
      padding: padding,
      constraints: BoxConstraints(maxWidth: Dimens.maxContainerWidth),
    ),
  );
}
