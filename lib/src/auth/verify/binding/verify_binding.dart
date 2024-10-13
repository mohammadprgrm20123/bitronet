import 'package:get/get.dart';

import '../controller/verify_controller.dart';

class VerifyBinding extends Binding {
  @override
  List<Bind<dynamic>> dependencies() {

    print(Get.parameters['phone']);
    return [Bind.lazyPut(() => VerifyController(Get.parameters['phone'] ?? ''))];
  }
}
