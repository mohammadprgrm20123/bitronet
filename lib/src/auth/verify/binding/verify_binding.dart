import 'package:get/get.dart';

import '../controller/verify_controller.dart';

class VerifyBinding extends Binding {
  @override
  List<Bind<dynamic>> dependencies() =>
      [Bind.lazyPut(() => VerifyController(Get.parameters['email'] ?? ''))];
}
