import 'package:get/get.dart';
import 'package:get_secure_storage/get_secure_storage.dart';

import '../../../../infrastructure/routing/app_route_name.dart';
import '../../../../infrastructure/utils/app_parameters.dart';
import '../../../../infrastructure/utils/key_parameters.dart';

class SplashController extends GetxController {
  @override
  void onInit() async {
    super.onInit();
    final box = GetSecureStorage();

    final token = await box.read(KeyParameters.tokenKey);
    print(token);
    if (token == null) {
      Get.offAllNamed(AppRouteName.loginRoute);
    } else {
      AppParameters.token = token;
      Get.offAllNamed(AppRouteName.homeRoute);
    }
  }
}
