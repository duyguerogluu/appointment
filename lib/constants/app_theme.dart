import 'package:goresy/constants/constants.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppThemeData {
  static final List<ThemeData> lightThemes = [
    _initializeThemeData(Brightness.light, lightColorScheme1),
    _initializeThemeData(Brightness.light, lightColorScheme2),
  ];
  static final List<ThemeData> darkThemes = [
    _initializeThemeData(Brightness.dark, darkColorScheme1),
    _initializeThemeData(Brightness.dark, darkColorScheme2),
  ];

  static ThemeData _initializeThemeData(
      Brightness brightness, ColorScheme colorScheme,
      [bool smallInputs = true]) {
    late final ThemeData themeData;
    if (brightness == Brightness.light) {
      themeData = FlexThemeData.light(
        colorScheme: colorScheme,
        usedColors: 7,
        surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
        blendLevel: 4,
        appBarStyle: FlexAppBarStyle.primary,
        bottomAppBarElevation: 1.0,
        subThemesData: const FlexSubThemesData(
          blendOnLevel: 10,
          blendOnColors: false,
          blendTextTheme: true,
          useTextTheme: true,
          thickBorderWidth: 2.0,
          elevatedButtonSchemeColor: SchemeColor.onPrimaryContainer,
          elevatedButtonSecondarySchemeColor: SchemeColor.primaryContainer,
          inputDecoratorSchemeColor: SchemeColor.primary,
          inputDecoratorBackgroundAlpha: 24,
          inputDecoratorRadius: 8.0,
          inputDecoratorUnfocusedHasBorder: false,
          inputDecoratorFocusedHasBorder: false,
          inputDecoratorPrefixIconSchemeColor: SchemeColor.primary,
          drawerElevation: 0,
          drawerWidth: 290.0,
          drawerRadius: 0,
          bottomNavigationBarSelectedLabelSchemeColor: SchemeColor.secondary,
          bottomNavigationBarMutedUnselectedLabel: false,
          bottomNavigationBarSelectedIconSchemeColor: SchemeColor.secondary,
          bottomNavigationBarMutedUnselectedIcon: false,
          navigationBarSelectedLabelSchemeColor:
              SchemeColor.onSecondaryContainer,
          navigationBarSelectedIconSchemeColor:
              SchemeColor.onSecondaryContainer,
          navigationBarIndicatorSchemeColor: SchemeColor.secondaryContainer,
          navigationBarIndicatorOpacity: 1.00,
          navigationBarElevation: 0,
          navigationBarHeight: 72.0,
          navigationRailSelectedLabelSchemeColor:
              SchemeColor.onSecondaryContainer,
          navigationRailSelectedIconSchemeColor:
              SchemeColor.onSecondaryContainer,
          navigationRailIndicatorSchemeColor: SchemeColor.secondaryContainer,
          navigationRailIndicatorOpacity: 1.00,
        ),
        useMaterial3ErrorColors: true,
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
        fontFamily: GoogleFonts.notoSans().fontFamily,
      );
    } else {
      themeData = FlexThemeData.dark(
        colorScheme: colorScheme,
        usedColors: 7,
        surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
        blendLevel: 10,
        appBarStyle: FlexAppBarStyle.surface,
        bottomAppBarElevation: 2.0,
        subThemesData: const FlexSubThemesData(
          blendOnLevel: 20,
          blendTextTheme: true,
          useTextTheme: true,
          thickBorderWidth: 2.0,
          elevatedButtonSchemeColor: SchemeColor.onPrimaryContainer,
          elevatedButtonSecondarySchemeColor: SchemeColor.primaryContainer,
          inputDecoratorSchemeColor: SchemeColor.primary,
          inputDecoratorBackgroundAlpha: 48,
          inputDecoratorRadius: 8.0,
          inputDecoratorUnfocusedHasBorder: false,
          inputDecoratorFocusedHasBorder: false,
          inputDecoratorPrefixIconSchemeColor: SchemeColor.primary,
          drawerElevation: 0,
          drawerWidth: 290.0,
          drawerRadius: 0,
          bottomNavigationBarSelectedLabelSchemeColor: SchemeColor.secondary,
          bottomNavigationBarMutedUnselectedLabel: false,
          bottomNavigationBarSelectedIconSchemeColor: SchemeColor.secondary,
          bottomNavigationBarMutedUnselectedIcon: false,
          navigationBarSelectedLabelSchemeColor:
              SchemeColor.onSecondaryContainer,
          navigationBarSelectedIconSchemeColor:
              SchemeColor.onSecondaryContainer,
          navigationBarIndicatorSchemeColor: SchemeColor.secondaryContainer,
          navigationBarIndicatorOpacity: 1.00,
          navigationBarElevation: 0,
          navigationBarHeight: 72.0,
          navigationRailSelectedLabelSchemeColor:
              SchemeColor.onSecondaryContainer,
          navigationRailSelectedIconSchemeColor:
              SchemeColor.onSecondaryContainer,
          navigationRailIndicatorSchemeColor: SchemeColor.secondaryContainer,
          navigationRailIndicatorOpacity: 1.00,
        ),
        useMaterial3ErrorColors: true,
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
        fontFamily: GoogleFonts.notoSans().fontFamily,
      );
    }

    return themeData.copyWith(
        dialogTheme: themeData.dialogTheme.copyWith(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          titleTextStyle: TextStyle(
            fontSize: 16,
            color: colorScheme.onBackground,
            overflow: TextOverflow.ellipsis,
            fontFamily: GoogleFonts.notoSans().fontFamily,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: themeData.elevatedButtonTheme.style!.copyWith(
            iconSize: MaterialStatePropertyAll(20),
            padding: MaterialStatePropertyAll(EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 16,
            )),
          ),
        ),
        drawerTheme: themeData.drawerTheme.copyWith(
          width: Dimens.drawerWidth,
        ),
        appBarTheme: themeData.appBarTheme.copyWith(
          elevation: 2,
        ),
        inputDecorationTheme: themeData.inputDecorationTheme.copyWith(
          contentPadding: smallInputs
              ? EdgeInsets.symmetric(
                  vertical: 14,
                  horizontal: themeData
                          .inputDecorationTheme.contentPadding?.horizontal ??
                      12,
                )
              : themeData.inputDecorationTheme.contentPadding,
        ));
  }

  static OutlineInputBorder _defaultInputBorder(ThemeData themeData,
      [Color? color]) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(
        width: 0.5,
        color: color ??
            themeData.inputDecorationTheme.enabledBorder?.borderSide.color ??
            themeData.dividerColor,
      ),
    );
  }

  static const ColorScheme lightColorScheme1 = ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xff9c27b0),
    onPrimary: Color(0xffffffff),
    primaryContainer: Color(0xffe9bff1),
    onPrimaryContainer: Color(0xff0f0d10),
    secondary: Color(0xffffd74e),
    onSecondary: Color(0xff000000),
    secondaryContainer: Color(0xfffffcb8),
    onSecondaryContainer: Color(0xff10100c),
    tertiary: Color(0xffc24dd6),
    onTertiary: Color(0xffffffff),
    tertiaryContainer: Color(0xfff1d9f6),
    onTertiaryContainer: Color(0xff100e10),
    error: Color(0xffb00020),
    onError: Color(0xffffffff),
    errorContainer: Color(0xfffcd8df),
    onErrorContainer: Color(0xff100e0f),
    background: Color(0xfffefefe),
    onBackground: Color(0xff070707),
    surface: Color(0xffffffff),
    onSurface: Color(0xff040404),
    surfaceVariant: Color(0xffeeeeee),
    onSurfaceVariant: Color(0xff070707),
    outline: Color(0xff7a7a7a),
    outlineVariant: Color(0xffc6c6c6),
    shadow: Color(0xff000000),
    scrim: Color(0xff000000),
    inverseSurface: Color(0xff111111),
    onInverseSurface: Color(0xfffbfbfb),
    inversePrimary: Color(0xffffc0ff),
    surfaceTint: Color(0xff9c27b0),
  );

  static const ColorScheme darkColorScheme1 = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xff9c27b0),
    onPrimary: Color(0xfffdf8fd),
    primaryContainer: Color(0xff3d0f45),
    onPrimaryContainer: Color(0xfff4f0f4),
    secondary: Color(0xffffd74e),
    onSecondary: Color(0xff0a0a05),
    secondaryContainer: Color(0xff674f00),
    onSecondaryContainer: Color(0xfff7f5ef),
    tertiary: Color(0xffc24dd6),
    onTertiary: Color(0xfffefaff),
    tertiaryContainer: Color(0xff5f186c),
    onTertiaryContainer: Color(0xfff6f1f7),
    error: Color(0xffcf6679),
    onError: Color(0xff0a0606),
    errorContainer: Color(0xffb1384e),
    onErrorContainer: Color(0xfffdf3f5),
    background: Color(0xff121112),
    onBackground: Color(0xfff5f5f5),
    surface: Color(0xff111111),
    onSurface: Color(0xfffafafa),
    surfaceVariant: Color(0xff323132),
    onSurfaceVariant: Color(0xfff6f6f6),
    outline: Color(0xff828282),
    outlineVariant: Color(0xff363636),
    shadow: Color(0xff000000),
    scrim: Color(0xff000000),
    inverseSurface: Color(0xfffefefe),
    onInverseSurface: Color(0xff040404),
    inversePrimary: Color(0xff4d1f55),
    surfaceTint: Color(0xff9c27b0),
  );

  static const ColorScheme lightColorScheme2 = ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xffffd74e),
    onPrimary: Color(0xff000000),
    primaryContainer: Color(0xfffff8e1),
    onPrimaryContainer: Color(0xff10100f),
    secondary: Color(0xff9c27b0),
    onSecondary: Color(0xffffffff),
    secondaryContainer: Color(0xffdfa4e9),
    onSecondaryContainer: Color(0xff0f0b0f),
    tertiary: Color(0xfffffd74),
    onTertiary: Color(0xff000000),
    tertiaryContainer: Color(0xfffffef0),
    onTertiaryContainer: Color(0xff101010),
    error: Color(0xffb00020),
    onError: Color(0xffffffff),
    errorContainer: Color(0xfffcd8df),
    onErrorContainer: Color(0xff100e0f),
    background: Color(0xfffffefe),
    onBackground: Color(0xff080707),
    surface: Color(0xffffffff),
    onSurface: Color(0xff040404),
    surfaceVariant: Color(0xffeeeeee),
    onSurfaceVariant: Color(0xff070707),
    outline: Color(0xff827272),
    outlineVariant: Color(0xffcbc3c3),
    shadow: Color(0xff000000),
    scrim: Color(0xff000000),
    inverseSurface: Color(0xff111111),
    onInverseSurface: Color(0xfffbfbfb),
    inversePrimary: Color(0xffffffe7),
    surfaceTint: Color(0xffffd74e),
  );

  static const ColorScheme darkColorScheme2 = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xffffd74e),
    onPrimary: Color(0xff0a0a05),
    primaryContainer: Color(0xff735e17),
    onPrimaryContainer: Color(0xfff8f6f1),
    secondary: Color(0xff9c27b0),
    onSecondary: Color(0xfffdf8fd),
    secondaryContainer: Color(0xff1f0824),
    onSecondaryContainer: Color(0xfff1f0f2),
    tertiary: Color(0xfffffd74),
    onTertiary: Color(0xff0a0a06),
    tertiaryContainer: Color(0xffb3b009),
    onTertiaryContainer: Color(0xff0f0f02),
    error: Color(0xffcf6679),
    onError: Color(0xff0a0606),
    errorContainer: Color(0xffb1384e),
    onErrorContainer: Color(0xfffdf3f5),
    background: Color(0xff121211),
    onBackground: Color(0xfff5f5f5),
    surface: Color(0xff111111),
    onSurface: Color(0xfffafafa),
    surfaceVariant: Color(0xff333332),
    onSurfaceVariant: Color(0xfff7f7f6),
    outline: Color(0xff828282),
    outlineVariant: Color(0xff363636),
    shadow: Color(0xff000000),
    scrim: Color(0xff000000),
    inverseSurface: Color(0xfffffefe),
    onInverseSurface: Color(0xff050404),
    inversePrimary: Color(0xff70652e),
    surfaceTint: Color(0xffffd74e),
  );

  /*static const _regular = FontWeight.w400;
  static const _medium = FontWeight.w500;
  static const _semiBold = FontWeight.w600;
  static const _bold = FontWeight.w700;

  static final TextTheme _textTheme = TextTheme(
    caption: GoogleFonts.oswald(fontWeight: _semiBold, fontSize: 16.0),
    //
    headline6: GoogleFonts.montserrat(fontWeight: _bold, fontSize: 16.0),
    headline5: GoogleFonts.oswald(fontWeight: _medium, fontSize: 16.0),
    headline4: GoogleFonts.montserrat(fontWeight: _bold, fontSize: 20.0),
    //
    overline: GoogleFonts.montserrat(fontWeight: _medium, fontSize: 12.0),
    //
    subtitle1: GoogleFonts.montserrat(fontWeight: _medium, fontSize: 16.0),
    subtitle2: GoogleFonts.montserrat(fontWeight: _medium, fontSize: 14.0),
    //
    bodyText2: GoogleFonts.montserrat(fontWeight: _regular, fontSize: 16.0),
    bodyText1: GoogleFonts.montserrat(fontWeight: _regular, fontSize: 14.0),
    //
    button: GoogleFonts.montserrat(fontWeight: _semiBold, fontSize: 14.0),
  );*/

  static BoxShadow elevation1BoxShadowOf(BuildContext context) => BoxShadow(
        color: Theme.of(context).shadowColor.withOpacity(0.18),
        blurRadius: 1.0,
        offset: Offset(0, 1),
      );

  static BoxShadow elevation2BoxShadowOf(BuildContext context) => BoxShadow(
        color: Theme.of(context).shadowColor.withOpacity(0.2),
        blurRadius: 1.41,
        offset: Offset(0, 1.4),
      );

  static BoxShadow elevation3BoxShadowOf(BuildContext context) => BoxShadow(
        color: Theme.of(context).shadowColor.withOpacity(0.22),
        blurRadius: 2.22,
        offset: Offset(0, 1.8),
      );

  static BoxShadow elevation4BoxShadowOf(BuildContext context) => BoxShadow(
        color: Theme.of(context).shadowColor.withOpacity(0.23),
        blurRadius: 2.62,
        offset: Offset(0, 2.2),
      );

  static BoxShadow elevation5BoxShadowOf(BuildContext context) => BoxShadow(
        color: Theme.of(context).shadowColor.withOpacity(0.25),
        blurRadius: 3.84,
        offset: Offset(0, 2.6),
      );

  static BoxShadow elevation6BoxShadowOf(BuildContext context) => BoxShadow(
        color: Theme.of(context).shadowColor.withOpacity(0.27),
        blurRadius: 4.65,
        offset: Offset(0, 3),
      );
}
