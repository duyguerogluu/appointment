import 'package:flutter/material.dart';

class CustomPopupMenuItem extends PopupMenuItem {
  CustomPopupMenuItem({
    super.key,
    required IconData icon,
    required String text,
    super.onTap,
  }) : super(
          child: Row(
            children: [
              Icon(icon),
              SizedBox(
                width: 8,
              ),
              Expanded(child: Text(text)),
            ],
          ),
        );
}
