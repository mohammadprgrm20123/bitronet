class FormValidationUtils {
  List<BaseFormValidator<dynamic>> validators;

  FormValidationUtils({required this.validators});

  String? validate(final String? v) {
    String? value;
    for (final e in validators) {
      if (e.validator(v) != null) {
        value = e.validator(v);
        break;
      }
    }

    return value;
  }
}

abstract class BaseFormValidator<T> {
  String? validator(
    final T? value,
  );
}

class RequiredValidation extends BaseFormValidator<String> {
  @override
  String? validator(final String? value) =>
      value == null || value.isEmpty ? 'این فیلد اجباری است' : null;
}

class MobileValidation extends BaseFormValidator<String> {
  @override
  String? validator(final String? value) {
    const String mobileValidationPattern = r'^(\9|)?9\d{9}$';
    final RegExp regExp = RegExp(mobileValidationPattern);


    if (value!.startsWith('0')) {
      return 'شماره موبایل نباید با صفر شروع شود';
    }
    if (value.length < 10 || value.length > 10) {
      return 'شماره موبایل معتبر نیست';
    }



    return null;
  }
}
