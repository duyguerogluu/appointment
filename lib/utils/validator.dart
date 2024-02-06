import 'package:flex_color_scheme/flex_color_scheme.dart';

import '../constants/l10n/l10n.dart';

class Validator<T> {
  final String fieldName;
  Validator(this.fieldName);

  final List<String? Function(T?)> _validatorFunctions =
      <String? Function(T?)>[];

  Validator<NewT> convertType<NewT>(T? Function(NewT?) converter) {
    var newValidator = Validator<NewT>(fieldName);

    for (var _func in _validatorFunctions) {
      newValidator._add((val) => _func(converter(val)));
    }

    return newValidator;
  }

  String _nnStr(dynamic dyn) {
    return dyn?.toString() ?? '';
  }

  Validator<T> _add(String? Function(T?) func) {
    _validatorFunctions.add(func);
    return this;
  }

  Validator<T> func(String? Function(T?) func) {
    return _add(func);
  }

  Validator<T> required() {
    return _add((val) {
      if (_nnStr(val).isEmpty) {
        return S.current.validatorFieldRequired(fieldName).capitalize;
      }
      return null;
    });
  }

  Validator<T> shouldBeAccepted() {
    return _add((val) {
      if (val == null || val == false) {
        return S.current.validatorFieldRequired(fieldName).capitalize;
      }
      return null;
    });
  }

  Validator<T> canNotBeEmpty() {
    return _add((val) {
      if (_nnStr(val).isEmpty) {
        return S.current.validatorFieldCanNotBeEmpty(fieldName).capitalize;
      }
      return null;
    });
  }

  Validator<T> minLength(int length) {
    return _add((val) {
      if (_nnStr(val).length < length) {
        return S.current
            .validatorFieldMustBeLength(fieldName, length)
            .capitalize;
      }
      return null;
    });
  }

  Validator<T> maxLength(int length) {
    return _add((val) {
      if (_nnStr(val).length > length) {
        return S.current
            .validatorFieldMustBeLength(fieldName, length)
            .capitalize;
      }
      return null;
    });
  }

  Validator<T> shouldNotBeMatchWith(T? otherValue, String otherFieldName) {
    return _add((val) {
      if (val == otherValue) {
        return S.current
            .validatorTheFieldAndTheOtherFieldMustBeDifferent(
                fieldName, otherFieldName)
            .capitalize;
      }
      return null;
    });
  }

  Validator<T> shouldBeMatchWith(T? otherValue, String fieldNames) {
    return _add((val) {
      if (val != otherValue) {
        return S.current.validatorFieldsDontMatch(fieldNames).capitalize;
      }
      return null;
    });
  }

  Validator<T> email() {
    return this.regExp(
        RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9\-\_]+(\.[a-zA-Z]+)*$"),
        S.current.validatorEmailAddressFormatIsInvalid);
  }

  Validator<T> regExp(RegExp regExp, String errorMessage) {
    return _add((val) {
      return val == null || regExp.hasMatch(val.toString())
          ? null
          : errorMessage;
    });
  }

  String? build(T value) {
    for (var func in _validatorFunctions) {
      var errorText = func(value);
      if (errorText != null) return errorText;
    }
    return null;
  }
}
