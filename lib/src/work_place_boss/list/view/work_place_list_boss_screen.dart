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
        onPressed: () {},
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
                      TextStyle(fontSize: 14),
                      TextStyle(fontSize: 14)
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
                            .map((final e) => workPlaceItem(e, context))
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

  Widget workPlaceItem(final WorkPlaceModel e, final BuildContext context) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        child: Card(
          elevation: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        const Icon(Icons.location_city_outlined),
                        Utils.smallGap,
                        const AppText('نام شرکت : '),
                        AppText(
                          e.name ?? '',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  PopupMenuButton<int>(
                    onSelected: (final value) {
                      if (value == 0) {
                        showDialog(
                            context: context,
                            builder: (c) => DeleteDialog(onDelete: () {
                                  Get.backLegacy();
                                  controller.deleteWorkPlace(id: e.id);
                                }));
                      }
                      if (value == 2) {
                        controller.activationWorkPLace(id: e.id);
                      }
                    },
                    itemBuilder: (final context) => [
                      const PopupMenuItem<int>(
                        value: 0,
                        child: Row(
                          children: [
                            Icon(
                              Icons.delete_outline,
                              size: 20,
                              color: AppColor.error,
                            ),
                            Utils.tinyGap,
                            AppText('حذف'),
                          ],
                        ),
                      ),
                      PopupMenuItem<int>(
                        value: 1,
                        child: Row(
                          children: [
                            Icon(
                              Icons.edit_note_sharp,
                              size: 20,
                              color: AppColor.primary,
                            ),
                            Utils.tinyGap,
                            AppText('ویرایش'),
                          ],
                        ),
                      ),
                      PopupMenuItem<int>(
                        value: 2,
                        child: Row(
                          children: [
                            Icon(
                              Icons.circle,
                              size: 18,
                              color:
                                  e.active! ? AppColor.error : AppColor.success,
                            ),
                            Utils.tinyGap,
                            AppText(e.active! ? 'غیر فعال کردن' : 'فعال کردن'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: Row(
                  children: [
                    const Icon(Icons.share_location),
                    Utils.smallGap,
                    const AppText('محدوده قابل قبول  : '),
                    AppText(
                      ' شعاع ${e.coverRadius} متری ',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: AppColor.primary),
                    ),
                  ],
                ),
              ),
              Utils.smallGap,
              qrCode(context, e),
              Utils.mediumGap,
            ],
          ),
        ),
      );

  Widget qrCode(final BuildContext context, final WorkPlaceModel e) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          DecoratedBox(
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: AppText(
                  e.active! ? 'فعال' : 'غیر فعال',
                  style: TextStyle(
                      color: e.active! ? AppColor.success : AppColor.error,fontSize: 15),
                ),
              ),
              decoration: BoxDecoration(
                color: e.active!
                    ? AppColor.success.withOpacity(.1)
                    : AppColor.error.withOpacity(.1),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(4),
                    bottomLeft: Radius.circular(4)),
              )),
          InkWell(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: DecoratedBox(
                decoration: BoxDecoration(
                    color: AppColor.primary.withOpacity(.1),
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: AppColor.primary, width: 1)),
                child: const Icon(
                  Icons.qr_code,
                  size: 30,
                ),
              ),
            ),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (final c) => Dialog(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              DecoratedBox(
                                  decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(16),
                                          topLeft: Radius.circular(16)),
                                      color: AppColor.success),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: AppText.bodyLarge(
                                      e.name ?? '',
                                      style: const TextStyle(fontSize: 20),
                                      textAlign: TextAlign.center,
                                    ),
                                  )),
                              Column(
                                children: [
                                  Utils.mediumGap,
                                  QrImageView(
                                    data: e.shareKey.toString(),
                                    version: QrVersions.auto,
                                    size: 200.0,
                                  ),
                                  Utils.mediumGap,
                                  AppText(e.shareKey.toString()),
                                ],
                              )
                            ],
                          ),
                        ),
                      ));
            },
          ),

        ],
      );
}
