import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import '../../../../../infrastructure/theme/app_color.dart';
import '../../../../../infrastructure/theme/theme_constants.dart';
import '../../../../../infrastructure/utils/utils.dart';
import '../../../../share/widget/app_button.dart';
import '../../../../share/widget/app_text.dart';
import '../../../../share/widget/loading_widget.dart';
import '../../../../share/widget/logo_with_image.dart';
import '../../share/model/resend_dto.dart';
import '../../share/model/verify_dto.dart';
import '../controller/authenticator_controller.dart';

class AuthenticatorScreen extends GetView<AuthenticatorController> {
  const AuthenticatorScreen({super.key});

  @override
  Widget build(final BuildContext context) => Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
          const LogoWithImage(),
          Utils.mediumGap,
          const AppText('کد امنیتی Google Authenticator را وارد کنید'),
          Utils.giantGap,
          Center(child: codeInput(context)),
          Utils.largeGap,
          Utils.largeGap,
          resendCode(context),
          Utils.largeGap,
          Obx(enterButton)
        ]),
      ));

  Widget enterButton() => IgnorePointer(
        ignoring: controller.disableButton.value,
        child: AppButton(
          showLoading: controller.showLoading.value,
          onPressed: controller.disableButton.value ? null : () {},
          text: 'ورود',
          backgroundColor:
              controller.disableButton.value ? AppColor.grey : AppColor.primary,
          contentPadding: const EdgeInsets.symmetric(horizontal: 50),
        ),
      );

  Widget codeInput(final BuildContext context) => Padding(
    padding: const EdgeInsets.all(8.0),
    child: Directionality(
          textDirection: TextDirection.ltr,
          child: Pinput(
            androidSmsAutofillMethod: AndroidSmsAutofillMethod.smsUserConsentApi,
            closeKeyboardWhenCompleted: true,
            length: 6,
            disabledPinTheme: buildPinTheme(context),
            focusedPinTheme: buildPinTheme(context).copyWith(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                        width: 2, color: Theme.of(context).colorScheme.primary))),
            defaultPinTheme: buildPinTheme(context),
            onChanged: (final value) {
              if (value.length == 5) {
                controller.disableButton.value = false;
              } else {
                controller.disableButton.value = true;
              }
            },
            onCompleted: (final pin) async {
              await controller
                  .verifyCode(VerifyDto(email: controller.email, token: pin));
            },
          ),
        ),
  );

  Widget resendCode(final BuildContext context) =>
      Obx(() => controller.showSendCode.value
          ? GestureDetector(
              onTap: () {
                controller.resendCode(ResendDto(email: controller.email));
              },
              child: Obx(() => controller.showSendCodeLoading.value
                  ? const LoadingWidget()
                  : AppText(
                      'ارسال مجدد کد',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary),
                    )))
          : const SizedBox.shrink());

  PinTheme buildPinTheme(final BuildContext context) => PinTheme(
        width: 60,
        height: 60,
        textStyle: TextStyle(
          fontSize: 22,
          color: Theme.of(context).colorScheme.onSecondary,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onTertiary,
          borderRadius: BorderRadius.circular(ThemeConstants.borderRadius),
        ),
      );
}
