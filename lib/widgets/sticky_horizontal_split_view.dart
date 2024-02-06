import 'package:flutter/material.dart';

class StickyHorizontalSplitView extends StatefulWidget {
  final Widget top;
  final Widget bottom;
  final double ratio;

  const StickyHorizontalSplitView(
      {super.key, required this.top, required this.bottom, this.ratio = 0.5})
      : assert(ratio >= 0),
        assert(ratio <= 1);

  @override
  _StickyHorizontalSplitViewState createState() =>
      _StickyHorizontalSplitViewState();
}

class _StickyHorizontalSplitViewState extends State<StickyHorizontalSplitView>
    with SingleTickerProviderStateMixin {
  final _dividerHeight = 42.0;

  late Animation<double> animation;
  late AnimationController controller;

  //from 0-1
  late double _ratio;
  late double _initialRatio;
  late double _lastSavedRatio;

  double? _maxHeight;

  get _height1 => _ratio * _maxHeight!;

  get _height2 => (1 - _ratio) * _maxHeight!;

  @override
  void initState() {
    super.initState();
    _ratio = widget.ratio;
    _initialRatio = widget.ratio;
    _lastSavedRatio = widget.ratio;

    controller = AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, BoxConstraints constraints) {
      assert(_ratio <= 1);
      assert(_ratio >= 0);
      if (_maxHeight == null)
        _maxHeight = constraints.maxHeight - _dividerHeight - 105;
      if (_maxHeight != constraints.maxHeight) {
        _maxHeight = constraints.maxHeight - _dividerHeight - 105;
      }

      return SizedBox(
        width: constraints.maxWidth,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 105,
            ),
            SizedBox(
              height: _height1,
              child: widget.top,
            ),
            Stack(
              children: [
                SizedBox(
                  height: _height2 + _dividerHeight,
                  child: Container(
                    color: Color(0xFFFAFAFA),
                    padding: EdgeInsets.only(top: _dividerHeight),
                    child: widget.bottom,
                  ),
                ),
                Container(
                  height: _dividerHeight,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x2C000000),
                        blurRadius: 1,
                        offset: Offset(0, 0.5),
                        spreadRadius: 0.5,
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  child: Container(
                    color: Color(0x00000000),
                    child: SizedBox(
                      width: constraints.maxWidth,
                      height: _ratio < 0.2
                          ? _dividerHeight
                          : _height2 + _dividerHeight,
                      child: Container(
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.linear_scale,
                            color: Color(0xFF444444),
                          ),
                        ),
                      ),
                    ),
                  ),
                  onPanEnd: (details) {
                    double start;
                    if (_lastSavedRatio < _ratio) {
                      start = _ratio;
                      _lastSavedRatio =
                          _ratio < _initialRatio ? _initialRatio : 0.99999999;
                    } else {
                      start = _ratio;
                      _lastSavedRatio =
                          _ratio > _initialRatio ? _initialRatio : 0;
                    }

                    controller.stop(canceled: true);
                    controller.reset();
                    animation =
                        Tween<double>(begin: start, end: _lastSavedRatio)
                            .animate(controller)
                          ..addListener(() {
                            setState(() {
                              _ratio = animation.value;
                            });
                          });
                    controller.forward();
                  },
                  onPanUpdate: (DragUpdateDetails details) {
                    setState(() {
                      _ratio += details.delta.dy / _maxHeight!;
                      if (_ratio > 1)
                        _ratio = 1;
                      else if (_ratio < 0) _ratio = 0;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
