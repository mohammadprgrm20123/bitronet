import 'package:bitronet_attendance/src/share/widget/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../../infrastructure/utils/utils.dart';
import '../../../share/model/api_status.dart';
import '../model/login_dto.dart';
import '../repository/login_repository.dart';

class LoginController extends GetxController {
  final LoginRepository _repository = LoginRepository();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  Rx<ApiStatus<void>> loginApi = const ApiStatus.idle().obs;

  RxBool showPassword = false.obs;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  RxBool showLoading = false.obs;

  Future<void> login(
      {required final LoginDto dto,
      required final BuildContext context}) async {
    WaitingDialog().show();
    try {
      final result = await _repository.login(dto: dto);
      await result.fold((final l) {
        Utils.showErrorToast(errors: l.errors);
        showLoading.value = false;
      }, (final response) async {
        Utils.saveToken(token: response.token);
      });
    } catch (e) {
      showLoading.value = false;
    }

    showLoading.value = false;
    WaitingDialog().hide();
  }
}
