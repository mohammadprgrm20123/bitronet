import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../share/widget/logo_with_image.dart';
import '../controller/splash_controller.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    Get.lazyPut(SplashController.new);
    controller.toString();
    return Scaffold(
      body: Center(
        child: LogoWithImage(),
      ),
    );
  }
}
