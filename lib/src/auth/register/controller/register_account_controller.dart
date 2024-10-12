import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../infrastructure/routing/app_route_name.dart';
import '../../../../../infrastructure/utils/utils.dart';
import '../../../share/widget/loading.dart';
import '../model/register_model.dart';
import '../respository/register_main_repository.dart';

class RegisterAccountController extends GetxController {
  final MainRegisterRepository _repository = MainRegisterRepository();

  RxBool showLoading = false.obs;
  RxBool showPassword = false.obs;
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController phoneController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController familyController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  RxBool checkRule = false.obs;

  @override
  void dispose() {
    super.dispose();
    phoneController.dispose();
    nameController.dispose();
    familyController.dispose();
  }

  Future<void> register({required final RegisterDto dto}) async {
    showLoading.value = true;
    WaitingDialog().show();
    final result = await _repository.register(dto: dto);

    result.fold((final error) => Utils.showErrorToast(errors: error.errors),
        (final response) {
      Get.toNamed(
        AppRouteName.verifyRoute(phone: dto.mobile),
      );
    });
    showLoading.value = false;

    WaitingDialog().hide();
  }
}
