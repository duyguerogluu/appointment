import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

const String current_language = "";

class AppSharedPreferences {
  // shared pref instance
  final SharedPreferences _sp;

  // constructor
  AppSharedPreferences(this._sp);

  // Session
  late final lastLoggedInUsername =
      SharedPreferenceField<String?>(_sp, "lastLoggedInUsername", null);
  late final accessToken =
      SharedPreferenceField<String?>(_sp, "accessToken", null);
  late final refreshToken =
      SharedPreferenceField<String?>(_sp, "refreshToken", null);
  late final tokenExpiresIn =
      SharedPreferenceField<int?>(_sp, "tokenExpiresIn", null);

  late final fcmToken = SharedPreferenceField<String?>(_sp, "fcmToken", null);

  // Theme
  late final preferedDarkMode =
      SharedPreferenceField<bool?>(_sp, "preferedDarkMode", null);
  late final menuSideIsLeft =
      SharedPreferenceField<bool>(_sp, "menuSideIsLeft", true);
  late final themeNo = SharedPreferenceField<int>(_sp, "themeIndex", 1);

  late final preferedLanguage =
      SharedPreferenceField<String?>(_sp, "preferedLanguage", null);
}

class SharedPreferenceField<T> {
  final SharedPreferences sharedPreferences;
  final String key;
  final T defaultValue;

  SharedPreferenceField(this.sharedPreferences, this.key, this.defaultValue);

  bool get isNullable => null is T;

  T get value => _getValue();
  Future<bool> set(T val) => _setValue(val);
  Future<bool> reset() => sharedPreferences.remove(key);

  T _getValue() {
    if (!sharedPreferences.containsKey(key)) return defaultValue;
    return sharedPreferences.get(key) as T;
  }

  Future<bool> _setValue(T val) {
    switch (val!.runtimeType) {
      case bool:
        return sharedPreferences.setBool(key, val as bool);
      case int:
        return sharedPreferences.setInt(key, val as int);
      case double:
        return sharedPreferences.setDouble(key, val as double);
      case String:
        return sharedPreferences.setString(key, val as String);
      case List<String>:
        return sharedPreferences.setStringList(key, val as List<String>);
      default:
        return sharedPreferences.setString(key, val.toString());
    }
  }
}
