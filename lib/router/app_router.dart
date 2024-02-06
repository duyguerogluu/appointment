import 'package:goresy/constants/l10n/l10n.dart';
import 'package:goresy/router/ln_router.dart';
import 'package:goresy/ui/partner_detail_screen.dart';
import 'package:goresy/ui/ui.dart';
import 'package:flutter/material.dart';

import '../ui/partners_screen.dart';
import '../widgets/dialogs/dialogs.dart';

export 'ln_router.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> wrapperDrawerShellKey =
    GlobalKey<NavigatorState>(debugLabel: 'wrapper-drawer');

class AppRouter extends LnRouter {
  static final initialLocationWithSession = "/partners";
  static final initialLocationWithoutSession = "/login";

  AppRouter()
      : super(
          navigatorKey: _rootNavigatorKey,
          initialLocation: '/splash',
          historySize: 5,
          routes: [
            LnRoute('/splash', builder: (_, __) => SplashScreen()),
            LnRoute('/onboarding', builder: (_, __) => OnBoardingScreen()),
            LnRoute('/login', builder: (_, __) => LoginScreen()),
            LnShellRoute(
              navigatorKey: wrapperDrawerShellKey,
              builder: (context, state, child) => WillPopScope(
                key: state.pageKey,
                onWillPop: () async {
                  if (context.canPop()) {
                    context.pop();
                  } else if (context.canGoBack()) {
                    context.goBack();
                  } else {
                    var result = await ConfirmationDialog.show(
                      context: wrapperDrawerShellKey.currentContext!,
                      message: S.of(context).areYouSureYouWantToExit,
                    );

                    if (result) return Future.value(true);
                  }

                  return Future.value(false);
                },
                child: SessionWrapper(
                  initialRoute: state.fullpath,
                  child: child,
                ),
              ),
              routes: [
                LnRoute(
                  '/partners',
                  builder: (context, state) {
                    return PartnersScreen(key: state.pageKey);
                  },
                ),
                LnRoute(
                  '/partners/:pid',
                  builder: (context, state) {
                    return PartnerDetailScreen(
                      partnerId: state.params['pid']!,
                    );
                  },
                ),
                LnRoute('/settings', redirect: 'application'),
                LnRoute(
                  '/settings/my-profile',
                  builder: (context, state) => SizedBox(),
                ),
                LnRoute(
                  '/settings/application',
                  builder: (context, state) => ApplicationSettingsScreen(),
                ),
              ],
            ),
          ],
        );
}
