import 'package:get/get.dart';



class SplashMiddleWare extends GetMiddleware {
  @override
  // TODO: implement priority
  int? get priority => 1;


  @override
  GetPage<dynamic>? onPageCalled(final GetPage<dynamic>? page) => page;


}
