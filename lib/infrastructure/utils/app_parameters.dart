import 'package:get/get.dart';

import '../../src/auth/splash/model/app_update_model.dart';
import '../../src/share/model/message_model.dart';
import '../../src/share/model/user_details_model.dart';

class AppParameters {
  static String? token = '';
  static int offset = 10;


  static int timer = 0;
  static Rxn<UserDetailsModel> userDetailsModel = Rxn(null);
  static Rxn<MessageModel> messagesModel = Rxn(null);
  static Rxn<AppUpdateModel> appUpdateModel = Rxn(null);
  static RxBool hasVpn = false.obs;
  static RxBool showPinLock = false.obs;
  static RxBool showFingerPrint = false.obs;
  static RxBool showFingerPrintAndPin = false.obs;
  static RxBool removePin = false.obs;
  static bool removeFinger = false;
  static RxBool forceUpdate = false.obs;
  static RxBool showUpdateDialog = false.obs;

  static String blogUrl = 'https://avalpardakht.com/blog/';

  static List<String> immediateWithdrawBanks = [
    'بانک ملی ایران',
    'بانک صادرات ایران',
    'بانک پاسارگاد',
    'بانک ملت',
    'بانک کشاورزی',
    'بانک تجارت',
    'بانک پارسیان',
    'بانک اقتصاد نوین',
    'بانک سامان',
    'بانک آینده',
    'بانک خاورمیانه',
    'بانک قرض الحسنه رسالت',
    'بانک شهر',
    'بانک کارآفرین',
  ];
}
