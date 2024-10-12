class AppRouteName {
  static String splashRoute = '/splash';
  static String introRoute = '/intro';
  static String mainRegister = '/register';
  static String loginRoute = '/login';
  static String verify = '/verify/:phone';
  static String homeRoute = '/home';

//------------------------------------------------------------------------------
  static String verifyRoute({required final String phone}) =>
      verify.replaceAll(':phone', phone);
}
