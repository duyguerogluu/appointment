import 'package:goresy/constants/app_theme.dart';
import 'package:goresy/data/repository.dart';
import 'package:goresy/utils/extensions/future_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

export 'package:goresy/dependency-injections/components/service_locator.dart';

part 'theme_store.g.dart';

class ThemeStore = _ThemeStore with _$ThemeStore;

abstract class _ThemeStore with Store {
  // repository instance
  final Repository _repository;

  // store variables:-----------------------------------------------------------

  @observable
  int _themeNo = 1;

  @computed
  int get themeNo => _themeNo;

  @computed
  ThemeData get lightThemeData =>
      _themeNo > 0 && _themeNo - 1 < AppThemeData.lightThemes.length
          ? AppThemeData.lightThemes[_themeNo - 1]
          : AppThemeData.lightThemes.first;

  @computed
  ThemeData get darkThemeData =>
      _themeNo > 0 && _themeNo - 1 < AppThemeData.darkThemes.length
          ? AppThemeData.darkThemes[_themeNo - 1]
          : AppThemeData.darkThemes.first;

  @observable
  bool? _darkMode;

  @observable
  bool _menuSideIsLeft = true;

  @computed
  bool? get darkMode => _darkMode;

  @computed
  bool get menuSideIsLeft => _menuSideIsLeft;

  // constructor:---------------------------------------------------------------
  _ThemeStore(Repository repository) : this._repository = repository {
    init();
  }

  // actions:-------------------------------------------------------------------
  @action
  Future<bool> toggleDarkMode(final bool? value) {
    return (value == null
            ? _repository.prefDarkMode.reset()
            : _repository.prefDarkMode.set(value))
        .then((res) {
      _darkMode = value;
      return res;
    });
  }

  @action
  Future<bool> changeMenuSideIsLeft(bool value) {
    return _repository.prefMenuSideIsLeft.set(value).then((res) {
      _menuSideIsLeft = value;
      return res;
    });
  }

  @action
  Future<bool> changeThemeNo(int no) {
    return _repository.prefThemeNo.set(no).then((res) {
      _themeNo = no;
      return res;
    });
  }

  // general methods:-----------------------------------------------------------
  Future init() async {
    _darkMode = _repository.prefDarkMode.value;
    _menuSideIsLeft = _repository.prefMenuSideIsLeft.value;
    _themeNo = _repository.prefThemeNo.value;
  }

  bool get _isPlatformDark =>
      SchedulerBinding.instance.platformDispatcher.platformBrightness ==
      Brightness.dark;

  bool get computedDarkMode => _darkMode ?? _isPlatformDark;
}
