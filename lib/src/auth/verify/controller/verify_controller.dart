import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../infrastructure/routing/app_route_name.dart';
import '../../../../infrastructure/utils/utils.dart';
import '../../../share/model/api_status.dart';
import '../../../share/widget/loading.dart';
import '../../login/model/login_dto.dart';
import '../repository/verify_repository.dart';

class VerifyController extends GetxController {
  String phone;

  final VerifyRepository _repository = VerifyRepository();

  VerifyController(this.phone);

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

  void startTimer() {
    time = timeCount;
    Timer.periodic(const Duration(seconds: 1), (final timer) {
      if (time == 0) {
        timer.cancel();
        streamController.done;
        showSendCode.value = true;
      } else {
        updateTime();
      }
    });
  }

  void updateTime() {
    time--;
    if (streamController.isClosed) {
      streamController.sink;
      streamController.add(time);
    } else {
      streamController.add(time);
    }
  }

  Future<void> login({required final LoginDto dto})  async {

    WaitingDialog().show();
    final result = await _repository.login(dto: dto);

    print(dto.toJson());
    result.fold((final l){
      Utils.showErrorToast(errors: l.errors);
    }, (final r){
      Utils.showSuccessToast(message: 'ورود موقعیت آمیز بود');
      Utils.saveToken(token: r);
      Get.offAndToNamed(AppRouteName.homeRoute);
    });

    WaitingDialog().hide();
  }

  @override
  void onInit() {
    startTimer();
    phone = Get.parameters['phone'] ?? '';
    super.onInit();
  }
}
