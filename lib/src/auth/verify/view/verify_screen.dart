import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../infrastructure/form_validations/form_validation_utils.dart';
import '../../../../../infrastructure/utils/utils.dart';
import '../../../../../infrastructure/utils/validation_utils.dart';
import '../../../share/widget/app_button.dart';
import '../../../share/widget/app_text.dart';
import '../../../share/widget/column_data_title.dart';
import '../../../share/widget/logo_with_image.dart';
import '../../login/model/login_dto.dart';
import '../controller/verify_controller.dart';

class VerifyScreen extends GetView<VerifyController> {
  const VerifyScreen({super.key});

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
                  Utils.mediumGap,
                  ZoomIn(
                    child: DecoratedBox(
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
                        child: Center(
                          child: AppText.bodySmall(
                            'رمز ارسال شده به شماره موبایل را وارد کنید و بخاطر بسپارید',
                            overflow: TextOverflow.visible,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Utils.largeGap,
                  phone(context),
                  Utils.smallGap,
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
                                phone: controller.phoneController.text,
                                password: Utils.replaceFarsiNumber(
                                    controller
                                        .passwordController.text)));
                      }
                    },
                    text: 'ورود به حساب',
                  )),
                  Utils.mediumGap,
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );


  Widget password(final BuildContext context) => ColumnDataTitle(
    title: 'رمز عبور',
    isRequired: true,
    textForm: TextFormField(
      controller: controller.passwordController,
      textDirection: TextDirection.ltr,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (final value) =>
          ValidationUtils.requiredValidator(value, context),
    ),
  );

  Widget phone(final BuildContext context) => ColumnDataTitle(
    title: 'شماره موبایل',
    isRequired: true,
    textForm: TextFormField(
      readOnly: true,
      controller: controller.phoneController,
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
