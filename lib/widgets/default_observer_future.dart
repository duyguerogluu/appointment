import 'dart:async';

import 'package:goresy/constants/l10n/l10n.dart';
import 'package:goresy/utils/extensions/future_extensions.dart';
import 'package:flutter/material.dart';
import 'package:mobx_widget/mobx_widget.dart';

import 'custom_error.dart';

typedef CommonBuilder<D, E> = Widget Function(
    BuildContext context, D? data, E? error, bool loading,
    {bool unstarted});

class DefaultObserverFuture<D, E> extends StatefulWidget {
  final int retry;
  final void Function(ObservableFuture<dynamic>?)? listen;
  final ObservableFuture<D?>? Function() observableFuture;
  final Future<void> Function()? fetchData;
  final Widget Function(BuildContext)? onUnstarted;
  final Widget Function(BuildContext)? onNull;
  final Widget Function(BuildContext)? onPending;
  final Widget Function(BuildContext, E)? onError;
  final Widget Function(BuildContext, D)? onData;
  final CommonBuilder<D, E>? builder;
  final bool pullToRefresh;
  final bool autoRefresh;
  final bool autoInitialize;

  const DefaultObserverFuture({
    super.key,
    this.retry = 3,
    this.listen,
    required this.observableFuture,
    this.fetchData,
    this.onUnstarted,
    this.onNull,
    this.onPending,
    this.onError,
    required Widget Function(BuildContext, D) onData,
    this.pullToRefresh = true,
    this.autoInitialize = true,
    this.autoRefresh = false,
  })  : builder = null,
        onData = onData;

  const DefaultObserverFuture.builder({
    super.key,
    this.retry = 3,
    this.listen,
    required this.observableFuture,
    this.fetchData,
    required Widget Function(BuildContext, D?, E?, bool, {bool unstarted})
        builder,
    this.pullToRefresh = true,
    this.autoInitialize = true,
    this.autoRefresh = false,
  })  : onUnstarted = null,
        onNull = null,
        onPending = null,
        onError = null,
        onData = null,
        builder = builder;

  @override
  State<DefaultObserverFuture<D, E>> createState() =>
      _DefaultObserverFutureState<D, E>();
}

class _DefaultObserverFutureState<D, E>
    extends State<DefaultObserverFuture<D, E>> {
  D? _data;

  @override
  void initState() {
    super.initState();

    final future = widget.observableFuture();
    _data = future?.value;

    if (widget.autoInitialize && _data == null)
      widget.fetchData?.call();
    else if (widget.autoRefresh) widget.fetchData?.call();
  }

  @override
  Widget build(BuildContext context) {
    var child = ObserverFuture<D, E>(
      fetchData: widget.fetchData,
      observableFuture: widget.observableFuture,
      reloadButtonText: S.current.reload,
      autoInitialize: false,
      retry: widget.fetchData == null ? 0 : widget.retry,
      onUnstarted: widget.builder != null
          ? (context) =>
              widget.builder!(context, null, null, false, unstarted: true)
          : (widget.onUnstarted ?? _onUnstartedBuilder(widget.fetchData)),
      onNull: widget.builder != null
          ? (context) => widget.builder!(context, null, null, false)
          : (widget.onNull ?? _onNullBuilder()),
      onPending: widget.builder != null
          ? (context) => widget.builder!(context, _data, null, true)
          : (widget.onPending ?? _onPendingBuilder()),
      onError: widget.builder != null
          ? (context, error) => widget.builder!(context, null, error, false)
          : (widget.onError ?? _onErrorBuilder(widget.fetchData)),
      onData: (context, data) {
        _data = data;
        return widget.builder != null
            ? widget.builder!(context, data, null, false)
            : widget.onData!(context, data);
      },
    );

    final fetchFunc = widget.fetchData;
    return !widget.pullToRefresh || fetchFunc == null
        ? child
        : RefreshIndicator(
            child: child,
            onRefresh: fetchFunc,
          );
  }

  static Widget Function(BuildContext)? _onUnstartedBuilder(
      Future<void> Function()? fetchData) {
    return (context) => Center(
          child: TextButton.icon(
            icon: Icon(Icons.refresh_rounded),
            label: Text(S.of(context).load_),
            onPressed: fetchData == null ? null : () => fetchData(),
          ),
        );
  }

  static Widget Function(BuildContext)? _onPendingBuilder() {
    return (context) => Center(
          child: CircularProgressIndicator(),
        );
  }

  static Widget Function(BuildContext)? _onNullBuilder() {
    return (context) =>
        Center(child: CustomError.noResultsFound(context: context));
  }

  static Widget Function(BuildContext, E)? _onErrorBuilder<E>(
      Future<void> Function()? fetchData) {
    return (context, error) => Center(
          child: CustomError.autoDetech(
            context: context,
            error: error,
            onPressRetry: fetchData == null ? null : () => fetchData(),
          ),
        );
  }
}
