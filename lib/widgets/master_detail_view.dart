import 'dart:ui';

import 'package:goresy/constants/constants.dart';
import 'package:goresy/constants/dimens.dart';
import 'package:goresy/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class MasterDetailView extends StatefulWidget {
  final Widget masterView;

  final IconData? floatingActionButtonIcon;
  final String? floatingActionButtonText;
  final Function()? floatingActionButtonOnPressed;
  final Function()? onDetailHide;

  final Color? detailHeaderBackgroundColor;
  final Color? detailHeaderForegroundColor;

  final Function(MasterDetailViewController)? onControllerReady;

  MasterDetailView({
    super.key,
    required this.masterView,
    this.floatingActionButtonIcon,
    this.floatingActionButtonText,
    this.floatingActionButtonOnPressed,
    this.onDetailHide,
    this.onControllerReady,
    this.detailHeaderBackgroundColor,
    this.detailHeaderForegroundColor,
  });

  @override
  State<MasterDetailView> createState() => _MasterDetailViewState();
}

class _MasterDetailViewState extends State<MasterDetailView>
    implements MasterDetailViewController {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  BackdropScaffoldState? get _backdrop => (_scaffoldKey.currentContext == null
      ? null
      : Backdrop.of(_scaffoldKey.currentContext!));

  bool _isOpen = false;

  Widget? _detailView;
  String? _detailViewTitle;
  bool? _floatingActionButtonVisibility;

  Widget _buildDetailView() {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndDocked,
      floatingActionButton: _buildFloatingActionButton(),
      body: Column(
        children: [
          if (_isOpen && _detailViewTitle != null)
            DialogHeader(
              title: _detailViewTitle!,
              borderRadius: null,
              backgroundColor: widget.detailHeaderBackgroundColor,
              foregroundColor: widget.detailHeaderForegroundColor,
            ),
          if (_isOpen) Expanded(child: _detailView ?? SizedBox()),
        ],
      ),
    );
  }

  Widget? _buildFloatingActionButton() {
    final showing = _floatingActionButtonVisibility == null
        ? !_isOpen
        : _floatingActionButtonVisibility == true;
    final buttonText = widget.floatingActionButtonText;
    return buttonText == null
        ? null
        : Padding(
            padding: Dimens.miniEndDockedFABPadding,
            child: AnimatedSlide(
              duration: const Duration(milliseconds: 500),
              offset: showing ? Offset.zero : Offset(0, 2.5),
              child: FloatingActionButton.extended(
                elevation: 0,
                onPressed: widget.floatingActionButtonOnPressed,
                label: Text(buttonText),
                icon: widget.floatingActionButtonIcon == null
                    ? null
                    : Icon(widget.floatingActionButtonIcon),
              ),
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    Widget child;
    if (Dimens.isLarge(context)) {
      child = Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: Dimens.masterViewWidth,
            child: widget.masterView,
          ),
          VerticalDivider(width: 0.5),
          Expanded(
            child: _buildDetailView(),
          ),
        ],
      );
    } else {
      child = BackdropScaffold(
        scaffoldKey: _scaffoldKey,
        frontLayerBorderRadius: Dimens.isMobileLayout(context)
            ? BorderRadius.vertical(
                top: Radius.circular(16),
              )
            : null,
        headerHeight: 0,
        floatingActionButtonIcon: widget.floatingActionButtonIcon,
        floatingActionButtonText: widget.floatingActionButtonText,
        floatingActionButtonOnPressed: widget.floatingActionButtonOnPressed,
        frontLayerTitle: _detailViewTitle,
        frontLayer: _detailView ?? SizedBox(),
        isOpen: _detailView != null,
        backLayer: widget.masterView,
        onClosed: () => widget.onDetailHide?.call(),
        headerBackgroundColor: widget.detailHeaderBackgroundColor,
        headerForegroundColor: widget.detailHeaderForegroundColor,
      );
    }

    SchedulerBinding.instance
        .addPostFrameCallback((_) => widget.onControllerReady?.call(this));
    return child;
  }

  @override
  hideDetail() {
    setState(() {
      _floatingActionButtonVisibility = null;
      _isOpen = false;
      _backdrop?.close();
    });
  }

  @override
  showDetail() {
    setState(() {
      _isOpen = true;
      _backdrop?.open();
    });
  }

  @override
  setDetailView(
      {required Widget detailView,
      String? title,
      bool? floatingActionButtonVisibility}) {
    setState(() {
      _detailView = detailView;
      _detailViewTitle = title;
      _floatingActionButtonVisibility = floatingActionButtonVisibility;
    });
  }
}

abstract class MasterDetailViewController {
  setDetailView(
      {required Widget detailView,
      String? title,
      bool? floatingActionButtonVisibility});
  showDetail();
  hideDetail();
}
