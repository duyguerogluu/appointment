// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ThemeStore on _ThemeStore, Store {
  Computed<int>? _$themeNoComputed;

  @override
  int get themeNo => (_$themeNoComputed ??=
          Computed<int>(() => super.themeNo, name: '_ThemeStore.themeNo'))
      .value;
  Computed<ThemeData>? _$lightThemeDataComputed;

  @override
  ThemeData get lightThemeData => (_$lightThemeDataComputed ??=
          Computed<ThemeData>(() => super.lightThemeData,
              name: '_ThemeStore.lightThemeData'))
      .value;
  Computed<ThemeData>? _$darkThemeDataComputed;

  @override
  ThemeData get darkThemeData => (_$darkThemeDataComputed ??=
          Computed<ThemeData>(() => super.darkThemeData,
              name: '_ThemeStore.darkThemeData'))
      .value;
  Computed<bool?>? _$darkModeComputed;

  @override
  bool? get darkMode => (_$darkModeComputed ??=
          Computed<bool?>(() => super.darkMode, name: '_ThemeStore.darkMode'))
      .value;
  Computed<bool>? _$menuSideIsLeftComputed;

  @override
  bool get menuSideIsLeft =>
      (_$menuSideIsLeftComputed ??= Computed<bool>(() => super.menuSideIsLeft,
              name: '_ThemeStore.menuSideIsLeft'))
          .value;

  late final _$_themeNoAtom =
      Atom(name: '_ThemeStore._themeNo', context: context);

  @override
  int get _themeNo {
    _$_themeNoAtom.reportRead();
    return super._themeNo;
  }

  @override
  set _themeNo(int value) {
    _$_themeNoAtom.reportWrite(value, super._themeNo, () {
      super._themeNo = value;
    });
  }

  late final _$_darkModeAtom =
      Atom(name: '_ThemeStore._darkMode', context: context);

  @override
  bool? get _darkMode {
    _$_darkModeAtom.reportRead();
    return super._darkMode;
  }

  @override
  set _darkMode(bool? value) {
    _$_darkModeAtom.reportWrite(value, super._darkMode, () {
      super._darkMode = value;
    });
  }

  late final _$_menuSideIsLeftAtom =
      Atom(name: '_ThemeStore._menuSideIsLeft', context: context);

  @override
  bool get _menuSideIsLeft {
    _$_menuSideIsLeftAtom.reportRead();
    return super._menuSideIsLeft;
  }

  @override
  set _menuSideIsLeft(bool value) {
    _$_menuSideIsLeftAtom.reportWrite(value, super._menuSideIsLeft, () {
      super._menuSideIsLeft = value;
    });
  }

  late final _$_ThemeStoreActionController =
      ActionController(name: '_ThemeStore', context: context);

  @override
  Future<bool> toggleDarkMode(bool? value) {
    final _$actionInfo = _$_ThemeStoreActionController.startAction(
        name: '_ThemeStore.toggleDarkMode');
    try {
      return super.toggleDarkMode(value);
    } finally {
      _$_ThemeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  Future<bool> changeMenuSideIsLeft(bool value) {
    final _$actionInfo = _$_ThemeStoreActionController.startAction(
        name: '_ThemeStore.changeMenuSideIsLeft');
    try {
      return super.changeMenuSideIsLeft(value);
    } finally {
      _$_ThemeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  Future<bool> changeThemeNo(int no) {
    final _$actionInfo = _$_ThemeStoreActionController.startAction(
        name: '_ThemeStore.changeThemeNo');
    try {
      return super.changeThemeNo(no);
    } finally {
      _$_ThemeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
themeNo: ${themeNo},
lightThemeData: ${lightThemeData},
darkThemeData: ${darkThemeData},
darkMode: ${darkMode},
menuSideIsLeft: ${menuSideIsLeft}
    ''';
  }
}
