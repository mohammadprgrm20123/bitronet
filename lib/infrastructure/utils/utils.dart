import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get_secure_storage/get_secure_storage.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../src/share/model/auth_status.dart';
import '../../src/share/model/user_details_model.dart';
import '../../src/share/model/verification_type.dart';
import '../../src/share/widget/app_text.dart';
import '../theme/app_color.dart';
import 'app_parameters.dart';
import 'key_parameters.dart';

class Utils {
  static const double tinySpace = 4;
  static const double smallSpace = 8;
  static const double mediumSpace = 16;
  static const double largeSpace = 24;
  static const double giantSpace = 32;

  static const Widget tinyGap = Gap(tinySpace);
  static const Widget smallGap = Gap(smallSpace);
  static const Widget mediumGap = Gap(mediumSpace);
  static const Widget largeGap = Gap(largeSpace);
  static const Widget giantGap = Gap(giantSpace);

  static const EdgeInsetsDirectional tinyPadding =
      EdgeInsetsDirectional.all(tinySpace);
  static const EdgeInsetsDirectional smallPadding =
      EdgeInsetsDirectional.all(smallSpace);
  static const EdgeInsetsDirectional mediumPadding =
      EdgeInsetsDirectional.all(mediumSpace);
  static const EdgeInsetsDirectional largePadding =
      EdgeInsetsDirectional.all(largeSpace);
  static const EdgeInsetsDirectional giantPadding =
      EdgeInsetsDirectional.all(giantSpace);

  static void showErrorToast({
    required final List<String> errors,
    final Duration? duration,
  }) {
    Get.snackbar('', '',
        borderRadius: 4,
        borderWidth: 1,
        barBlur: 10,
        titleText: AppText.bodySmall(
          errors.join(
            '\n',
          ),
          style: const TextStyle(
            fontSize: 13,
          ),
        ),
        leftBarIndicatorColor: Colors.red,
        colorText: Colors.white,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        // padding: EdgeInsets.zero,
        backgroundColor: AppColor.error.withOpacity(.3),
        borderColor: AppColor.error,
        overlayBlur: 3,
        icon: const Icon(
          Icons.highlight_remove_rounded,
          color: AppColor.error,
        ));
  }

  static void showInfoToast({
    required final String text,
    final Duration? duration,
  }) {
    Get.snackbar('', '',
        borderRadius: 4,
        borderWidth: 1,
        barBlur: 10,
        titleText: AppText.bodySmall(
          text,
          style: const TextStyle(
            fontSize: 13,
          ),
        ),
        leftBarIndicatorColor: AppColor.tritry,
        colorText: Colors.white,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        borderColor: AppColor.tritry,
        backgroundColor: AppColor.tritry.withOpacity(.3),
        overlayBlur: 3,
        icon: const Icon(
          Icons.warning_amber_rounded,
          color: AppColor.tritry,
        ));
  }

  static void showSuccessToast({
    final String? message,
  }) {
    Get.snackbar('', '',
        borderRadius: 4,
        borderWidth: 1,
        shouldIconPulse: false,
        barBlur: 50,
        titleText: AppText.bodySmall(
          message ?? 'با موفقیت انجام شد',
          style: const TextStyle(
            fontSize: 13,
          ),
        ),
        leftBarIndicatorColor: AppColor.success,
        colorText: Colors.white,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        // padding: Ed geInsets.zero,
        borderColor: AppColor.success,
        backgroundColor: AppColor.success.withOpacity(.3),
        overlayBlur: 3,
        icon: const Icon(
          LucideIcons.badgeCheck,
          color: AppColor.success,
        ));
  }

  static void saveToken({final String? token}) {
    final box = GetSecureStorage();
    box.write(KeyParameters.tokenKey, token);
    AppParameters.token = token;
  }

  static String removeDecimalZeroFormat(final double n) =>
      n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 1);

  static String replaceFarsiNumber(final String value) {
    const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    const farsi = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];

    String input = '';
    for (int i = 0; i < english.length; i++) {
      input = value.replaceAll(farsi[i], english[i]);
    }

    return input;
  }




  static bool isNotAuthenticationCompleted(final UserDetailsModel? user) {
    bool isAuthenticate = false;
    if (user?.data.user?.needVideoVerification != 0) {
      final List<AuthStatus> status =
          user?.data.verifications.map((final e) => e.resultStatus).toList() ??
              [];
      isAuthenticate = status.any((final e) => e != AuthStatus.confirmed);
      print(isAuthenticate);
    } else {
      final List<VerificationModel> list =
          user?.data.verifications.toList() ?? [];
      list.removeWhere(
          (final e) => e.verificationType == VerificationType.video);

      final List<AuthStatus> status =
          list.map((final e) => e.resultStatus).toList();
      isAuthenticate = status.any((final e) => e != AuthStatus.confirmed);
    }

    return isAuthenticate;
  }

  static double calculateProgressingAuthentication(
      {final UserDetailsModel? model}) {
    if (model == null) {
      return 0;
    }
    int allVerificationTypes = model.data.verificationTypes?.keys
            .map((final e) => e)
            .toList()
            .length ??
        0;

    final confirmationVerification = model.data.verifications
        .where((final e) => e.resultStatus == AuthStatus.confirmed)
        .toList();

    if (model.data.user?.needVideoVerification == 0) {
      if (confirmationVerification
              .firstWhereOrNull(
                  (final e) => e.verificationType == VerificationType.video)
              ?.resultStatus !=
          AuthStatus.confirmed) {
        allVerificationTypes--;
      }
    }

    if (model.data.user?.isBusiness == false) {
      allVerificationTypes--;
    }
    return confirmationVerification.length / allVerificationTypes;
  }

  static void removeBiometric({required final String key}) async {
    final box = GetSecureStorage();
    await box.remove(key);
  }
}
