import 'package:bitronet_attendance/infrastructure/form_validations/form_validation_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../infrastructure/routing/app_route_name.dart';
import '../../../../infrastructure/theme/app_color.dart';
import '../../../../infrastructure/utils/utils.dart';
import '../../../../infrastructure/utils/validation_utils.dart';
import '../../../share/widget/app_button.dart';
import '../../../share/widget/app_text.dart';
import '../../../share/widget/column_data_title.dart';
import '../../../share/widget/logo_with_image.dart';
import '../controller/login_controller.dart';
import '../model/login_dto.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(final BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          toolbarHeight: 40,
        ),
        resizeToAvoidBottomInset: true,
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: Utils.mediumPadding,
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const LogoWithImage(),
                      Utils.largeGap,
                      phone(context),
                      Utils.mediumGap,
                      password(context),
                      Utils.mediumGap,
                      const Spacer(),
                      Utils.mediumGap,
                      Utils.mediumGap,
                      Obx(() => AppButton(
                            showLoading: controller.showLoading.value,
                            onPressed: () {
                              if (controller.formKey.currentState!.validate()) {
                                controller.login(
                                    context: context,
                                    dto: LoginDto(
                                        phone: controller.emailController.text,
                                        password: Utils.replaceFarsiNumber(
                                            controller
                                                .passwordController.text)));
                              }
                            },
                            text: 'ورود به حساب',
                          )),
                      Utils.mediumGap,
                      createAccount(context),
                      Utils.mediumGap,
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );

  Widget createAccount(final BuildContext context) => GestureDetector(
        onTap: () {
          Get.toNamed(AppRouteName.mainRegister);
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppText.bodySmall('حساب کاربری ندارید؟  '),
            AppText.bodySmall(
              'حساب بسازید',
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary),
            )
          ],
        ),
      );

  Widget password(final BuildContext context) => ColumnDataTitle(
        title: 'رمز عبور',
        isRequired: true,
        textForm: Obx(() => TextFormField(
              controller: controller.passwordController,
              textDirection: TextDirection.ltr,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              obscureText: !controller.showPassword.value,
              obscuringCharacter: '*',
              validator: (final value) =>
                  ValidationUtils.requiredValidator(value, context),
              decoration: InputDecoration(
                prefixIcon: Obx(() => IconButton(
                      icon: Icon(controller.showPassword.value
                          ? LucideIcons.eyeOff
                          : LucideIcons.eye),
                      onPressed: () {
                        controller.showPassword.toggle();
                      },
                    )),
              ),
            )),
      );

  Widget phone(final BuildContext context) => ColumnDataTitle(
        title: 'شماره موبایل',
        textForm: TextFormField(
          controller: controller.emailController,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (final value) =>
              FormValidationUtils(validators: [
                RequiredValidation(),
                MobileValidation()])
                  .validate(value),
          maxLength: 10,
          textDirection: TextDirection.ltr,
          decoration: const InputDecoration(hintText: '9309102121'),
        ),
      );
}
