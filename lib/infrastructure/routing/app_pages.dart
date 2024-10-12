import 'package:get/get.dart';

import '../../src/auth/login/binding/login_binding.dart';
import '../../src/auth/login/view/login_screen.dart';
import '../../src/auth/register/binding/register_binding.dart';
import '../../src/auth/register/view/main_register_screen.dart';
import '../../src/auth/verify/binding/verify_binding.dart';
import '../../src/auth/verify/view/verify_screen.dart';
import '../../src/home/view/home_screen.dart';
import 'app_route_name.dart';

class AppPages {
  static final appPages = <GetPage<dynamic>>[
    GetPage(
      name: AppRouteName.loginRoute,
      bindings: [LoginBinding()],
      page: () => const LoginScreen(),
    ),
    GetPage(
      name: AppRouteName.verify,
      page: () => const VerifyScreen(),
      binding: VerifyBinding(),
    ),

    GetPage(
      name: AppRouteName.mainRegister,
      bindings: [RegisterBinding()],
      page: () => const MainRegisterScreen(),
    ),



    GetPage(
      name: AppRouteName.homeRoute,
      page: () => const HomeScreen(),
    ),

  ];
}
