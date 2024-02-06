// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Uygun`
  String get available {
    return Intl.message(
      'Uygun',
      name: 'available',
      desc: '',
      args: [],
    );
  }

  /// `Uygun Değil`
  String get notAvailable {
    return Intl.message(
      'Uygun Değil',
      name: 'notAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Kaydet`
  String get formSave {
    return Intl.message(
      'Kaydet',
      name: 'formSave',
      desc: '',
      args: [],
    );
  }

  /// `Düzenle`
  String get formEdit {
    return Intl.message(
      'Düzenle',
      name: 'formEdit',
      desc: '',
      args: [],
    );
  }

  /// `İptal`
  String get formCancel {
    return Intl.message(
      'İptal',
      name: 'formCancel',
      desc: '',
      args: [],
    );
  }

  /// `Yeni {item} Oluştur`
  String formCreateNewX(Object item) {
    return Intl.message(
      'Yeni $item Oluştur',
      name: 'formCreateNewX',
      desc: '',
      args: [item],
    );
  }

  /// `Seç`
  String get select {
    return Intl.message(
      'Seç',
      name: 'select',
      desc: '',
      args: [],
    );
  }

  /// `Görüntüle`
  String get view {
    return Intl.message(
      'Görüntüle',
      name: 'view',
      desc: '',
      args: [],
    );
  }

  /// `Düzenle`
  String get edit {
    return Intl.message(
      'Düzenle',
      name: 'edit',
      desc: '',
      args: [],
    );
  }

  /// `Sil`
  String get delete {
    return Intl.message(
      'Sil',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Ara`
  String get search {
    return Intl.message(
      'Ara',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Yenile`
  String get refresh {
    return Intl.message(
      'Yenile',
      name: 'refresh',
      desc: '',
      args: [],
    );
  }

  /// `Yeniden Yükle`
  String get reload {
    return Intl.message(
      'Yeniden Yükle',
      name: 'reload',
      desc: '',
      args: [],
    );
  }

  /// `Yükle`
  String get load_ {
    return Intl.message(
      'Yükle',
      name: 'load_',
      desc: '',
      args: [],
    );
  }

  /// `Galeriden resim seçmek için tıklayınız`
  String get clickHereForSelectAnImage {
    return Intl.message(
      'Galeriden resim seçmek için tıklayınız',
      name: 'clickHereForSelectAnImage',
      desc: '',
      args: [],
    );
  }

  /// `Bu alan`
  String get thisField {
    return Intl.message(
      'Bu alan',
      name: 'thisField',
      desc: '',
      args: [],
    );
  }

  /// `Bir şeyler ters gitti`
  String get customErrorSomethingWentWrong {
    return Intl.message(
      'Bir şeyler ters gitti',
      name: 'customErrorSomethingWentWrong',
      desc: '',
      args: [],
    );
  }

  /// `Sonuç bulunamadı`
  String get customErrorNoResultsFound {
    return Intl.message(
      'Sonuç bulunamadı',
      name: 'customErrorNoResultsFound',
      desc: '',
      args: [],
    );
  }

  /// `Yetkisiz erişim`
  String get customErrorUnauthorizedAccess {
    return Intl.message(
      'Yetkisiz erişim',
      name: 'customErrorUnauthorizedAccess',
      desc: '',
      args: [],
    );
  }

  /// `Tamam`
  String get dialogConfirm {
    return Intl.message(
      'Tamam',
      name: 'dialogConfirm',
      desc: '',
      args: [],
    );
  }

  /// `Evet`
  String get dialogYes {
    return Intl.message(
      'Evet',
      name: 'dialogYes',
      desc: '',
      args: [],
    );
  }

  /// `İptal`
  String get dialogCancel {
    return Intl.message(
      'İptal',
      name: 'dialogCancel',
      desc: '',
      args: [],
    );
  }

  /// `Uygulamayı kapatmak istediğinize emin misiniz?`
  String get areYouSureYouWantToExit {
    return Intl.message(
      'Uygulamayı kapatmak istediğinize emin misiniz?',
      name: 'areYouSureYouWantToExit',
      desc: '',
      args: [],
    );
  }

  /// `Bunu zaten eklediniz`
  String get youHaveAlreadyAddedThis {
    return Intl.message(
      'Bunu zaten eklediniz',
      name: 'youHaveAlreadyAddedThis',
      desc: '',
      args: [],
    );
  }

  /// `Değerlendirme`
  String get rating {
    return Intl.message(
      'Değerlendirme',
      name: 'rating',
      desc: '',
      args: [],
    );
  }

  // skipped getter for the '\$_DRAWER_LAYOUT_\$' key

  /// `Partnerler`
  String get drawerItemPartners {
    return Intl.message(
      'Partnerler',
      name: 'drawerItemPartners',
      desc: '',
      args: [],
    );
  }

  /// `Profilim`
  String get drawerItemMyProfile {
    return Intl.message(
      'Profilim',
      name: 'drawerItemMyProfile',
      desc: '',
      args: [],
    );
  }

  /// `Uygulama Ayarları`
  String get drawerItemApplicationSettings {
    return Intl.message(
      'Uygulama Ayarları',
      name: 'drawerItemApplicationSettings',
      desc: '',
      args: [],
    );
  }

  // skipped getter for the '\$_VALIDATOR_\$' key

  /// `{field} boş olamaz`
  String validatorFieldCanNotBeEmpty(Object field) {
    return Intl.message(
      '$field boş olamaz',
      name: 'validatorFieldCanNotBeEmpty',
      desc: '',
      args: [field],
    );
  }

  /// `{field} kabul edilmelidir`
  String validatorFieldShouldBeAccepted(Object field) {
    return Intl.message(
      '$field kabul edilmelidir',
      name: 'validatorFieldShouldBeAccepted',
      desc: '',
      args: [field],
    );
  }

  /// `{field} ile {otherField} birbirinden farklı olmalıdır`
  String validatorTheFieldAndTheOtherFieldMustBeDifferent(
      Object field, Object otherField) {
    return Intl.message(
      '$field ile $otherField birbirinden farklı olmalıdır',
      name: 'validatorTheFieldAndTheOtherFieldMustBeDifferent',
      desc: '',
      args: [field, otherField],
    );
  }

  /// `{field} zorunludur`
  String validatorFieldRequired(Object field) {
    return Intl.message(
      '$field zorunludur',
      name: 'validatorFieldRequired',
      desc: '',
      args: [field],
    );
  }

  /// `{field} en az {length} karakter uzunluğunda olmalıdır`
  String validatorFieldMustBeLength(Object field, Object length) {
    return Intl.message(
      '$field en az $length karakter uzunluğunda olmalıdır',
      name: 'validatorFieldMustBeLength',
      desc: '',
      args: [field, length],
    );
  }

  /// `{fields} eşleşmiyor`
  String validatorFieldsDontMatch(Object fields) {
    return Intl.message(
      '$fields eşleşmiyor',
      name: 'validatorFieldsDontMatch',
      desc: '',
      args: [fields],
    );
  }

  /// `E-posta adresi formatı geçersiz`
  String get validatorEmailAddressFormatIsInvalid {
    return Intl.message(
      'E-posta adresi formatı geçersiz',
      name: 'validatorEmailAddressFormatIsInvalid',
      desc: '',
      args: [],
    );
  }

  /// `Cep telefonu numarası geçersiz`
  String get validatorMobileNumberIsInvalid {
    return Intl.message(
      'Cep telefonu numarası geçersiz',
      name: 'validatorMobileNumberIsInvalid',
      desc: '',
      args: [],
    );
  }

  // skipped getter for the '\$_LOGIN_FORM_\$' key

  /// `Kullanıcı Adı`
  String get loginFormUsername {
    return Intl.message(
      'Kullanıcı Adı',
      name: 'loginFormUsername',
      desc: '',
      args: [],
    );
  }

  /// `Şifre`
  String get loginFormPassword {
    return Intl.message(
      'Şifre',
      name: 'loginFormPassword',
      desc: '',
      args: [],
    );
  }

  /// `Şifre (Tekrar)`
  String get loginFormConfirmPassword {
    return Intl.message(
      'Şifre (Tekrar)',
      name: 'loginFormConfirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Şifrenizi mi unuttunuz?`
  String get loginFormForgotPassword {
    return Intl.message(
      'Şifrenizi mi unuttunuz?',
      name: 'loginFormForgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Giriş Yap`
  String get loginFormSignIn {
    return Intl.message(
      'Giriş Yap',
      name: 'loginFormSignIn',
      desc: '',
      args: [],
    );
  }

  /// `Lütfen tüm alanları doldurunuz`
  String get loginFormErrorFillFields {
    return Intl.message(
      'Lütfen tüm alanları doldurunuz',
      name: 'loginFormErrorFillFields',
      desc: '',
      args: [],
    );
  }

  /// `{field} boş olamaz`
  String loginFormFieldCantBeEmpty(Object field) {
    return Intl.message(
      '$field boş olamaz',
      name: 'loginFormFieldCantBeEmpty',
      desc: '',
      args: [field],
    );
  }

  /// `Şifreler uyuşmuyor`
  String get loginFormPasswordsDontMatch {
    return Intl.message(
      'Şifreler uyuşmuyor',
      name: 'loginFormPasswordsDontMatch',
      desc: '',
      args: [],
    );
  }

  /// `Kullanıcı adı ve şifre hiçbir kayıt ile eşleşmiyor`
  String get loginFormUsernamePasswordDoesntMatch {
    return Intl.message(
      'Kullanıcı adı ve şifre hiçbir kayıt ile eşleşmiyor',
      name: 'loginFormUsernamePasswordDoesntMatch',
      desc: '',
      args: [],
    );
  }

  /// `Birşeyler ters gitti, lütfen internet bağlantınızı kontrol ediniz ve tekrar deneyiniz`
  String get loginFormSomethingWrongCheckYourConnection {
    return Intl.message(
      'Birşeyler ters gitti, lütfen internet bağlantınızı kontrol ediniz ve tekrar deneyiniz',
      name: 'loginFormSomethingWrongCheckYourConnection',
      desc: '',
      args: [],
    );
  }

  /// `Şifreyi Sıfırla`
  String get loginFormResetPassword {
    return Intl.message(
      'Şifreyi Sıfırla',
      name: 'loginFormResetPassword',
      desc: '',
      args: [],
    );
  }

  /// `Size gönderilen linke tıklayarak şifre güncelleme işlemini gerçekleştirebilirsiniz.`
  String get loginFormResetPasswordScreenInformation {
    return Intl.message(
      'Size gönderilen linke tıklayarak şifre güncelleme işlemini gerçekleştirebilirsiniz.',
      name: 'loginFormResetPasswordScreenInformation',
      desc: '',
      args: [],
    );
  }

  /// `Hata`
  String get loginFormError {
    return Intl.message(
      'Hata',
      name: 'loginFormError',
      desc: '',
      args: [],
    );
  }

  // skipped getter for the '\$_SETTING_PAGE_\$' key

  /// `Genel Ayarlar`
  String get settingsGeneralSettings {
    return Intl.message(
      'Genel Ayarlar',
      name: 'settingsGeneralSettings',
      desc: '',
      args: [],
    );
  }

  /// `Dil`
  String get settingsLanguage {
    return Intl.message(
      'Dil',
      name: 'settingsLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Dış Görünüm`
  String get settingsAppearance {
    return Intl.message(
      'Dış Görünüm',
      name: 'settingsAppearance',
      desc: '',
      args: [],
    );
  }

  /// `Sistem Varsayılan`
  String get settingsSystemDefault {
    return Intl.message(
      'Sistem Varsayılan',
      name: 'settingsSystemDefault',
      desc: '',
      args: [],
    );
  }

  /// `Karanlık`
  String get settingsDark {
    return Intl.message(
      'Karanlık',
      name: 'settingsDark',
      desc: '',
      args: [],
    );
  }

  /// `Aydınlık`
  String get settingsLight {
    return Intl.message(
      'Aydınlık',
      name: 'settingsLight',
      desc: '',
      args: [],
    );
  }

  /// `Uygulama Menüsü Yönü`
  String get settingsApplicationMenuDirection {
    return Intl.message(
      'Uygulama Menüsü Yönü',
      name: 'settingsApplicationMenuDirection',
      desc: '',
      args: [],
    );
  }

  /// `Soldan Sağa`
  String get settingsLeftToRight {
    return Intl.message(
      'Soldan Sağa',
      name: 'settingsLeftToRight',
      desc: '',
      args: [],
    );
  }

  /// `Sağdan Sola`
  String get settingsRightToLeft {
    return Intl.message(
      'Sağdan Sola',
      name: 'settingsRightToLeft',
      desc: '',
      args: [],
    );
  }

  /// `Tema`
  String get settingsTheme {
    return Intl.message(
      'Tema',
      name: 'settingsTheme',
      desc: '',
      args: [],
    );
  }

  /// `{field} Seçiniz`
  String settingsChooseField(Object field) {
    return Intl.message(
      '$field Seçiniz',
      name: 'settingsChooseField',
      desc: '',
      args: [field],
    );
  }

  /// `Çıkış Yap`
  String get settingsLogout {
    return Intl.message(
      'Çıkış Yap',
      name: 'settingsLogout',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'tr', countryCode: 'TR'),
      Locale.fromSubtags(languageCode: 'en', countryCode: 'US'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
