import 'package:goresy/constants/constants.dart';
import 'package:goresy/data/network/exceptions/network_exceptions.dart';
import 'package:goresy/router/app_router.dart';
import 'package:goresy/stores/auth_store.dart';
import 'package:goresy/stores/theme_store.dart';
import 'package:goresy/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:window_manager/window_manager.dart';

import 'login_form.dart';

class LoginScreen extends StatelessWidget {
  final _authStore = getIt<AuthStore>();
  final _themeStore = getIt<ThemeStore>();

  Widget _buildBody(BuildContext context) {
    return DefaultObserverFuture.builder(
        observableFuture: () => _authStore.signInFuture,
        builder:
            (BuildContext context, bool? success, Object? error, bool loading,
                {bool unstarted = false}) {
          if (success == true) {
            Future.microtask(() => context.go(
                  AppRouter.initialLocationWithSession,
                  addToHistory: false,
                ));

            return SizedBox();
          }

          final errorMessage = error == null
              ? null
              : error is UserFriendlyException
                  ? error.message
                  : S.of(context).customErrorSomethingWentWrong;

          return LoginForm(
            errorMessage: errorMessage,
            loading: loading,
          );
        });
  }

  Widget _buildLeftBackground(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      constraints: Dimens.isLarge(context)
          ? BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width / 2,
            )
          : null,
      child: Image.asset(
        alignment: Alignment.topLeft,
        Assets.loginBg01,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildRightBackground(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width / 2,
      ),
      child: Image.asset(
        Assets.loginBg02,
        fit: BoxFit.fitHeight,
      ),
    );
  }

  Widget _buildWindowIconsAndDragToMoveArea(BuildContext context) {
    return DragToMoveArea(
      child: Material(
        color: Colors.transparent,
        child: Container(
          alignment: Alignment.topRight,
          height: kToolbarHeight + 10,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: WindowIcons(
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget child = Card(
      margin: Dimens.formMargin.double,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Dimens.formPadding.horizontal,
          vertical: Dimens.formPadding.horizontal / 2,
        ),
        child: _buildBody(context),
      ),
    );

    if (Dimens.isMobileLayout(context)) {
      child = Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            Assets.loginBg01,
            fit: BoxFit.cover,
            alignment: Alignment.topLeft,
          ),
          SingleChildScrollView(
            reverse: true,
            child: child,
          ),
        ],
      );
    } else {
      child = Stack(
        children: [
          _buildLeftBackground(context),
          if (Dimens.isLarge(context))
            Align(
              alignment: Alignment.topRight,
              child: _buildRightBackground(context),
            ),
          Center(
            child: SingleChildScrollView(
              padding: Dimens.formPadding.double,
              child: Center(
                child: Container(
                  constraints: BoxConstraints(maxWidth: 450),
                  child: child,
                ),
              ),
            ),
          ),
          if (UniversalPlatform.isDesktop)
            _buildWindowIconsAndDragToMoveArea(context),
        ],
      );
    }

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.black,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        primary: true,
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Padding(
          padding: Dimens.safeBottomPaddingOf(context),
          child: child,
        ),
      ),
    );
  }
}
