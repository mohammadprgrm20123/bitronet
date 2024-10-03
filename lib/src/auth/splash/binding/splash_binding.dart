import 'package:get/get.dart';

import '../controller/splash_controller.dart';

class SplashBindings extends Binding {
  @override
  List<Bind<dynamic>> dependencies() => [Bind.lazyPut(()=>SplashController.new)];
}
