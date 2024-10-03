import 'package:get/get.dart';

import '../controller/login_controller.dart';

class LoginBinding extends Binding {
  @override
  List<Bind<dynamic>> dependencies() => [Bind.lazyPut(LoginController.new)];
}
