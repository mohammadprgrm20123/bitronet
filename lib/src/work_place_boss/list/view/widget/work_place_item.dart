import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../../../infrastructure/routing/app_route_name.dart';
import '../../../../../infrastructure/theme/app_color.dart';
import '../../../../../infrastructure/utils/utils.dart';
import '../../../../share/widget/app_text.dart';
import '../../../../share/widget/delete_dialog.dart';
import '../../controller/work_place_lisy_boss_controller.dart';
import '../../models/work_place_model.dart';

class WorkPlaceItem extends GetView<WorkPlaceListBossController> {
  final WorkPlaceModel model;

  const WorkPlaceItem({
    required this.model,
    super.key,
  });

  @override
  Widget build(final BuildContext context) => GestureDetector(
        onTap: () {
          Get.toNamed(AppRouteName.mainTabBossRoute(
              title: model.name ?? '', id: model.id.toString()));
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: Card(
            elevation: 3,
            color: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Utils.smallGap,
                Row(
                  children: [
                    DecoratedBox(
                        decoration: BoxDecoration(
                          color: model.active!
                              ? AppColor.success.withOpacity(.3)
                              : AppColor.error.withOpacity(.3),
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(4),
                              bottomLeft: Radius.circular(4)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: AppText(
                            model.active! ? 'فعال   ' : '  غیر فعال',
                            style: TextStyle(
                                color: model.active!
                                    ? AppColor.success
                                    : AppColor.error,
                                fontSize: 15),
                          ),
                        )),
                    const Spacer(),
                    PopupMenuButton<int>(
                      onSelected: (final value) async {
                        if (value == 0) {
                          await showDialog(
                              context: context,
                              builder: (final c) => DeleteDialog(onDelete: () {
                                    Get.backLegacy();
                                    controller.deleteWorkPlace(id: model.id);
                                  }));
                        }
                        if (value == 2) {
                          await controller.activationWorkPLace(
                              id: model.id, isActive: !model.active!);
                        }

                        if (value == 1) {
                          final result = await Get.toNamed(
                              AppRouteName.editWorkPlaceRoute,
                              arguments: model);

                          if (result != null && result is bool) {
                            if (result == true) {
                              await controller.getAllWorkPLaces(
                                  isActive: controller.showActive.value);
                            }
                          }
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
                        const PopupMenuItem<int>(
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
                                color: model.active!
                                    ? AppColor.error
                                    : AppColor.success,
                              ),
                              Utils.tinyGap,
                              AppText(model.active!
                                  ? 'غیر فعال کردن'
                                  : 'فعال کردن'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 4),
                      child: Row(
                        children: [
                          const Icon(Icons.location_city_outlined),
                          Utils.smallGap,
                          const AppText('نام شرکت : '),
                          AppText(
                            model.name ?? '',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                  child: Row(
                    children: [
                      const Icon(Icons.share_location),
                      Utils.smallGap,
                      const AppText('محدوده قابل قبول  : '),
                      if (model.fixedPlace!)
                        AppText(
                          ' شعاع ${model.coverRadius} متری ',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColor.primary),
                        )
                      else
                        const AppText(
                          ' محل ثابتی ندارد ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent),
                        ),
                    ],
                  ),
                ),
                Utils.smallGap,
                qrCode(context, model),
                Utils.mediumGap,
              ],
            ),
          ),
        ),
      );

  Widget qrCode(final BuildContext context, final WorkPlaceModel e) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Spacer(),
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
                                      color: AppColor.primary),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: AppText.bodyLarge(
                                      ' نام شرکت/کارگاه :${e.name}' ?? '',
                                      style: const TextStyle(
                                          fontSize: 15, color: Colors.white),
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
                                  Utils.mediumGap,
                                  Utils.mediumGap,
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
