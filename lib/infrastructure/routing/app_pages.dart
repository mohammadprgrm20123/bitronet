import 'package:get/get.dart';

import '../../src/auth/login/binding/login_binding.dart';
import '../../src/auth/login/view/login_screen.dart';
import '../../src/auth/register/main/binding/main_register_binding.dart';
import '../../src/auth/register/main/view/main_register_screen.dart';
import '../../src/auth/splash/middelware/splash_middleware.dart';
import '../../src/auth/verify/authenticator/binding/authenticator_binding.dart';
import '../../src/auth/verify/authenticator/view/authenticator_screen.dart';
import '../../src/auth/verify/mobile/binding/verify_binding.dart';
import '../../src/auth/verify/mobile/view/verify_screen.dart';
import 'app_route_name.dart';

class AppPages {
  static final appPages = <GetPage<dynamic>>[
    GetPage(
      name: AppRouteName.loginRoute,
      bindings: [LoginBinding()],
      page: () => const LoginScreen(),
    ),
    GetPage(
      name: AppRouteName.verifyRoute,
      page: () => const VerifyScreen(),
      binding: VerifyBinding(),
    ),
    GetPage(
      name: AppRouteName.authenticatorVerify,
      page: () => const AuthenticatorScreen(),
      binding: AuthenticatorBinding(),
    ),
    GetPage(
      name: AppRouteName.mainRegister,
      bindings: [MainRegisterBinding()],
      page: () => const MainRegisterScreen(),
    ),


  ];
}
