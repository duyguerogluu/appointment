import 'package:goresy/constants/constants.dart';
import 'package:goresy/data/repository.dart';
import 'package:goresy/utils/extensions/future_extensions.dart';
import 'package:flutter/widgets.dart';

export 'package:goresy/dependency-injections/components/service_locator.dart';

part 'language_store.g.dart';

class LanguageStore = _LanguageStore with _$LanguageStore;

abstract class _LanguageStore with Store {
  // repository instance
  final Repository _repository;

  // constructor:---------------------------------------------------------------
  _LanguageStore(Repository repository) : this._repository = repository {
    init();
  }

  // store variables:-----------------------------------------------------------
  @observable
  Locale _locale = S.delegate.supportedLocales.first;

  @computed
  Locale get locale => _locale;

  @computed
  String get languageCode => _locale.languageCode;

  @computed
  String? get countryCode => _locale.countryCode;

  List<Locale> get supportedLocales => S.delegate.supportedLocales;

  // actions:-------------------------------------------------------------------
  @action
  void changeLanguage(Locale locale) {
    _repository.prefLanguage.set(locale.languageCode).then((_) {
      _locale = locale;
    });
  }

  // general:-------------------------------------------------------------------
  void init() async {
    // getting current language from shared preference
    if (_repository.prefLanguage.value != null) {
      _locale = S.delegate.supportedLocales.firstWhere(
          (loc) => loc.languageCode == _repository.prefLanguage.value);
    }
  }

  String localeNameByLanguageCode(String languageCode) {
    switch (languageCode) {
      case "en":
        return "English";
      case "tr":
        return "Türkçe";
      default:
        throw new Exception("Undefined language");
    }
  }
}
