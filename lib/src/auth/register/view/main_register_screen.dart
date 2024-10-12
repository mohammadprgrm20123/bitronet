import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../infrastructure/utils/utils.dart';
import '../../../../infrastructure/form_validations/form_validation_utils.dart';
import '../../../share/widget/app_button.dart';
import '../../../share/widget/app_text.dart';
import '../../../share/widget/column_data_title.dart';
import '../../../share/widget/logo_with_image.dart';
import '../controller/register_account_controller.dart';
import '../model/register_model.dart';

class MainRegisterScreen extends GetView<RegisterAccountController> {
  const MainRegisterScreen({super.key});

  @override
  Widget build(final BuildContext context) => Scaffold(
        body: DefaultTabController(
          initialIndex: 0,
          length: 2,
          child: Padding(
            padding: Utils.mediumPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Utils.largeGap,
                LogoWithImage(),
                Expanded(
                  child: CustomScrollView(
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
                                  child: Center(
                                    child: AppText.bodySmall(
                                      'ساخت حساب کاربری',
                                      overflow: TextOverflow.visible,
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                              Utils.mediumGap,
                              ColumnDataTitle(
                                  title: 'شماره همراه ',
                                  isRequired: true,
                                  textForm: Directionality(
                                    textDirection: TextDirection.ltr,
                                    child: TextFormField(
                                      autovalidateMode: AutovalidateMode.onUserInteraction,
                                      validator: (final value) => FormValidationUtils(
                                          validators: [
                                            RequiredValidation(),
                                            MobileValidation()
                                          ]).validate(value),
                                      controller: controller.phoneController,
                                      keyboardType: TextInputType.number,
                                      decoration:
                                      const InputDecoration(hintText: '9171234567'),
                                    ),
                                  )),
                              Utils.mediumGap,
                              ColumnDataTitle(
                                  title: 'نام',
                                  isRequired: true,
                                  textForm: TextFormField(
                                    autovalidateMode: AutovalidateMode.onUserInteraction,
                                    validator: (final value) => FormValidationUtils(
                                        validators: [RequiredValidation()]).validate(value),
                                    controller: controller.nameController,
                                  )),
                              Utils.mediumGap,
                              ColumnDataTitle(
                                  isRequired: true,
                                  title: 'نام خانوادگی',
                                  textForm: TextFormField(
                                    autovalidateMode: AutovalidateMode.onUserInteraction,
                                    validator: (final value) => FormValidationUtils(
                                        validators: [RequiredValidation()]).validate(value),
                                    controller: controller.familyController,
                                  )),
                              Utils.mediumGap,
                              Utils.mediumGap,
                              const Spacer(),
                              Utils.mediumGap,
                              Obx(registerButton),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
  Widget registerButton() => AppButton(
    showLoading: controller.showLoading.value,
    onPressed: () async {
      if (controller.formKey.currentState!.validate()) {
        await controller.register(
            dto: RegisterDto(
                fName: controller.familyController.text,
                lName: controller.nameController.text,
                mobile: controller.phoneController.text));
      }
    },
    text: 'ثبت نام',
  );


}
