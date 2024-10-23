import '../../../../infrastructure/routing/app_route_name.dart';
import '../../../share/widget/delete_dialog.dart';
import '../models/work_place_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shimmer/shimmer.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../../../infrastructure/theme/app_color.dart';
import '../../../../infrastructure/utils/utils.dart';
import '../../../share/widget/app_bar.dart';
import '../../../share/widget/app_text.dart';
import '../controller/work_place_lisy_boss_controller.dart';
import 'widget/work_place_item.dart';

class WorkPlaceListBossScreen extends GetView<WorkPlaceListBossController> {
  const WorkPlaceListBossScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    Get.lazyPut(WorkPlaceListBossController.new);
    controller.showActive.value;
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColor.tritry,
        label: const AppText(
          'کارگاه جدید',
          style: TextStyle(color: Colors.white),
        ),
        icon: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () async {
          final result = await Get.toNamed(AppRouteName.addWorkPlaceRoute);

          if (result != null && result is bool) {
            if (result == true) {
              controller.showActive.value = true;
              controller.showActive.refresh();
              await controller.getAllWorkPLaces(
                  isActive: controller.showActive.value);
            }
          }
        },
      ),
      appBar: buildAppBar(title: 'لیست کارگاه ها'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Utils.mediumGap,
          Center(
            child: Obx(() => Directionality(
                  textDirection: TextDirection.ltr,
                  child: ToggleSwitch(
                    minWidth: MediaQuery.of(context).size.width,
                    minHeight: 40.0,
                    fontSize: 16.0,
                    initialLabelIndex: controller.showActive.value ? 1 : 0,
                    activeBgColor: [AppColor.primary],
                    activeFgColor: Colors.white,
                    inactiveBgColor: AppColor.primary.withOpacity(.2),
                    inactiveFgColor: Colors.grey[900],
                    totalSwitches: 2,
                    animate: true,
                    customTextStyles: [
                      const TextStyle(fontSize: 14),
                      const TextStyle(fontSize: 14)
                    ],
                    labels: const ['کارگاه غیر فعال', 'کارگاه  فعال'],
                    onToggle: (final index) {
                      controller.showActive.value = index == 0 ? false : true;
                      controller.showActive.refresh();
                      controller.getAllWorkPLaces(
                          isActive: controller.showActive.value);
                    },
                  ),
                )),
          ),
          Utils.largeGap,
          Expanded(
            child: Obx(() => controller.workPlaceList.isEmpty
                ? const Center(child: Text('کارگاهی وجود ندارد'))
                : RefreshIndicator(
                    onRefresh: () async {
                      await controller.getAllWorkPLaces(
                          isActive: controller.showActive.value);
                    },
                    child: ListView(
                      children: [
                        ...controller.workPlaceList
                            .map((final e) => WorkPlaceItem(model: e,))
                            .toList(),
                        Utils.giantGap,
                        Utils.giantGap,
                        Utils.giantGap,
                        Utils.giantGap,
                      ],
                    ),
                  )),
          ),
        ],
      ),
    );
  }

}
