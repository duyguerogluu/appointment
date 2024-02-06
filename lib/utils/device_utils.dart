//
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'logger.dart';

/// Helper class for device related operations.
///
class DeviceUtils {
  ///
  /// hides the keyboard if its already open
  ///
  static hideKeyboard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  ///
  /// accepts a double [scale] and returns scaled sized based on the screen
  /// orientation
  ///
  static double getScaledSize(BuildContext context, double scale) =>
      scale *
      (MediaQuery.of(context).orientation == Orientation.portrait
          ? MediaQuery.of(context).size.width
          : MediaQuery.of(context).size.height);

  ///
  /// accepts a double [scale] and returns scaled sized based on the screen
  /// width
  ///
  static double getScaledWidth(BuildContext context, double scale) =>
      scale * MediaQuery.of(context).size.width;

  ///
  /// accepts a double [scale] and returns scaled sized based on the screen
  /// height
  ///
  static double getScaledHeight(BuildContext context, double scale) =>
      scale * MediaQuery.of(context).size.height;

  static Future<DeviceInfo> getDeviceInfo() async {
    late String deviceName;
    late String deviceVersion;
    late String identifier;
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        var build = await deviceInfo.androidInfo;
        deviceName = build.model;
        deviceVersion = build.version.toString();
        identifier = build.id; //UUID for Android
      } else if (Platform.isIOS) {
        var data = await deviceInfo.iosInfo;
        deviceName = data.name ?? "";
        deviceVersion = data.systemVersion ?? "";
        identifier = data.identifierForVendor ?? ""; //UUID for iOS
      }
    } on PlatformException {
      Log.e('Failed to get platform version');
    }

    return DeviceInfo(deviceName, deviceVersion, identifier);
  }

  static copyToClipboard(
      GlobalKey<ScaffoldState> scaffoldKey, String textToCopy, String message) {
    FlutterClipboard.copy(textToCopy).then((result) {
      final snackBar = SnackBar(
        content: Text(message),
        duration: Duration(seconds: 1),
      );
      ScaffoldMessenger.of(scaffoldKey.currentContext!).showSnackBar(snackBar);
    });
  }

  static setStatusBarBrightness(Brightness brightness) {
    if (Platform.isAndroid
        ? brightness == Brightness.light
        : brightness == Brightness.dark) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
          statusBarColor: Colors.transparent, // Color for Android
          statusBarBrightness:
              Brightness.dark // Dark == white status bar -- for IOS.
          ));
    } else if (Platform.isAndroid
        ? brightness == Brightness.dark
        : brightness == Brightness.light) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
          statusBarColor: Colors.transparent, // Color for Android
          statusBarBrightness:
              Brightness.light // Dark == white status bar -- for IOS.
          ));
    }
  }
}

class DeviceInfo {
  final String deviceName;
  final String deviceVersion;
  final String identifier;

  DeviceInfo(this.deviceName, this.deviceVersion, this.identifier);
}
