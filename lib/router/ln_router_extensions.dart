import 'package:goresy/router/ln_router.dart';
import 'package:flutter/widgets.dart';

extension BuildContextExtensions on BuildContext {
  void clearHistory() {
    LnRouter.of(this).clearHistory();
  }

  bool canGoBack() {
    return LnRouter.of(this).canGoBack();
  }

  void goBack() {
    LnRouter.of(this).goBack();
  }

  void go(
    String location, {
    Object? extra,
    bool addToHistory = true,
  }) =>
      LnRouter.of(this).go(
        location,
        extra: extra,
        addToHistory: addToHistory,
        fromRoot: true,
      );

  void goNamed(
    String name, {
    Map<String, String> params = const <String, String>{},
    Map<String, dynamic> queryParams = const <String, dynamic>{},
    Object? extra,
    bool addToHistory = true,
  }) =>
      LnRouter.of(this).goNamed(
        name,
        params: params,
        queryParams: queryParams,
        extra: extra,
        addToHistory: addToHistory,
        fromRoot: true,
      );

  void push(
    String location, {
    Object? extra,
  }) =>
      LnRouter.of(this).push(
        location,
        extra: extra,
        fromRoot: true,
      );

  void pushNamed(
    String name, {
    Map<String, String> params = const <String, String>{},
    Map<String, dynamic> queryParams = const <String, dynamic>{},
    Object? extra,
  }) =>
      LnRouter.of(this).pushNamed(
        name,
        params: params,
        queryParams: queryParams,
        extra: extra,
        fromRoot: true,
      );

  void pushReplacement(
    String location, {
    Object? extra,
  }) =>
      LnRouter.of(this).pushReplacement(
        location,
        extra: extra,
        fromRoot: true,
      );

  void pushReplacementNamed(
    String name, {
    Map<String, String> params = const <String, String>{},
    Map<String, dynamic> queryParams = const <String, dynamic>{},
    Object? extra,
  }) =>
      LnRouter.of(this).pushReplacementNamed(
        name,
        params: params,
        queryParams: queryParams,
        extra: extra,
        fromRoot: true,
      );

  bool canPop() => LnRouter.of(this).canPop();

  void pop<T extends Object?>([T? result]) => LnRouter.of(this).pop(result);

  void refresh() => LnRouter.of(this).refresh();

  String namedLocation(
    String name, {
    Map<String, String> params = const <String, String>{},
    Map<String, dynamic> queryParams = const <String, dynamic>{},
  }) =>
      LnRouter.of(this)
          .namedLocation(name, params: params, queryParams: queryParams);
}
