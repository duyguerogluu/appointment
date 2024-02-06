// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en_US locale. All the
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
  String get localeName => 'en_US';

  static String m0(item) => "Create New ${item}";

  static String m1(field) => "${field} can\'t be empty";

  static String m2(field) => "Choose ${field}";

  static String m3(field) => "${field} can not be empty";

  static String m4(field, length) =>
      "${field} must be at-least ${length} characters long";

  static String m5(field) => "${field} required";

  static String m6(field) => "${field} should be accepted";

  static String m7(fields) => "${fields} don\'t match";

  static String m8(field, otherField) =>
      "The ${field} and the ${otherField} must be different";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "areYouSureYouWantToExit": MessageLookupByLibrary.simpleMessage(
            "Are you sure you want to exit?"),
        "available": MessageLookupByLibrary.simpleMessage("Available"),
        "clickHereForSelectAnImage": MessageLookupByLibrary.simpleMessage(
            "Click here sor select an image"),
        "customErrorNoResultsFound":
            MessageLookupByLibrary.simpleMessage("No results found"),
        "customErrorSomethingWentWrong":
            MessageLookupByLibrary.simpleMessage("Something went wrong"),
        "customErrorUnauthorizedAccess":
            MessageLookupByLibrary.simpleMessage("Unauthorized access"),
        "delete": MessageLookupByLibrary.simpleMessage("Delete"),
        "dialogCancel": MessageLookupByLibrary.simpleMessage("Cancel"),
        "dialogConfirm": MessageLookupByLibrary.simpleMessage("OK"),
        "dialogYes": MessageLookupByLibrary.simpleMessage("Yes"),
        "drawerItemApplicationSettings":
            MessageLookupByLibrary.simpleMessage("Application Settings"),
        "drawerItemMyProfile":
            MessageLookupByLibrary.simpleMessage("My Profile"),
        "drawerItemPartners": MessageLookupByLibrary.simpleMessage("Partners"),
        "edit": MessageLookupByLibrary.simpleMessage("Edit"),
        "formCancel": MessageLookupByLibrary.simpleMessage("Cancel"),
        "formCreateNewX": m0,
        "formEdit": MessageLookupByLibrary.simpleMessage("Edit"),
        "formSave": MessageLookupByLibrary.simpleMessage("Save"),
        "load_": MessageLookupByLibrary.simpleMessage("Load"),
        "loginFormConfirmPassword":
            MessageLookupByLibrary.simpleMessage("Confirm Password"),
        "loginFormErrorFillFields":
            MessageLookupByLibrary.simpleMessage("Please fill in all fields"),
        "loginFormFieldCantBeEmpty": m1,
        "loginFormForgotPassword":
            MessageLookupByLibrary.simpleMessage("Forgot Password?"),
        "loginFormPassword": MessageLookupByLibrary.simpleMessage("Password"),
        "loginFormPasswordsDontMatch":
            MessageLookupByLibrary.simpleMessage("Passwords don\'t match"),
        "loginFormResetPassword":
            MessageLookupByLibrary.simpleMessage("Reset Password"),
        "loginFormResetPasswordScreenInformation":
            MessageLookupByLibrary.simpleMessage(
                "You can perform the password update process by clicking the link sent to you."),
        "loginFormSignIn": MessageLookupByLibrary.simpleMessage("Sign In"),
        "loginFormSomethingWrongCheckYourConnection":
            MessageLookupByLibrary.simpleMessage(
                "Something went wrong, please check your internet connection and try again"),
        "loginFormUsername": MessageLookupByLibrary.simpleMessage("Username"),
        "loginFormUsernamePasswordDoesntMatch":
            MessageLookupByLibrary.simpleMessage(
                "Username and password doesn\'t match"),
        "notAvailable": MessageLookupByLibrary.simpleMessage("Not Available"),
        "rating": MessageLookupByLibrary.simpleMessage("Rating"),
        "refresh": MessageLookupByLibrary.simpleMessage("Refresh"),
        "reload": MessageLookupByLibrary.simpleMessage("Reload"),
        "search": MessageLookupByLibrary.simpleMessage("Search"),
        "select": MessageLookupByLibrary.simpleMessage("Select"),
        "settingsAppearance":
            MessageLookupByLibrary.simpleMessage("Appearance"),
        "settingsApplicationMenuDirection":
            MessageLookupByLibrary.simpleMessage("Application Menu Direction"),
        "settingsChooseField": m2,
        "settingsDark": MessageLookupByLibrary.simpleMessage("Dark"),
        "settingsGeneralSettings":
            MessageLookupByLibrary.simpleMessage("General Settings"),
        "settingsLanguage": MessageLookupByLibrary.simpleMessage("Language"),
        "settingsLeftToRight":
            MessageLookupByLibrary.simpleMessage("Left to right"),
        "settingsLight": MessageLookupByLibrary.simpleMessage("Light"),
        "settingsLogout": MessageLookupByLibrary.simpleMessage("Logout"),
        "settingsRightToLeft":
            MessageLookupByLibrary.simpleMessage("Right to left"),
        "settingsSystemDefault":
            MessageLookupByLibrary.simpleMessage("System Default"),
        "settingsTheme": MessageLookupByLibrary.simpleMessage("Theme"),
        "thisField": MessageLookupByLibrary.simpleMessage("This field"),
        "validatorEmailAddressFormatIsInvalid":
            MessageLookupByLibrary.simpleMessage(
                "Email address format is invalid"),
        "validatorFieldCanNotBeEmpty": m3,
        "validatorFieldMustBeLength": m4,
        "validatorFieldRequired": m5,
        "validatorFieldShouldBeAccepted": m6,
        "validatorFieldsDontMatch": m7,
        "validatorMobileNumberIsInvalid":
            MessageLookupByLibrary.simpleMessage("Mobile number is invalid"),
        "validatorTheFieldAndTheOtherFieldMustBeDifferent": m8,
        "view": MessageLookupByLibrary.simpleMessage("View"),
        "youHaveAlreadyAddedThis":
            MessageLookupByLibrary.simpleMessage("You have already added this")
      };
}
