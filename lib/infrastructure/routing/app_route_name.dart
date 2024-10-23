class AppRouteName {
  static String splashRoute = '/splash';
  static String introRoute = '/intro';
  static String mainRegister = '/register';
  static String loginRoute = '/login';
  static String verify = '/verify/:phone';
  static String homeRoute = '/home';
  static String workPlaceBoss = '/wokplace_boss';
  static String addWorkPlaceBoss = '/add_wokplace_boss';
  static String editWorkPlaceBoss = '/edit_wokplace_boss';
  static String selectAddress = '/selectAddress';
  static String mainTabBoss = '/main_tab_boss/:title/:id';

//------------------------------------------------------------------------------
  static String verifyRoute({required final String phone}) =>
      verify.replaceAll(':phone', phone);

  static String workPLaceBossRoute = '$homeRoute$workPlaceBoss';
  static String addWorkPlaceRoute = '$homeRoute$workPlaceBoss$addWorkPlaceBoss';
  static String editWorkPlaceRoute =
      '$homeRoute$workPlaceBoss$editWorkPlaceBoss';
  static String editSelectAddressRoute =
      '$homeRoute$workPlaceBoss$editWorkPlaceBoss$selectAddress';
  static String selectAddressRoute =
      '$homeRoute$workPlaceBoss$addWorkPlaceBoss$selectAddress';

  static String mainTabBossRoute(
          {required final String title, required final String id}) =>
      '$homeRoute$workPlaceBoss$mainTabBoss'
          .replaceAll(':title', title)
          .replaceAll(':id', id);
}
