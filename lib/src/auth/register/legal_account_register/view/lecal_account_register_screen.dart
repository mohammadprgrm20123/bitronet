import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../../infrastructure/theme/app_color.dart';
import '../../../../../infrastructure/utils/utils.dart';
import '../../../../../infrastructure/utils/validation_utils.dart';
import '../../../../share/widget/app_button.dart';
import '../../../../share/widget/app_text.dart';
import '../../../../share/widget/column_data_title.dart';
import '../../main/model/register_model.dart';
import '../../main/model/register_type.dart';
import '../controller/legal_account_controller.dart';

class LegalAccountRegisterScreen extends GetView<LegalAccountController> {
  const LegalAccountRegisterScreen({super.key});

  @override
  Widget build(final BuildContext context) => CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Utils.mediumGap,
                  DecoratedBox(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Theme.of(context)
                            .colorScheme
                            .tertiary
                            .withOpacity(.07),
                        border: Border.all(
                            color: Theme.of(context).colorScheme.tertiary)),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: AppText.bodySmall(
                        'در صورتی که دارای شرکت / موسسه ثبت شده هستید از این بخش ثبت نام کنید. (بعد از ایجاد حساب کاربری حقوقی امکان تغییر آن به حساب کاربری حقیقی وجود ندارد.)',
                        overflow: TextOverflow.visible,
                      ),
                    ),
                  ),
                  Utils.mediumGap,
                  ColumnDataTitle(
                      title: 'شماره همراه مدیر عامل',
                      textForm: Directionality(
                        textDirection: TextDirection.ltr,
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (final value) =>
                              ValidationUtils.validateMobile(value, context),
                          controller: controller.phoneController,
                          keyboardType: TextInputType.number,
                          decoration:
                              const InputDecoration(hintText: '09171234567'),
                        ),
                      )),
                  Utils.mediumGap,
                  ColumnDataTitle(
                      title: 'ایمیل شرکت',
                      textForm: Directionality(
                        textDirection: TextDirection.ltr,
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (final value) =>
                              ValidationUtils.validateEmail(value, context),
                          controller: controller.emailController,
                        ),
                      )),
                  Utils.mediumGap,
                  ColumnDataTitle(
                      title: 'رمز عبور',
                      textForm: Obx(() => TextFormField(
                            obscuringCharacter: '*',
                            controller: controller.passwordController,
                            textDirection: TextDirection.ltr,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            obscureText: !controller.showPassword.value,
                            validator: (final value) =>
                                ValidationUtils.requiredValidator(
                                    value, context),
                            decoration: InputDecoration(
                              prefixIcon: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Obx(() => IconButton(
                                      icon: Icon(controller.showPassword.value
                                          ? LucideIcons.eye
                                          : LucideIcons.eyeOff),
                                      onPressed: () {
                                        controller.showPassword.toggle();
                                      },
                                    )),
                              ),
                            ),
                          ))),
                  Utils.mediumGap,
                  ColumnDataTitle(
                      title: 'تکرار رمز عبور',
                      textForm: Obx(() => TextFormField(
                            obscuringCharacter: '*',
                            controller: controller.confirmPasswordController,
                            textDirection: TextDirection.ltr,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            obscureText: !controller.showPassword.value,
                            validator: (final value) {
                              if (value == null || value.isEmpty) {
                                return ValidationUtils.requiredValidator(
                                    value, context);
                              }

                              if (value != controller.passwordController.text) {
                                return 'رمز عبور یکسان نیست';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              prefixIcon: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Obx(() => IconButton(
                                      icon: Icon(controller.showPassword.value
                                          ? LucideIcons.eyeOff
                                          : LucideIcons.eyeOff),
                                      onPressed: () {
                                        controller.showPassword.toggle();
                                      },
                                    )),
                              ),
                            ),
                          ))),
                  Utils.mediumGap,
                  Row(
                    children: [
                      Obx(() => Checkbox(
                          value: controller.checkRule.value,
                          onChanged: (final value) {
                            controller.checkRule.toggle();
                          })),
                      GestureDetector(
                        onTap: () async {
                        },
                        child: AppText(
                          ' قوانین و مقررات  ',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: AppColor.primary),
                        ),
                      ),
                      const Expanded(
                        child: AppText('را مطالعه کرده ام و آن را قبول دارم'),
                      ),
                    ],
                  ),
                  Utils.mediumGap,
                  const Spacer(),
                  Utils.mediumGap,
                  Obx(registerButton),
                ],
              ),
            ),
          )
        ],
      );

  Widget registerButton() => IgnorePointer(
        ignoring: !controller.checkRule.value,
        child: AppButton(
          showLoading: controller.showLoading.value,
          backgroundColor: controller.checkRule.value ? null : AppColor.grey,
          onPressed: () async {
            if (controller.formKey.currentState!.validate()) {
              await controller.register(
                  dto: RegisterDto(
                      email: controller.emailController.text,
                      mobile: controller.phoneController.text,
                      password: Utils.replaceFarsiNumber(
                          controller.passwordController.text),
                      rules: true,
                      registerType: RegisterType.legal));
            }
          },
          text: 'ثبت نام',
        ),
      );
}
