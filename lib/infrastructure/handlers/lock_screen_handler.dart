

import 'package:get_secure_storage/get_secure_storage.dart';

import '../utils/app_parameters.dart';
import '../utils/key_parameters.dart';

class LockScreenHandler {


  static void lockScreen(){
    final box = GetSecureStorage();

    if (box.read(KeyParameters.fingerLock) != null &&
        box.read(KeyParameters.pinLock) != null) {
      AppParameters.showFingerPrintAndPin.value = true;
      AppParameters.showPinLock.value = false;
      AppParameters.showFingerPrint.value = false;
    } else {
      AppParameters.showFingerPrintAndPin.value = false;
      if (box.read(KeyParameters.pinLock) == null) {
        AppParameters.showPinLock.value = false;
      } else {
        AppParameters.showPinLock.value = true;
      }

      if (box.read(KeyParameters.fingerLock) == null) {
        AppParameters.showFingerPrint.value = false;
      } else {
        AppParameters.showFingerPrint.value = true;
      }
    }
  }

}