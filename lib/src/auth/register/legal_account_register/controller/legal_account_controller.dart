import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../infrastructure/routing/app_route_name.dart';
import '../../../../../infrastructure/utils/utils.dart';
import '../../main/model/register_model.dart';
import '../../main/respository/register_main_repository.dart';

class LegalAccountController extends GetxController {
  final MainRegisterRepository _repository = MainRegisterRepository();

  RxBool showLoading = false.obs;
  RxBool showPassword = false.obs;
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  RxBool checkRule = false.obs;

  @override
  void dispose() {
    super.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }

  Future<void> register({required final RegisterDto dto}) async {
    showLoading.value = true;
    final result = await _repository.register(dto: dto);

    result.fold((final error) => Utils.showErrorToast(errors: error.errors),
        (final response) {
      Get.toNamed(AppRouteName.verifyRoute, parameters: {'email': dto.email});
    });
    showLoading.value = false;
  }
}
