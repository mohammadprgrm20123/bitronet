import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../infrastructure/theme/app_color.dart';
import '../../../../infrastructure/utils/utils.dart';
import '../../../share/widget/app_button.dart';
import '../../../share/widget/app_text.dart';
import '../controller/select_Address_controller.dart';

class SelectedAddressScreen extends StatefulWidget {
  const SelectedAddressScreen({super.key});

  @override
  State<SelectedAddressScreen> createState() => _SelectedAddressScreenState();
}

class _SelectedAddressScreenState extends State<SelectedAddressScreen> {
  final controller = Get.put(SelectAddressController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(final BuildContext context) => PopScope(
        canPop: false,
        onPopInvoked: (c) async {
          print('willPop');
          if (controller.markerLocation.value != null) {
            controller.controller1.latLng = controller.markerLocation.value!;
            controller.controller1.locationController.text =
                '${controller.markerLocation.value!.latitude} , ${controller.markerLocation.value!.longitude}';
          }

          if (c) return;

          Navigator.of(context).pop();
        },
        child: Scaffold(
            floatingActionButton: FloatingActionButton(
              backgroundColor: AppColor.tritry,
              onPressed: () async {
                print('dsdsdsdsds');
                final status = await Permission.locationWhenInUse.status;
                await Permission.locationWhenInUse.request();

                LocationPermission permission =
                    await Geolocator.checkPermission();
                if (permission == LocationPermission.denied) {
                  permission = await Geolocator.requestPermission();
                  if (permission == LocationPermission.denied) {
                    Utils.showInfoToast(
                        text: 'برای ثبت لوکیشن نیاز به دسترس مکان هست');
                    return Future.error('Location permissions are denied');
                  }
                }

                if (status.isGranted) {
                  final position = await Geolocator.getCurrentPosition(
                      desiredAccuracy: LocationAccuracy.high);
                  controller.currentLocation.value =
                      LatLng(position.latitude, position.longitude);

                  print(position.toString());
                  print(controller.currentLocation.value);
                  controller.mapController.move(controller.currentLocation.value!, 5);
                  setState(() {});
                }
              },
              child: const Icon(Icons.my_location, color: AppColor.primary),
            ),
            body: Obx(() => Stack(
                  children: [
                    Obx(
                      () => FlutterMap(
                        mapController: controller.mapController,
                        options: MapOptions(

                          initialCenter: controller.currentLocation.value ==
                                  null
                              ? const LatLng(32.4279, 53.6880)
                              : LatLng(
                                  controller.currentLocation.value!.latitude,
                                  controller.currentLocation.value!.longitude),
                          initialZoom: 5,
                          onTap: (final _, final p) async {
                            print('Tapppp');
                            controller.markerLocation.value =
                                LatLng(p.latitude, p.longitude);

                            controller.markerLocation.refresh();
                          },
                          interactionOptions: const InteractionOptions(
                            flags:
                                InteractiveFlag.all & ~InteractiveFlag.rotate,
                          ),
                        ),
                        children: [
                          TileLayer(
                            urlTemplate:
                                'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                          ),
                          Obx(() => MarkerLayer(
                              markers: controller.markerLocation.value == null
                                  ? []
                                  : [
                                      Marker(
                                          alignment: Alignment.topCenter,
                                          point:
                                              controller.markerLocation.value!,
                                          child: const Icon(
                                            Icons.location_on,
                                            size: 40,
                                            color: AppColor.error,
                                          )),
                                    ])),
                        ],
                      ),
                    ),
                    if (controller.markerLocation.value != null)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                              color: AppColor.primary.withOpacity(.1),
                              borderRadius: BorderRadius.circular(15)),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Utils.largeGap,
                              AppText('طول و عرض جغرافیایی :'),
                              AppText(
                                  'lat : ${controller.markerLocation.value?.latitude} \n  lng: ${controller.markerLocation.value?.longitude}'),
                            ],
                          ),
                        ),
                      ),
                  ],
                ))),
      );
}
