// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'language_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LanguageStore on _LanguageStore, Store {
  Computed<Locale>? _$localeComputed;

  @override
  Locale get locale => (_$localeComputed ??=
          Computed<Locale>(() => super.locale, name: '_LanguageStore.locale'))
      .value;
  Computed<String>? _$languageCodeComputed;

  @override
  String get languageCode =>
      (_$languageCodeComputed ??= Computed<String>(() => super.languageCode,
              name: '_LanguageStore.languageCode'))
          .value;
  Computed<String?>? _$countryCodeComputed;

  @override
  String? get countryCode =>
      (_$countryCodeComputed ??= Computed<String?>(() => super.countryCode,
              name: '_LanguageStore.countryCode'))
          .value;

  late final _$_localeAtom =
      Atom(name: '_LanguageStore._locale', context: context);

  @override
  Locale get _locale {
    _$_localeAtom.reportRead();
    return super._locale;
  }

  @override
  set _locale(Locale value) {
    _$_localeAtom.reportWrite(value, super._locale, () {
      super._locale = value;
    });
  }

  late final _$_LanguageStoreActionController =
      ActionController(name: '_LanguageStore', context: context);

  @override
  void changeLanguage(Locale locale) {
    final _$actionInfo = _$_LanguageStoreActionController.startAction(
        name: '_LanguageStore.changeLanguage');
    try {
      return super.changeLanguage(locale);
    } finally {
      _$_LanguageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
locale: ${locale},
languageCode: ${languageCode},
countryCode: ${countryCode}
    ''';
  }
}
