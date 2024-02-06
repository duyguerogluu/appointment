import 'dart:ui';

import 'package:goresy/constants/dimens.dart';
import 'package:goresy/widgets/custom_error.dart';
import 'package:goresy/widgets/responsive.dart';
import 'package:flutter/material.dart';

class DefaultListView extends ListView {
  final int? itemCount;
  final bool loading;
  final Object? error;
  final Function()? onPressRetry;

  DefaultListView({
    super.key,
    super.scrollDirection,
    super.reverse,
    super.controller,
    super.primary,
    super.physics,
    super.shrinkWrap,
    super.padding = Dimens.listPadding,
    super.itemExtent,
    super.prototypeItem,
    super.addAutomaticKeepAlives = true,
    super.addRepaintBoundaries = true,
    super.addSemanticIndexes = true,
    super.cacheExtent,
    super.children = const <Widget>[],
    super.semanticChildCount,
    super.dragStartBehavior,
    super.keyboardDismissBehavior,
    super.restorationId,
    super.clipBehavior,
    required this.loading,
    required this.error,
    required this.onPressRetry,
  }) : itemCount = null;

  DefaultListView.builder({
    super.key,
    super.scrollDirection,
    super.reverse,
    super.controller,
    super.primary,
    super.physics,
    super.shrinkWrap,
    super.padding = Dimens.listPadding,
    super.itemExtent,
    super.prototypeItem,
    required super.itemBuilder,
    super.findChildIndexCallback,
    this.itemCount,
    super.addAutomaticKeepAlives = true,
    super.addRepaintBoundaries = true,
    super.addSemanticIndexes = true,
    super.cacheExtent,
    super.semanticChildCount,
    super.dragStartBehavior,
    super.keyboardDismissBehavior,
    super.restorationId,
    super.clipBehavior,
    required this.loading,
    required this.error,
    required this.onPressRetry,
  }) : super.builder(itemCount: itemCount ?? 0);

  @override
  Widget build(BuildContext context) {
    bool hasResult = loading ||
        error != null ||
        itemCount != 0 ||
        childrenDelegate.estimatedChildCount != 0;

    var child = Responsive(
      child: hasResult
          ? super.build(context)
          : Padding(
              padding: padding ?? const EdgeInsets.all(16),
              child: CustomError.noResultsFound(context: context),
            ),
    );

    return Stack(
      children: [
        child,
        if (loading)
          ClipRRect(
            child: AbsorbPointer(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 1.5, sigmaY: 1.5),
                child: SizedBox.expand(),
              ),
            ),
          ),
        if (loading)
          Container(
            alignment: Alignment.center,
            child: CircularProgressIndicator(),
          )
        else if (error != null)
          Container(
            alignment: Alignment.center,
            color: Theme.of(context).colorScheme.error.withOpacity(0.4),
            child: CustomError.autoDetech(
              context: context,
              onPressRetry: onPressRetry,
              error: error,
            ),
          ),
      ],
    );
  }
}
