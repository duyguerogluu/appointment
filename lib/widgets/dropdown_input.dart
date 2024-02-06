import 'package:flutter/material.dart';

class DropdownInput extends StatefulWidget {
  DropdownInput({
    super.key,
    this.placeholder,
    required this.items,
    required this.renderItemText,
    this.value,
    required this.onSelected,
  });

  final String? placeholder;
  final List<dynamic> items;
  final String Function(dynamic) renderItemText;
  final dynamic value;
  final Function(dynamic) onSelected;

  @override
  _DropdownInputState createState() => _DropdownInputState();
}

class _DropdownInputState extends State<DropdownInput> {
  final _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _textEditingController.text = widget.renderItemText(widget.value);
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<dynamic>(
      child: Container(
        child: TextFormField(
          controller: _textEditingController,
          decoration: InputDecoration(
              labelText: widget.placeholder,
              labelStyle: TextStyle(color: Colors.grey[700]),
              disabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 1)),
              alignLabelWithHint: true),
          enabled: false,
        ),
      ),
      onSelected: (dynamic result) {
        _textEditingController.text = widget.renderItemText(result);
        widget.onSelected(result);
      },
      itemBuilder: (BuildContext context) => widget.items
          .map((item) => PopupMenuItem<dynamic>(
                height: 32,
                value: item,
                child: Text(widget.renderItemText(item)),
              ))
          .toList(),
    );
  }
}
