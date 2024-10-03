import 'dart:async';

import 'package:get/get.dart';

import '../../../../../infrastructure/routing/app_route_name.dart';
import '../../../../../infrastructure/utils/utils.dart';
import '../../share/model/resend_dto.dart';
import '../../share/model/verify_dto.dart';
import '../../share/repository/verify_repository.dart';

class AuthenticatorController extends GetxController {
  String email;

  final VerifyRepository _repository = VerifyRepository();

  AuthenticatorController(this.email);

  RxBool showLoading = false.obs;
  RxBool showSendCodeLoading = false.obs;

  static const int timeCount = 120;
  RxBool showSendCode = false.obs;
  int time = timeCount;
  RxBool disableButton = true.obs;

  StreamController<int> streamController = StreamController();

  @override
  void onInit() {
    startTimer();
    super.onInit();
  }

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

  Future<void> verifyCode(final VerifyDto dto) async {
    showLoading.value = true;

    final result = await _repository.verify(dto: dto);

    result.fold((final error) => Utils.showErrorToast(errors: error.errors),
        (final response) {
      Utils.saveToken(token: response.token);

      Get.offAllNamed(AppRouteName.homeRoute);
    });
    showLoading.value = false;
  }

  Future<void> resendCode(final ResendDto dto) async {
    showSendCodeLoading.value = true;

    final result = await _repository.resendCode(dto: dto);

    result.fold((final l) => Utils.showErrorToast(errors: l.errors), (final r) {
      showSendCode.toggle();
      startTimer();
    });
    showSendCodeLoading.value = false;
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

  @override
  void dispose() {
    streamController.close();
    super.dispose();
  }
}
