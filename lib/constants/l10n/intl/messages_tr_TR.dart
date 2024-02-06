// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a tr_TR locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'tr_TR';

  static String m0(item) => "Yeni ${item} Oluştur";

  static String m1(field) => "${field} boş olamaz";

  static String m2(field) => "${field} Seçiniz";

  static String m3(field) => "${field} boş olamaz";

  static String m4(field, length) =>
      "${field} en az ${length} karakter uzunluğunda olmalıdır";

  static String m5(field) => "${field} zorunludur";

  static String m6(field) => "${field} kabul edilmelidir";

  static String m7(fields) => "${fields} eşleşmiyor";

  static String m8(field, otherField) =>
      "${field} ile ${otherField} birbirinden farklı olmalıdır";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "areYouSureYouWantToExit": MessageLookupByLibrary.simpleMessage(
            "Uygulamayı kapatmak istediğinize emin misiniz?"),
        "available": MessageLookupByLibrary.simpleMessage("Uygun"),
        "clickHereForSelectAnImage": MessageLookupByLibrary.simpleMessage(
            "Galeriden resim seçmek için tıklayınız"),
        "customErrorNoResultsFound":
            MessageLookupByLibrary.simpleMessage("Sonuç bulunamadı"),
        "customErrorSomethingWentWrong":
            MessageLookupByLibrary.simpleMessage("Bir şeyler ters gitti"),
        "customErrorUnauthorizedAccess":
            MessageLookupByLibrary.simpleMessage("Yetkisiz erişim"),
        "delete": MessageLookupByLibrary.simpleMessage("Sil"),
        "dialogCancel": MessageLookupByLibrary.simpleMessage("İptal"),
        "dialogConfirm": MessageLookupByLibrary.simpleMessage("Tamam"),
        "dialogYes": MessageLookupByLibrary.simpleMessage("Evet"),
        "drawerItemApplicationSettings":
            MessageLookupByLibrary.simpleMessage("Uygulama Ayarları"),
        "drawerItemMyProfile": MessageLookupByLibrary.simpleMessage("Profilim"),
        "drawerItemPartners":
            MessageLookupByLibrary.simpleMessage("Partnerler"),
        "edit": MessageLookupByLibrary.simpleMessage("Düzenle"),
        "formCancel": MessageLookupByLibrary.simpleMessage("İptal"),
        "formCreateNewX": m0,
        "formEdit": MessageLookupByLibrary.simpleMessage("Düzenle"),
        "formSave": MessageLookupByLibrary.simpleMessage("Kaydet"),
        "load_": MessageLookupByLibrary.simpleMessage("Yükle"),
        "loginFormConfirmPassword":
            MessageLookupByLibrary.simpleMessage("Şifre (Tekrar)"),
        "loginFormError": MessageLookupByLibrary.simpleMessage("Hata"),
        "loginFormErrorFillFields": MessageLookupByLibrary.simpleMessage(
            "Lütfen tüm alanları doldurunuz"),
        "loginFormFieldCantBeEmpty": m1,
        "loginFormForgotPassword":
            MessageLookupByLibrary.simpleMessage("Şifrenizi mi unuttunuz?"),
        "loginFormPassword": MessageLookupByLibrary.simpleMessage("Şifre"),
        "loginFormPasswordsDontMatch":
            MessageLookupByLibrary.simpleMessage("Şifreler uyuşmuyor"),
        "loginFormResetPassword":
            MessageLookupByLibrary.simpleMessage("Şifreyi Sıfırla"),
        "loginFormResetPasswordScreenInformation":
            MessageLookupByLibrary.simpleMessage(
                "Size gönderilen linke tıklayarak şifre güncelleme işlemini gerçekleştirebilirsiniz."),
        "loginFormSignIn": MessageLookupByLibrary.simpleMessage("Giriş Yap"),
        "loginFormSomethingWrongCheckYourConnection":
            MessageLookupByLibrary.simpleMessage(
                "Birşeyler ters gitti, lütfen internet bağlantınızı kontrol ediniz ve tekrar deneyiniz"),
        "loginFormUsername":
            MessageLookupByLibrary.simpleMessage("Kullanıcı Adı"),
        "loginFormUsernamePasswordDoesntMatch":
            MessageLookupByLibrary.simpleMessage(
                "Kullanıcı adı ve şifre hiçbir kayıt ile eşleşmiyor"),
        "notAvailable": MessageLookupByLibrary.simpleMessage("Uygun Değil"),
        "rating": MessageLookupByLibrary.simpleMessage("Değerlendirme"),
        "refresh": MessageLookupByLibrary.simpleMessage("Yenile"),
        "reload": MessageLookupByLibrary.simpleMessage("Yeniden Yükle"),
        "search": MessageLookupByLibrary.simpleMessage("Ara"),
        "select": MessageLookupByLibrary.simpleMessage("Seç"),
        "settingsAppearance":
            MessageLookupByLibrary.simpleMessage("Dış Görünüm"),
        "settingsApplicationMenuDirection":
            MessageLookupByLibrary.simpleMessage("Uygulama Menüsü Yönü"),
        "settingsChooseField": m2,
        "settingsDark": MessageLookupByLibrary.simpleMessage("Karanlık"),
        "settingsGeneralSettings":
            MessageLookupByLibrary.simpleMessage("Genel Ayarlar"),
        "settingsLanguage": MessageLookupByLibrary.simpleMessage("Dil"),
        "settingsLeftToRight":
            MessageLookupByLibrary.simpleMessage("Soldan Sağa"),
        "settingsLight": MessageLookupByLibrary.simpleMessage("Aydınlık"),
        "settingsLogout": MessageLookupByLibrary.simpleMessage("Çıkış Yap"),
        "settingsRightToLeft":
            MessageLookupByLibrary.simpleMessage("Sağdan Sola"),
        "settingsSystemDefault":
            MessageLookupByLibrary.simpleMessage("Sistem Varsayılan"),
        "settingsTheme": MessageLookupByLibrary.simpleMessage("Tema"),
        "thisField": MessageLookupByLibrary.simpleMessage("Bu alan"),
        "validatorEmailAddressFormatIsInvalid":
            MessageLookupByLibrary.simpleMessage(
                "E-posta adresi formatı geçersiz"),
        "validatorFieldCanNotBeEmpty": m3,
        "validatorFieldMustBeLength": m4,
        "validatorFieldRequired": m5,
        "validatorFieldShouldBeAccepted": m6,
        "validatorFieldsDontMatch": m7,
        "validatorMobileNumberIsInvalid": MessageLookupByLibrary.simpleMessage(
            "Cep telefonu numarası geçersiz"),
        "validatorTheFieldAndTheOtherFieldMustBeDifferent": m8,
        "view": MessageLookupByLibrary.simpleMessage("Görüntüle"),
        "youHaveAlreadyAddedThis":
            MessageLookupByLibrary.simpleMessage("Bunu zaten eklediniz")
      };
}
