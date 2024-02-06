// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'partner_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PartnerStore on _PartnerStore, Store {
  Computed<bool>? _$isLoggedInComputed;

  @override
  bool get isLoggedIn =>
      (_$isLoggedInComputed ??= Computed<bool>(() => super.isLoggedIn,
              name: '_PartnerStore.isLoggedIn'))
          .value;
  Computed<bool>? _$sessionReadyComputed;

  @override
  bool get sessionReady =>
      (_$sessionReadyComputed ??= Computed<bool>(() => super.sessionReady,
              name: '_PartnerStore.sessionReady'))
          .value;

  late final _$_isLoggedInAtom =
      Atom(name: '_PartnerStore._isLoggedIn', context: context);

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

  late final _$partnersFutureAtom =
      Atom(name: '_PartnerStore.partnersFuture', context: context);

  @override
  ObservableFuture<List<Partner>>? get partnersFuture {
    _$partnersFutureAtom.reportRead();
    return super.partnersFuture;
  }

  @override
  set partnersFuture(ObservableFuture<List<Partner>>? value) {
    _$partnersFutureAtom.reportWrite(value, super.partnersFuture, () {
      super.partnersFuture = value;
    });
  }

  late final _$_PartnerStoreActionController =
      ActionController(name: '_PartnerStore', context: context);

  @override
  Future<List<Partner>> fetchPartners() {
    final _$actionInfo = _$_PartnerStoreActionController.startAction(
        name: '_PartnerStore.fetchPartners');
    try {
      return super.fetchPartners();
    } finally {
      _$_PartnerStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  Future<Partner> fetchPartner(String pid) {
    final _$actionInfo = _$_PartnerStoreActionController.startAction(
        name: '_PartnerStore.fetchPartner');
    try {
      return super.fetchPartner(pid);
    } finally {
      _$_PartnerStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
partnersFuture: ${partnersFuture},
isLoggedIn: ${isLoggedIn},
sessionReady: ${sessionReady}
    ''';
  }
}
