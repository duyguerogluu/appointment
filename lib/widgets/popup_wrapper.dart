import 'package:flutter/material.dart';

class PopupWrapper extends StatefulWidget {
  PopupWrapper(
      {super.key, this.title, required this.child, required this.onClickClose});

  final String? title;
  final Widget child;
  final Function onClickClose;

  @override
  _PopupWrapperState createState() => _PopupWrapperState();
}

class _PopupWrapperState extends State<PopupWrapper> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        alignment: Alignment.topCenter,
        margin: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
        decoration: BoxDecoration(
          color: Color(0xFFF6F6F6),
          borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
        ),
        child: Column(
          verticalDirection: VerticalDirection.up,
          children: [
            Expanded(
              child: widget.child,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x2C000000),
                    blurRadius: 2,
                    offset: Offset(0, 1),
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Row(
                children: [
                  TextButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(Size.fromWidth(0)),
                      fixedSize: MaterialStateProperty.all(Size.fromHeight(56)),
                    ),
                    child: Icon(
                      Icons.cancel,
                      color: Colors.transparent,
                    ),
                  ),
                  Expanded(
                    child: widget.title != null
                        ? Text(
                            widget.title!,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          )
                        : Container(),
                    flex: 1,
                  ),
                  TextButton(
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(Size.fromWidth(0)),
                      fixedSize: MaterialStateProperty.all(Size.fromHeight(56)),
                    ),
                    onPressed: widget.onClickClose(),
                    child: Icon(
                      Icons.close,
                    ),
                    /*Text(
                          "Kapat",
                          style: TextStyle(color: PRIMARY_COLOR),
                        ),*/
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
