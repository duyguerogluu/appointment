import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:universal_platform/universal_platform.dart';

import 'dependency-injections/components/service_locator.dart';
import 'ui/app.dart';
import 'utils/logger.dart';

import 'package:window_manager/window_manager.dart';

Future<void>? main() => runZonedGuarded(() async {
      WidgetsFlutterBinding.ensureInitialized();

      /*if (UniversalPlatform.isAndroid || UniversalPlatform.isIOS)
        await FirebaseMessagingService.initialize();*/

      if (UniversalPlatform.isDesktop) {
        await windowManager.ensureInitialized();

        WindowOptions windowOptions = WindowOptions(
          size: Size(1240, 800),
          minimumSize: Size(350, 500),
          center: true,
          backgroundColor: Colors.transparent,
          skipTaskbar: false,
          titleBarStyle: TitleBarStyle.hidden,
        );
        windowManager.waitUntilReadyToShow(windowOptions, () async {
          await windowManager.show();
          await windowManager.focus();
        });
      }

      await setPreferredOrientations();
      await setupLocator();

      runApp(App());
    }, (error, stackTrace) {
      Log.e(error, stackTrace: stackTrace);
    });

Future<void> setPreferredOrientations() {
  return SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
  ]);
}
