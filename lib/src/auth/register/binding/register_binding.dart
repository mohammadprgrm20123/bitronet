import 'package:get/get.dart';

import '../controller/register_account_controller.dart';


class RegisterBinding extends Binding {
  @override
  List<Bind<dynamic>> dependencies() => [
        Bind.lazyPut(RegisterAccountController.new),
      ];
}
