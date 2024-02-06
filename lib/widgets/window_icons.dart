import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

List<Widget> WindowIcons({Color? color}) => [
      IconButton(
        onPressed: () {
          windowManager.minimize();
        },
        icon: Icon(
          Icons.minimize,
          size: 20,
          color: color,
        ),
      ),
      IconButton(
        onPressed: () {
          windowManager.maximize();
        },
        icon: Icon(
          Icons.fullscreen_rounded,
          size: 20,
          color: color,
        ),
      ),
      IconButton(
        onPressed: () {
          windowManager.close();
        },
        icon: Icon(
          Icons.close_rounded,
          size: 20,
          color: color,
        ),
      )
    ];
