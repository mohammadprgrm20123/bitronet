import 'package:get/get.dart';

import '../../legal_account_register/controller/legal_account_controller.dart';

class MainRegisterBinding extends Binding {
  @override
  List<Bind<dynamic>> dependencies() => [
        Bind.lazyPut(LegalAccountController.new),
      ];
}
