import 'dart:async';

import 'package:goresy/data/app_shared_preferences.dart';
import 'package:goresy/utils/logger.dart';

import 'network/apis/auth_api.dart';

class Repository {
  // api objects
  final AuthApi _authApi;

  // shared pref object
  final AppSharedPreferences _sharedPreferences;

  // constructor
  Repository(
    this._authApi,
    this._sharedPreferences,
  );

  Future<bool> refreshSession() async {
    try {
      //var response = await _authApi.getSessionDetail();

      //await _sharedPreferences.userNameSurname.set(response.userName);

      return true;
    } catch (e, stackTrace) {
      Log.e(e.toString(), stackTrace: stackTrace);
      throw e;
    }
  }

  Future<bool> login(String username, String password) async {
    try {
      var response = await _authApi.login(username, password);

      await _sharedPreferences.accessToken.set(response.accessToken);
      await _sharedPreferences.tokenExpiresIn.set(response.expiresIn);
      await _sharedPreferences.refreshToken.set(response.refreshToken);
      await _sharedPreferences.lastLoggedInUsername.set(username);

      return true;
    } catch (e, stackTrace) {
      Log.e(e.toString(), stackTrace: stackTrace);
      throw e;
    }
  }

  Future logout() async {
    try {
      await _sharedPreferences.accessToken.reset();
      await _sharedPreferences.tokenExpiresIn.reset();
      await _sharedPreferences.refreshToken.reset();

      return true;
    } catch (e, stackTrace) {
      Log.e(e, stackTrace: stackTrace);
      return false;
    }
  }

  // SharedPrefs
  String? get accessToken => _sharedPreferences.accessToken.value;
  String? get lastLoggedInUsername =>
      _sharedPreferences.lastLoggedInUsername.value;

  SharedPreferenceField<String?> get prefFcmToken =>
      _sharedPreferences.fcmToken;

  SharedPreferenceField<bool?> get prefDarkMode =>
      _sharedPreferences.preferedDarkMode;
  SharedPreferenceField<bool> get prefMenuSideIsLeft =>
      _sharedPreferences.menuSideIsLeft;
  SharedPreferenceField<int> get prefThemeNo => _sharedPreferences.themeNo;

  SharedPreferenceField<String?> get prefLanguage =>
      _sharedPreferences.preferedLanguage;
}
