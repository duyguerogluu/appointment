import 'dart:async';

import 'package:mobx/mobx.dart';

export 'package:mobx/mobx.dart';

extension ObservableFutureExtensions<T> on ObservableFuture<T> {
  ObservableFuture<T> delayedWhenComplete(
    Duration duration,
    void Function(ObservableFuture<T>) action,
  ) =>
      this
        ..whenComplete(() {
          Future.delayed(duration, () => action(this));
          return this;
        });

  ObservableFuture<T> resetterForFormResults(
    void Function(ObservableFuture<T>) action,
  ) =>
      this
        ..whenComplete(() {
          Future.delayed(const Duration(seconds: 5), () => action(this));
          return this;
        });

  ObservableFuture<T> delayedOnError(void Function(ObservableFuture<T>) action,
          {Duration delayDuration = const Duration(seconds: 5)}) =>
      this
        ..onError((error, stackTrace) {
          Future.delayed(delayDuration, () => action(this));
          return this;
        });

  ObservableFuture<T> nowOrWhenComplete(
    bool now,
    void Function(ObservableFuture<T>) action,
  ) {
    if (now) {
      action(this);
      return this;
    }

    return this
      ..whenComplete(() {
        action(this);
        return this;
      });
  }
}
