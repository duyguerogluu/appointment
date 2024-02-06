// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'constants_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ConstantsStore on _ConstantsStore, Store {
  Computed<ConstantsStoreState>? _$storeStateComputed;

  @override
  ConstantsStoreState get storeState => (_$storeStateComputed ??=
          Computed<ConstantsStoreState>(() => super.storeState,
              name: '_ConstantsStore.storeState'))
      .value;

  late final _$_storeStateAtom =
      Atom(name: '_ConstantsStore._storeState', context: context);

  @override
  ConstantsStoreState get _storeState {
    _$_storeStateAtom.reportRead();
    return super._storeState;
  }

  @override
  set _storeState(ConstantsStoreState value) {
    _$_storeStateAtom.reportWrite(value, super._storeState, () {
      super._storeState = value;
    });
  }

  late final _$_enumsReadyAtom =
      Atom(name: '_ConstantsStore._enumsReady', context: context);

  @override
  bool get _enumsReady {
    _$_enumsReadyAtom.reportRead();
    return super._enumsReady;
  }

  @override
  set _enumsReady(bool value) {
    _$_enumsReadyAtom.reportWrite(value, super._enumsReady, () {
      super._enumsReady = value;
    });
  }

  late final _$_ConstantsStoreActionController =
      ActionController(name: '_ConstantsStore', context: context);

  @override
  dynamic dispose() {
    final _$actionInfo = _$_ConstantsStoreActionController.startAction(
        name: '_ConstantsStore.dispose');
    try {
      return super.dispose();
    } finally {
      _$_ConstantsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setStoreState(ConstantsStoreState val) {
    final _$actionInfo = _$_ConstantsStoreActionController.startAction(
        name: '_ConstantsStore.setStoreState');
    try {
      return super.setStoreState(val);
    } finally {
      _$_ConstantsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic _setEnumsReady() {
    final _$actionInfo = _$_ConstantsStoreActionController.startAction(
        name: '_ConstantsStore._setEnumsReady');
    try {
      return super._setEnumsReady();
    } finally {
      _$_ConstantsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  Future<bool> fetchConstants() {
    final _$actionInfo = _$_ConstantsStoreActionController.startAction(
        name: '_ConstantsStore.fetchConstants');
    try {
      return super.fetchConstants();
    } finally {
      _$_ConstantsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
storeState: ${storeState}
    ''';
  }
}
