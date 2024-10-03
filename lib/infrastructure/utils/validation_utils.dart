
import 'package:flutter/cupertino.dart';


class ValidationUtils {
  static const String _mobileValidationPattern =
      r'^(\09|0)?9\d{9}$';
  static const String _emailValidationPattern =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";

  static String? requiredValidator(
      final String? value,
      final BuildContext context,
      ) =>
      value == null || value.isEmpty
          ? 'این فیلد اجباری است'
          : null;

  static String? validateMobile(
      final String? value,
      final BuildContext context,
      ) {
    final String? requiredValidationResult = requiredValidator(
      value,
      context,
    );


    if (requiredValidationResult != null) {
      return requiredValidationResult;
    } else {


      final RegExp regExp = RegExp(_mobileValidationPattern);

      if (!regExp.hasMatch(value!)) {
        return 'شماره موبایل معتبر نیست';
      }
    }

    return null;
  }

  static String? validateEmail(
      final String? value,
      final BuildContext context,
      ) {
    final String? requiredValidationResult = requiredValidator(
      value,
      context,
    );
    if (requiredValidationResult != null) {
      return requiredValidationResult;
    } else {
      final RegExp regExp = RegExp(_emailValidationPattern);
      if (!regExp.hasMatch(value!)) {
        return 'ایمیل معتبر نیست';
      }
    }

    return null;
  }

  static String? validatePassword(
      final String? value,
      final BuildContext context,
      ) {
    final String? requiredValidationResult = requiredValidator(
      value,
      context,
    );
    if (requiredValidationResult != null) {
      return requiredValidationResult;
    } else {
      if (value!.length < 6) {
        return 'Password must be at least six characters';
      }
    }

    return null;
  }
}
