class AppRouteName {
  static String splashRoute = '/splash';
  static String introRoute = '/intro';
  static String mainRegister = '/register';
  static String loginRoute = '/login';
  static String verify = '/verify/:phone';
  static String homeRoute = '/home';
  static String workPLaceBoss = '/wokplace_boss';
  static String addWorkPlaceBoss = '/add_wokplace_boss';
  static String editWorkPlaceBoss = '/edit_wokplace_boss';
  static String selectAddress = '/selectAddress';

//------------------------------------------------------------------------------
  static String verifyRoute({required final String phone}) =>
      verify.replaceAll(':phone', phone);

  static String workPLaceBossRoute = '$homeRoute$workPLaceBoss';
  static String addWorkPlaceRoute = '$homeRoute$addWorkPlaceBoss';
  static String editWorkPlaceRoute = '$homeRoute$editWorkPlaceBoss';
  static String editSelectAddressRoute = '$homeRoute$editWorkPlaceRoute$selectAddress';
  static String selectAddressRoute = '$homeRoute$addWorkPlaceBoss$selectAddress';
}
