import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../infrastructure/utils/utils.dart';
import '../../../../infrastructure/routing/app_route_name.dart';
import '../../../share/model/api_status.dart';
import '../../../share/widget/loading.dart';
import '../../login/model/login_dto.dart';
import '../model/resend_dto.dart';
import '../model/verify_dto.dart';
import '../repository/verify_repository.dart';

class VerifyController extends GetxController {
  String email;

  final VerifyRepository _repository = VerifyRepository();


  VerifyController(this.email);
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  Rx<ApiStatus<void>> loginApi = const ApiStatus.idle().obs;

  RxBool showLoading = false.obs;
  RxBool showSendCodeLoading = false.obs;

  static const int timeCount = 120;
  RxBool showSendCode = false.obs;
  int time = timeCount;
  RxBool disableButton = true.obs;

  StreamController<int> streamController = StreamController();

  @override
  void onInit() {
    phoneController.text = Get.parameters['phone'] ?? '';
    super.onInit();
  }


  Future<void> verifyCode(final VerifyDto dto) async {
    showLoading.value = true;

    final result = await _repository.verify(dto: dto);

    result.fold((final error) => Utils.showErrorToast(errors: error.errors),
        (final response) {
      Utils.saveToken(token: response.token);

      // Get.offAllNamed(AppRouteName.homeRoute);
    });
    showLoading.value = false;
  }

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
        Utils.saveToken(token: response);
        await Get.toNamed(AppRouteName.homeRoute);
      });
    } catch (e) {
      showLoading.value = false;
    }

    showLoading.value = false;
    WaitingDialog().hide();
  }

}
