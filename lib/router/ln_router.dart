import 'package:goresy/utils/logger.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

export 'package:goresy/router/ln_router_extensions.dart';
export 'package:go_router/src/route.dart' hide GoRoute, ShellRoute;

class LnRouter extends GoRouter {
  static final bool logRouteCommands = false;
  static final bool logRouteChanges = false;
  static final bool logRedirects = false;
  static final bool logHistoryChanges = false;

  static List<String> _historyRoutes = [];
  final int historySize;

  final Map<String, String> redirects = <String, String>{};

  LnRouter({
    required List<LnRouteBase> routes,
    super.errorPageBuilder,
    super.errorBuilder,
    //super.redirect,
    super.refreshListenable,
    super.redirectLimit = 5,
    super.routerNeglect = true,
    super.initialLocation,
    super.observers,
    super.debugLogDiagnostics = false,
    super.navigatorKey,
    super.restorationScopeId,
    this.historySize = 3,
  }) : super(routes: routes) {
    if (logRouteChanges)
      addListener(() {
        Log.route("RouteChange: $location");
      });

    findRedirects("", routes);
  }

  findRedirects(String rootPath, List<RouteBase> routes) {
    routes.forEach((route) {
      String fullRoutePath = rootPath;

      if (route is LnRoute) {
        fullRoutePath = "$fullRoutePath/${route.path}".replaceAll('//', '/');
        final redirectTo = route.redirectTo;

        if (redirectTo != null) {
          redirects[fullRoutePath] = redirectTo.startsWith('/')
              ? redirectTo
              : "$fullRoutePath/$redirectTo";
        }
      }

      findRedirects(fullRoutePath, route.routes);
    });
  }

  static LnRouter of(BuildContext context) => GoRouter.of(context) as LnRouter;

  static LnRouter? maybeOf(BuildContext context) =>
      GoRouter.of(context) as LnRouter;

  void _addToHistory(String location) {
    _historyRoutes.add(location);
    if (_historyRoutes.length > historySize) {
      _historyRoutes.removeAt(0);
    }
    if (logHistoryChanges) Log.route("HistoryChange: $_historyRoutes");
  }

  void clearHistory() {
    _historyRoutes.clear();
  }

  bool canGoBack() {
    return _historyRoutes.length > 0;
  }

  void goBack() {
    if (logRouteCommands) Log.route("Router.goBack()");
    super.go(_historyRoutes.last);
    _historyRoutes.removeLast();
    if (logHistoryChanges) Log.route("HistoryChange: $_historyRoutes");
  }

  @override
  void go(
    String location, {
    Object? extra,
    bool addToHistory = true,
    bool fromRoot = false,
  }) {
    if (!fromRoot) throw Exception("Only root commands allowed.");
    if (logRouteCommands) Log.route("Router.go($location)");

    location = redirectedLocation(location);
    if (addToHistory) _addToHistory(this.location);
    super.go(location, extra: extra);
  }

  @override
  void goNamed(
    String name, {
    Map<String, String> params = const <String, String>{},
    Map<String, dynamic> queryParams = const <String, dynamic>{},
    Object? extra,
    bool addToHistory = true,
    bool fromRoot = false,
  }) {
    if (!fromRoot) throw Exception("Only root commands allowed.");
    if (logRouteCommands) Log.route("Router.goNamed($name)");

    super.goNamed(
      name,
      params: params,
      queryParams: queryParams,
      extra: extra,
    );
  }

  @override
  Future<T?> push<T extends Object?>(
    String location, {
    Object? extra,
    bool fromRoot = false,
  }) {
    if (!fromRoot) throw Exception("Only root commands allowed.");
    if (logRouteCommands) Log.route("Router.push($location)");

    return super.push(location, extra: extra);
  }

  @override
  Future<T?> pushNamed<T extends Object?>(
    String name, {
    Map<String, String> params = const <String, String>{},
    Map<String, dynamic> queryParams = const <String, dynamic>{},
    Object? extra,
    bool fromRoot = false,
  }) {
    if (!fromRoot) throw Exception("Only root commands allowed.");
    if (logRouteCommands) Log.route("Router.pushNamed($name)");

    return super.pushNamed(name,
        params: params, queryParams: queryParams, extra: extra);
  }

  @override
  void pushReplacement(
    String location, {
    Object? extra,
    bool fromRoot = false,
  }) {
    if (!fromRoot) throw Exception("Only root commands allowed.");
    if (logRouteCommands) Log.route("Router.pushReplacement($location)");

    super.pushReplacement(location, extra: extra);
  }

  @override
  void pushReplacementNamed(
    String name, {
    Map<String, String> params = const <String, String>{},
    Map<String, dynamic> queryParams = const <String, dynamic>{},
    Object? extra,
    bool fromRoot = false,
  }) {
    if (!fromRoot) throw Exception("Only root commands allowed.");
    if (logRouteCommands) Log.route("Router.pushReplacementNamed($name)");

    super.pushReplacementNamed(name,
        params: params, queryParams: queryParams, extra: extra);
  }

  @override
  void pop<T extends Object?>([T? result]) {
    if (logRouteCommands) Log.route("Router.pop($result)");

    super.pop<T>(result);
  }

  @override
  void refresh() {
    if (logRouteCommands) Log.route("Router.refresh()");

    super.refresh();
  }

  String redirectedLocation(String location) {
    for (var loc in redirects.keys) {
      if (loc == location) {
        return redirectedLocation(redirects[loc]!);
      }
    }

    return location;
  }
}

Widget _commonTransitionsBuilder(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child) {
  const begin = const Offset(1.0, 0.0);
  const end = Offset.zero;
  final tween =
      Tween(begin: begin, end: end).chain(CurveTween(curve: Curves.easeInOut));
  final offsetAnimation = animation.drive(tween);
  return SlideTransition(
    position: offsetAnimation,
    child: Container(
      child: child,
      color: Theme.of(context).scaffoldBackgroundColor,
    ),
  );
}

abstract class LnRouteBase implements RouteBase {
  LnRouteBase._();
}

class LnRoute extends GoRoute implements LnRouteBase {
  final String? redirectTo;
  LnRoute(
    String path, {
    String? redirect,
    //super.name,
    super.builder,
    super.parentNavigatorKey,
    List<LnRouteBase> routes = const <LnRouteBase>[],
  })  : redirectTo = redirect,
        super(
          routes: routes,
          path: path,
          redirect: builder != null ? null : (context, state) => null,
          pageBuilder: builder == null
              ? null
              : (context, state) {
                  return CustomTransitionPage<void>(
                    key: state.pageKey,
                    child: builder.call(context, state),
                    transitionsBuilder: _commonTransitionsBuilder,
                  );
                },
        );
}

class LnShellRoute extends ShellRoute implements LnRouteBase {
  LnShellRoute({
    super.builder,
    super.observers,
    List<LnRouteBase> routes = const <LnRouteBase>[],
    super.navigatorKey,
  }) : super(
          routes: routes,
          pageBuilder: builder == null
              ? null
              : (context, state, widget) {
                  return CustomTransitionPage<void>(
                    key: state.pageKey,
                    child: builder.call(context, state, widget),
                    transitionsBuilder: _commonTransitionsBuilder,
                  );
                },
        );
}
