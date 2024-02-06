import 'package:goresy/constants/dimens.dart';
import 'package:goresy/widgets/widgets.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class Backdrop extends InheritedWidget {
  final BackdropScaffoldState data;

  const Backdrop({super.key, required this.data, required super.child});

  static BackdropScaffoldState of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<Backdrop>()!.data;

  @override
  bool updateShouldNotify(Backdrop oldWidget) => oldWidget.data != data;
}

class BackdropScaffold extends StatefulWidget {
  final Duration animationDuration;
  final Widget backLayer;
  final Widget frontLayer;
  final bool subHeaderAlwaysActive;
  final double? headerHeight;
  final BorderRadius? frontLayerBorderRadius;
  final double frontLayerElevation;
  final bool stickyFrontLayer;
  final bool isOpen;
  final Curve animationCurve;
  final Curve? reverseAnimationCurve;
  final Color? backLayerBackgroundColor;
  final Color? frontLayerBackgroundColor;
  final double frontLayerActiveFactor;
  final Color frontLayerScrim;
  final Color backLayerScrim;
  final VoidCallback? onOpen;
  final VoidCallback? onClosed;
  final bool maintainBackLayerState;

  final GlobalKey<ScaffoldState>? scaffoldKey;
  final PreferredSizeWidget? appBar;

  final bool extendBody;
  final bool extendBodyBehindAppBar;

  final List<Widget>? persistentFooterButtons;
  final Widget? drawer;
  final DrawerCallback? onDrawerChanged;
  final Widget? endDrawer;
  final DrawerCallback? onEndDrawerChanged;

  final Color? drawerScrimColor;
  final Color? backgroundColor;
  final Widget? bottomNavigationBar;
  final Widget? bottomSheet;
  final bool? resizeToAvoidBottomInset;
  final bool primary;
  final DragStartBehavior drawerDragStartBehavior;
  final double? drawerEdgeDragWidth;
  final bool drawerEnableOpenDragGesture;
  final bool endDrawerEnableOpenDragGesture;
  final String? restorationId;

  final IconData? floatingActionButtonIcon;
  final String? floatingActionButtonText;
  final Function()? floatingActionButtonOnPressed;
  final String? frontLayerTitle;

  final Color? headerBackgroundColor;
  final Color? headerForegroundColor;

  BackdropScaffold({
    super.key,
    this.animationDuration = const Duration(milliseconds: 500),
    required this.backLayer,
    required this.frontLayer,
    this.subHeaderAlwaysActive = true,
    this.headerHeight,
    this.frontLayerBorderRadius = const BorderRadius.vertical(
      top: Radius.circular(16),
    ),
    this.frontLayerElevation = 1,
    this.frontLayerTitle,
    this.stickyFrontLayer = false,
    this.isOpen = false,
    this.animationCurve = Curves.ease,
    this.reverseAnimationCurve,
    this.frontLayerBackgroundColor,
    double frontLayerActiveFactor = 1,
    this.backLayerBackgroundColor,
    this.frontLayerScrim = Colors.transparent,
    this.backLayerScrim = Colors.black54,
    this.onOpen,
    this.onClosed,
    this.maintainBackLayerState = true,
    this.scaffoldKey,
    this.appBar,
    this.floatingActionButtonIcon,
    this.floatingActionButtonText,
    this.floatingActionButtonOnPressed,
    this.persistentFooterButtons,
    this.drawer,
    this.onDrawerChanged,
    this.endDrawer,
    this.onEndDrawerChanged,
    this.bottomNavigationBar,
    this.bottomSheet,
    this.backgroundColor,
    this.resizeToAvoidBottomInset,
    this.primary = true,
    this.drawerDragStartBehavior = DragStartBehavior.start,
    this.extendBody = false,
    this.extendBodyBehindAppBar = false,
    this.drawerScrimColor,
    this.drawerEdgeDragWidth,
    this.drawerEnableOpenDragGesture = true,
    this.endDrawerEnableOpenDragGesture = true,
    this.restorationId,
    this.headerBackgroundColor,
    this.headerForegroundColor,
  }) : frontLayerActiveFactor = frontLayerActiveFactor.clamp(0, 1).toDouble();

  @override
  BackdropScaffoldState createState() => BackdropScaffoldState();
}

class BackdropScaffoldState extends State<BackdropScaffold>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late ColorTween _backLayerScrimColorTween;

  late GlobalKey<ScaffoldState> scaffoldKey;
  double _backPanelHeight = 0;
  double _subHeaderHeight = 0;

  AnimationController get animationController => _animationController;

  @override
  void initState() {
    super.initState();
    scaffoldKey = widget.scaffoldKey ?? GlobalKey<ScaffoldState>();
    _animationController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
      value: widget.isOpen ? 1 : 0,
    );

    _backLayerScrimColorTween = _buildBackLayerScrimColorTween();

    _animationController.addListener(() => setState(() {}));
  }

  @override
  void didUpdateWidget(covariant BackdropScaffold oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.backLayerScrim != widget.backLayerScrim) {
      _backLayerScrimColorTween = _buildBackLayerScrimColorTween();
    }
  }

  bool get isOpen =>
      animationController.status == AnimationStatus.completed ||
      animationController.status == AnimationStatus.forward;

  bool get isClosed =>
      animationController.status == AnimationStatus.dismissed ||
      animationController.status == AnimationStatus.reverse;

  void toggle() {
    FocusScope.of(context).unfocus();
    if (isOpen) {
      close();
    } else {
      open();
    }
  }

  void close() {
    if (isOpen) {
      animationController.animateBack(-1);
      widget.onClosed?.call();
    }
  }

  void open() {
    if (isClosed) {
      animationController.animateTo(1);
      widget.onOpen?.call();
    }
  }

  double get _headerHeight {
    // if defined then use it
    if (widget.headerHeight != null) return widget.headerHeight!;

    // if subHeader then height of subHeader
    return _subHeaderHeight;
  }

  Widget? _buildFloatingActionButton() {
    final buttonText = widget.floatingActionButtonText;
    return buttonText == null
        ? null
        : Padding(
            padding: Dimens.miniEndDockedFABPadding,
            child: AnimatedSlide(
              duration: widget.animationDuration,
              offset: !isOpen ? Offset.zero : Offset(0, 2.5),
              child: FloatingActionButton.extended(
                onPressed: widget.floatingActionButtonOnPressed,
                label: Text(buttonText),
                icon: widget.floatingActionButtonIcon == null
                    ? null
                    : Icon(widget.floatingActionButtonIcon),
              ),
            ),
          );
  }

  Animation<RelativeRect> _getPanelAnimation(
      BuildContext context, BoxConstraints constraints) {
    double backPanelHeight, frontPanelHeight;
    final availableHeight = constraints.biggest.height - _headerHeight;
    if (widget.stickyFrontLayer && _backPanelHeight < availableHeight) {
      // height is adapted to the height of the back panel
      backPanelHeight = _backPanelHeight;
      frontPanelHeight = -_backPanelHeight;
    } else {
      // height is set to fixed value defined in widget.headerHeight
      backPanelHeight = availableHeight;
      frontPanelHeight = -backPanelHeight;
    }
    return RelativeRectTween(
      begin: RelativeRect.fromLTRB(0, backPanelHeight, 0, frontPanelHeight),
      end: RelativeRect.fromLTRB(
          0, availableHeight * (1 - widget.frontLayerActiveFactor), 0, 0),
    ).animate(CurvedAnimation(
        parent: animationController,
        curve: widget.animationCurve,
        reverseCurve:
            widget.reverseAnimationCurve ?? widget.animationCurve.flipped));
  }

  Widget _buildInactiveLayer(BuildContext context) {
    return Offstage(
      offstage: animationController.status == AnimationStatus.completed,
      child: FadeTransition(
        opacity: Tween<double>(begin: 1, end: 0).animate(animationController),
        child: GestureDetector(
          onTap: () => toggle(),
          behavior: HitTestBehavior.opaque,
          child: Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  color: widget.frontLayerScrim,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBackPanel() {
    return Stack(
      children: [
        FocusScope(
          canRequestFocus: isClosed,
          child: Material(
            color: widget.backLayerBackgroundColor ??
                Theme.of(context).scaffoldBackgroundColor,
            child: Column(
              children: <Widget>[
                Flexible(
                  child: MeasureSize(
                    onChange: (size) =>
                        setState(() => _backPanelHeight = size.height),
                    child: !widget.maintainBackLayerState && isOpen
                        ? Container()
                        : widget.backLayer,
                  ),
                ),
              ],
            ),
          ),
        ),
        if (_hasBackLayerScrim) _buildBackLayerScrim(),
      ],
    );
  }

  Widget _buildFrontPanel(BuildContext context) {
    return Material(
      color: widget.frontLayerBackgroundColor,
      elevation: widget.frontLayerElevation,
      borderRadius: widget.frontLayerBorderRadius,
      child: Stack(
        children: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            verticalDirection: VerticalDirection.up,
            children: <Widget>[
              Flexible(child: widget.frontLayer),
              if (widget.frontLayerTitle != null)
                MeasureSize(
                  onChange: (size) =>
                      setState(() => _subHeaderHeight = size.height),
                  child: DialogHeader(
                    title: widget.frontLayerTitle!,
                    onTapClose: close,
                    borderRadius: widget.frontLayerBorderRadius,
                  ),
                ),
            ],
          ),
          _buildInactiveLayer(context),
        ],
      ),
    );
  }

  Future<bool> _willPopCallback(BuildContext context) async {
    if (!isClosed) {
      close();
      return false;
    }
    return true;
  }

  ColorTween _buildBackLayerScrimColorTween() => ColorTween(
        begin: Colors.transparent,
        end: widget.backLayerScrim,
      );

  Widget _buildBody(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _willPopCallback(context),
      child: Scaffold(
        key: scaffoldKey,
        appBar: widget.appBar,
        body: LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              fit: StackFit.expand,
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                _buildBackPanel(),
                PositionedTransition(
                  rect: _getPanelAnimation(context, constraints),
                  child: _buildFrontPanel(context),
                ),
              ],
            );
          },
        ),
        floatingActionButton: _buildFloatingActionButton(),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniEndDocked,
        persistentFooterButtons: widget.persistentFooterButtons,
        drawer: widget.drawer,
        onDrawerChanged: widget.onDrawerChanged,
        endDrawer: widget.endDrawer,
        onEndDrawerChanged: widget.onEndDrawerChanged,
        bottomNavigationBar: widget.bottomNavigationBar,
        bottomSheet: widget.bottomSheet,
        backgroundColor: widget.backgroundColor,
        resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
        primary: widget.primary,
        drawerDragStartBehavior: widget.drawerDragStartBehavior,
        extendBody: widget.extendBody,
        extendBodyBehindAppBar: widget.extendBodyBehindAppBar,
        drawerScrimColor: widget.drawerScrimColor,
        drawerEdgeDragWidth: widget.drawerEdgeDragWidth,
        drawerEnableOpenDragGesture: widget.drawerEnableOpenDragGesture,
        endDrawerEnableOpenDragGesture: widget.endDrawerEnableOpenDragGesture,
        restorationId: widget.restorationId,
      ),
    );
  }

  Container _buildBackLayerScrim() => Container(
      color: _backLayerScrimColorTween.evaluate(animationController),
      height: _backPanelHeight);

  bool get _hasBackLayerScrim => isOpen && widget.frontLayerActiveFactor < 1;

  @override
  Widget build(BuildContext context) {
    return Backdrop(
      data: this,
      child: Builder(
        builder: (context) => _buildBody(context),
      ),
    );
  }
}
