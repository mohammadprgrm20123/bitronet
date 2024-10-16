import 'package:get/get.dart';

import '../../src/auth/splash/model/app_update_model.dart';

class AppParameters {
  static String? token = '';
  static int offset = 10;


  static int timer = 0;

  static Rxn<AppUpdateModel> appUpdateModel = Rxn(null);
  static RxBool hasVpn = false.obs;
  static RxBool showPinLock = false.obs;
  static RxBool showFingerPrint = false.obs;
  static RxBool showFingerPrintAndPin = false.obs;
  static RxBool removePin = false.obs;
  static bool removeFinger = false;
  static RxBool forceUpdate = false.obs;
  static RxBool showUpdateDialog = false.obs;

}
