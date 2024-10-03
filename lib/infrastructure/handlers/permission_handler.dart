


import 'dart:async';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionHandler {


  static Future<bool> checkStoragePermission() async {
    PermissionStatus status = PermissionStatus.denied;
    if (Platform.isAndroid) {
      final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
      final AndroidDeviceInfo info = await deviceInfoPlugin.androidInfo;
      if ((info.version.sdkInt) >= 33) {
        status = await Permission.manageExternalStorage.request();
      } else {
        status = await Permission.storage.request();
      }
    } else {
      status = await Permission.storage.request();
    }

    if (status case PermissionStatus.denied) {
      return false;
    } else if (status case PermissionStatus.granted) {
      return true;
    } else if (status case PermissionStatus.restricted) {
      return false;
    } else if (status case PermissionStatus.limited) {
      return true;
    } else if (status case PermissionStatus.permanentlyDenied) {
      return false;
    }

    return false;
  }

}