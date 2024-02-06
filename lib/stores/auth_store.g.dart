// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AuthStore on _AuthStore, Store {
  Computed<AuthStoreState>? _$storeStateComputed;

  @override
  AuthStoreState get storeState =>
      (_$storeStateComputed ??= Computed<AuthStoreState>(() => super.storeState,
              name: '_AuthStore.storeState'))
          .value;
  Computed<bool>? _$isLoggedInComputed;

  @override
  bool get isLoggedIn => (_$isLoggedInComputed ??=
          Computed<bool>(() => super.isLoggedIn, name: '_AuthStore.isLoggedIn'))
      .value;
  Computed<bool>? _$sessionReadyComputed;

  @override
  bool get sessionReady =>
      (_$sessionReadyComputed ??= Computed<bool>(() => super.sessionReady,
              name: '_AuthStore.sessionReady'))
          .value;

  late final _$_storeStateAtom =
      Atom(name: '_AuthStore._storeState', context: context);

  @override
  AuthStoreState get _storeState {
    _$_storeStateAtom.reportRead();
    return super._storeState;
  }

  @override
  set _storeState(AuthStoreState value) {
    _$_storeStateAtom.reportWrite(value, super._storeState, () {
      super._storeState = value;
    });
  }

  late final _$_isLoggedInAtom =
      Atom(name: '_AuthStore._isLoggedIn', context: context);

  @override
  bool get _isLoggedIn {
    _$_isLoggedInAtom.reportRead();
    return super._isLoggedIn;
  }

  @override
  set _isLoggedIn(bool value) {
    _$_isLoggedInAtom.reportWrite(value, super._isLoggedIn, () {
      super._isLoggedIn = value;
    });
  }

  late final _$signInFutureAtom =
      Atom(name: '_AuthStore.signInFuture', context: context);

  @override
  ObservableFuture<bool>? get signInFuture {
    _$signInFutureAtom.reportRead();
    return super.signInFuture;
  }

  @override
  set signInFuture(ObservableFuture<bool>? value) {
    _$signInFutureAtom.reportWrite(value, super.signInFuture, () {
      super.signInFuture = value;
    });
  }

  late final _$onClickSignOutAsyncAction =
      AsyncAction('_AuthStore.onClickSignOut', context: context);

  @override
  Future<bool> onClickSignOut() {
    return _$onClickSignOutAsyncAction.run(() => super.onClickSignOut());
  }

  late final _$_AuthStoreActionController =
      ActionController(name: '_AuthStore', context: context);

  @override
  dynamic setStoreState(AuthStoreState val) {
    final _$actionInfo = _$_AuthStoreActionController.startAction(
        name: '_AuthStore.setStoreState');
    try {
      return super.setStoreState(val);
    } finally {
      _$_AuthStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  Future<bool> onClickSignIn(String username, String password) {
    final _$actionInfo = _$_AuthStoreActionController.startAction(
        name: '_AuthStore.onClickSignIn');
    try {
      return super.onClickSignIn(username, password);
    } finally {
      _$_AuthStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
signInFuture: ${signInFuture},
storeState: ${storeState},
isLoggedIn: ${isLoggedIn},
sessionReady: ${sessionReady}
    ''';
  }
}
