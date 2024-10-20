import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../infrastructure/utils/utils.dart';
import 'modify_work_place_controller.dart';

class SelectAddressController extends GetxController {
  TextEditingController completeAddressController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  MapController mapController = MapController();

  ModifyWorkPlaceController controller1 = Get.putOrFind(()=>ModifyWorkPlaceController());

  Rxn<LatLng> currentLocation = Rxn(null);
  Rxn<LatLng> markerLocation = Rxn(null);

  @override
  void onInit() async {
    final status = await Permission.locationWhenInUse.status;
    await Permission.locationWhenInUse.request();

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Utils.showInfoToast(text: 'برای ثبت لوکیشن نیاز به دسترس مکان هست');
      }
    }

    if (status.isGranted) {
      final position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      currentLocation.value = LatLng(position.latitude, position.longitude);
    }

    super.onInit();
  }
}
