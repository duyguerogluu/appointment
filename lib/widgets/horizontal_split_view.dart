import 'package:flutter/material.dart';

class HorizontalSplitView extends StatefulWidget {
  final Widget top;
  final Widget bottom;
  final double ratio;

  const HorizontalSplitView(
      {super.key, required this.top, required this.bottom, this.ratio = 0.5})
      : assert(ratio >= 0),
        assert(ratio <= 1);

  @override
  _HorizontalSplitViewState createState() => _HorizontalSplitViewState();
}

class _HorizontalSplitViewState extends State<HorizontalSplitView> {
  final _dividerHeight = 24.0;

  //from 0-1
  late double _ratio;
  double? _maxHeight;

  get _height1 => _ratio * _maxHeight!;

  get _height2 => (1 - _ratio) * _maxHeight!;

  @override
  void initState() {
    super.initState();
    _ratio = widget.ratio;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, BoxConstraints constraints) {
      assert(_ratio <= 1);
      assert(_ratio >= 0);
      if (_maxHeight == null)
        _maxHeight = constraints.maxHeight - _dividerHeight;
      if (_maxHeight != constraints.maxHeight) {
        _maxHeight = constraints.maxHeight - _dividerHeight;
      }

      return SizedBox(
        width: constraints.maxWidth,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: _height1,
              child: widget.top,
            ),
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              child: SizedBox(
                width: constraints.maxWidth,
                height: _dividerHeight,
                child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x2C000000),
                          blurRadius: 5,
                          offset: Offset(0, 2),
                          spreadRadius: 2,
                        )
                      ],
                      color: Color(0xFFFAFAFA),
                    ),
                    child: Icon(
                      Icons.linear_scale,
                      color: Color(0xFF444444),
                    )),
              ),
              onPanUpdate: (DragUpdateDetails details) {
                setState(() {
                  _ratio += details.delta.dy / _maxHeight!;
                  if (_ratio > 1)
                    _ratio = 1;
                  else if (_ratio < 0.0) _ratio = 0.0;
                });
              },
            ),
            SizedBox(
              height: _height2,
              child: widget.bottom,
            ),
          ],
        ),
      );
    });
  }
}
