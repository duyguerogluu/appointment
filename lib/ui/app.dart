import 'package:goresy/constants/strings.dart';
import 'package:goresy/router/app_router.dart';
import 'package:goresy/stores/language_store.dart';
import 'package:goresy/stores/theme_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../constants/l10n/l10n.dart';

class App extends StatelessWidget {
  final ThemeStore _themeStore = getIt<ThemeStore>();
  final LanguageStore _languageStore = getIt<LanguageStore>();

  final AppRouter _rootRouter = getIt<AppRouter>();

  @override
  Widget build(BuildContext context) {
    return Observer(
      name: 'global-observer',
      builder: (context) {
        _themeStore.menuSideIsLeft;
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: Strings.appName,
          theme: _themeStore.computedDarkMode
              ? _themeStore.darkThemeData
              : _themeStore.lightThemeData,
          locale: _languageStore.locale,
          supportedLocales: S.delegate.supportedLocales,
          localizationsDelegates: [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          routerConfig: _rootRouter,
        );
      },
    );
  }
}
