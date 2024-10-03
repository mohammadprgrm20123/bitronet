import 'package:get/get.dart';

import '../controller/authenticator_controller.dart';

class AuthenticatorBinding extends Binding {
  @override
  List<Bind<dynamic>> dependencies() =>
      [Bind.lazyPut(() => AuthenticatorController(Get.parameters['email'] ?? ''))];
}
