import 'package:goresy/constants/constants.dart';
import 'package:goresy/router/app_router.dart';
import 'package:goresy/stores/language_store.dart';
import 'package:goresy/stores/theme_store.dart';
import 'package:goresy/stores/auth_store.dart';
import 'package:goresy/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'package:settings_ui/settings_ui.dart';

class ApplicationSettingsScreen extends StatefulWidget {
  const ApplicationSettingsScreen({super.key});

  @override
  State<ApplicationSettingsScreen> createState() =>
      ApplicationSettingsScreenState();
}

class ApplicationSettingsScreenState extends State<ApplicationSettingsScreen> {
  final LanguageStore _languageStore = getIt<LanguageStore>();
  final ThemeStore _themeStore = getIt<ThemeStore>();
  final AuthStore _userStore = getIt<AuthStore>();

  String? version;
  String? buildNumber;

  @override
  void initState() {
    PackageInfo.fromPlatform().then(
      (packageInfo) => setState(() {
        version = packageInfo.version;
        buildNumber = packageInfo.buildNumber;
      }),
    );

    super.initState();
  }

  SettingsTile _buildLanguageSettingTile(BuildContext context) {
    return SettingsTile(
      leading: Icon(Icons.language),
      title: Text(S.of(context).settingsLanguage),
      value: Text(_languageStore
          .localeNameByLanguageCode(_languageStore.locale.languageCode)),
      onPressed: (context) => showLanguageDialog(context, _languageStore),
    );
  }

  static Future<Locale?> showLanguageDialog(
      BuildContext context, LanguageStore languageStore) {
    return SelectionDialog.show<Locale>(
      context: context,
      title: S.of(context).settingsChooseField(S.of(context).settingsLanguage),
      itemLabelBuilder: (item) =>
          languageStore.localeNameByLanguageCode(item.languageCode),
      selectedItem: languageStore.locale,
      items: S.delegate.supportedLocales.map((loc) => loc),
      onSubmit: languageStore.changeLanguage,
    );
  }

  Map<int, String> _themeOptionsOf(BuildContext context) {
    return <int, String>{
      1: S.of(context).settingsTheme + " 1",
      2: S.of(context).settingsTheme + " 2",
    };
  }

  SettingsTile _buildThemeSettingTile(BuildContext context) {
    return SettingsTile(
      leading: Icon(Icons.color_lens_outlined),
      title: Text(S.of(context).settingsTheme),
      value: Observer(builder: (_) {
        return Text(_themeOptionsOf(context)[_themeStore.themeNo] ?? "-");
      }),
      onPressed: _showThemeDialog,
    );
  }

  _showThemeDialog(BuildContext context) {
    final options = _themeOptionsOf(context).entries.toList();
    final selectedItem =
        options.firstWhere((entry) => entry.key == _themeStore.themeNo);

    SelectionDialog.show<MapEntry<int, String>>(
      context: context,
      title: S.of(context).settingsChooseField(S.of(context).settingsTheme),
      itemLabelBuilder: (item) => item.value,
      items: options,
      selectedItem: selectedItem,
      onSubmit: (entry) => _themeStore.changeThemeNo(entry.key),
    );
  }

  Map<bool?, String> _appearanceOptionsOf(BuildContext context) {
    return <bool?, String>{
      null: S.of(context).settingsSystemDefault,
      true: S.of(context).settingsDark,
      false: S.of(context).settingsLight,
    };
  }

  SettingsTile _buildAppearanceSettingTile(BuildContext context) {
    return SettingsTile(
      leading: Icon(Icons.dark_mode_outlined),
      title: Text(S.of(context).settingsAppearance),
      value: Text(_appearanceOptionsOf(context)[_themeStore.darkMode] ?? "-"),
      onPressed: _showAppearanceDialog,
    );
  }

  _showAppearanceDialog(BuildContext context) {
    final options = _appearanceOptionsOf(context).entries.toList();
    final selectedItem =
        options.firstWhere((entry) => entry.key == _themeStore.darkMode);

    SelectionDialog.show<MapEntry<bool?, String>>(
      context: context,
      title:
          S.of(context).settingsChooseField(S.of(context).settingsAppearance),
      itemLabelBuilder: (item) => item.value,
      items: options,
      selectedItem: selectedItem,
      onSubmit: (mode) => _themeStore.toggleDarkMode(mode.key),
    );
  }

  SettingsTile _buildAppMenuDirectionSettingTile(BuildContext context) {
    return SettingsTile(
      leading: Icon(Icons.multiple_stop_rounded),
      title: Text(S.of(context).settingsApplicationMenuDirection),
      value: Observer(builder: (_) {
        return Text(
          _themeStore.menuSideIsLeft
              ? S.of(context).settingsLeftToRight
              : S.of(context).settingsRightToLeft,
        );
      }),
      onPressed: _showAppMenuDirectionDialog,
    );
  }

  _showAppMenuDirectionDialog(BuildContext context) {
    SelectionDialog.show<bool>(
      context: context,
      title: S
          .of(context)
          .settingsChooseField(S.of(context).settingsApplicationMenuDirection),
      itemLabelBuilder: (item) => item == true
          ? S.of(context).settingsLeftToRight
          : S.of(context).settingsRightToLeft,
      items: [true, false],
      selectedItem: _themeStore.menuSideIsLeft,
      onSubmit: _themeStore.changeMenuSideIsLeft,
    );
  }

  static Future<bool> logout(BuildContext context, AuthStore store) {
    return store.onClickSignOut().then((value) {
      if (value) {
        context.clearHistory();
        context.go(AppRouter.initialLocationWithoutSession,
            addToHistory: false);
      }
      return value;
    });
  }

  SettingsTile _buildVersionNumberSettingsTile(BuildContext context) {
    return SettingsTile(
      leading: Icon(Icons.file_download_outlined),
      title: Text("Version"),
      value: Text(
        "${version} (${buildNumber})",
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final defaultThemeData = SettingsThemeData(
      settingsListBackground: theme.scaffoldBackgroundColor,
      titleTextColor: theme.primaryColor,
      tileHighlightColor: theme.highlightColor,
      settingsSectionBackground: theme.cardColor,
      leadingIconsColor: theme.hintColor,
    );

    return SettingsList(
      platform: DevicePlatform.macOS,
      lightTheme: defaultThemeData,
      darkTheme: defaultThemeData,
      sections: [
        SettingsSection(
          title: Text(S.of(context).settingsGeneralSettings),
          tiles: <SettingsTile>[
            _buildLanguageSettingTile(context),
            _buildThemeSettingTile(context),
            _buildAppearanceSettingTile(context),
            _buildAppMenuDirectionSettingTile(context),
          ],
        ),
        SettingsSection(
          tiles: <SettingsTile>[
            _buildVersionNumberSettingsTile(context),
            SettingsTile(
              leading: Icon(Icons.power_settings_new_rounded),
              title: Text(S.of(context).settingsLogout),
              onPressed: (context) => logout(context, _userStore),
            )
          ],
        ),
      ],
    );
  }
}
