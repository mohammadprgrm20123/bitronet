import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../infrastructure/form_validations/form_validation_utils.dart';
import '../../../../infrastructure/routing/app_route_name.dart';
import '../../../../infrastructure/theme/app_color.dart';
import '../../../../infrastructure/utils/utils.dart';
import '../../../share/widget/app_bar.dart';
import '../../../share/widget/app_button.dart';
import '../../../share/widget/app_text.dart';
import '../../../share/widget/column_data_title.dart';
import '../../list/models/work_place_model.dart';
import '../controller/modify_work_place_controller.dart';
import '../model/add_work_place_dto.dart' as place;
import '../model/add_work_place_dto.dart';
import 'package:latlong2/latlong.dart';

import '../model/edit_work_place_dto.dart';

class ModifyWorkPlaceScreen extends GetView<ModifyWorkPlaceController> {
  final WorkPlaceModel? model;

  const ModifyWorkPlaceScreen({
    super.key,
    this.model,
  });

  @override
  Widget build(final BuildContext context) {
    Get.lazyPut(ModifyWorkPlaceController.new);

    if (model != null) {
      controller.companyNameController.text = model!.name ?? '';
      controller.fixLocation.value = model!.fixedPlace!;
      controller.corners.value = model!.coverRadius!.toDouble();

      if (model!.fixedPlace!) {
        controller.latLng = LatLng(
            model!.place!.lat!.toDouble(), model!.place!.lon!.toDouble());
        controller.locationController.text = controller.latLng.toString();
      }
    }

    return Scaffold(
      appBar: buildAppBar(title: 'ثبت کارگاه/شرکت'),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Utils.mediumGap,
              ColumnDataTitle(
                title: 'نام شرکت / کارگاه',
                isRequired: true,
                textForm: TextFormField(
                  controller: controller.companyNameController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (final value) => FormValidationUtils(validators: [
                    RequiredValidation(),
                  ]).validate(value),
                ),
              ),
              Utils.mediumGap,
              Obx(() => CheckboxListTile(
                  contentPadding: EdgeInsets.zero,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  controlAffinity: ListTileControlAffinity.leading,
                  title: const AppText('کارگاه محل ثابت دارد '),
                  tristate: true,
                  value: controller.fixLocation.value,
                  onChanged: (final v) {
                    controller.fixLocation.toggle();
                    controller.locationController.text = '';
                    controller.latLng = null;
                    controller.corners.value = 0;
                  })),
              Obx(() => controller.fixLocation.value
                  ? Column(
                      children: [
                        ColumnDataTitle(
                          title: 'محدوده قابل قبول از محل کار(شعاع):',
                          isRequired: true,
                          textForm: Obx(() => Row(
                                children: [
                                  AppText(
                                      'شعاع : ${controller.corners.value.toStringAsFixed(0)} متر '),
                                  Expanded(
                                    child: Slider(
                                        max: 200,
                                        label: 'شعاع',
                                        min: 0,
                                        divisions: 20,
                                        thumbColor: AppColor.tritry,
                                        value: controller.corners.value,
                                        onChanged: (final v) {
                                          controller.corners.value =
                                              v.truncateToDouble();
                                        }),
                                  ),
                                ],
                              )),
                        ),
                        Utils.largeGap,
                        FadeIn(
                          animate: true,
                          child: ColumnDataTitle(
                            title: 'آدرس / موقعیت جغرافیایی:',
                            isRequired: true,
                            textForm: TextFormField(
                              readOnly: true,
                              controller: controller.locationController,
                              onTap: () async {
                                if (model == null) {
                                  await Get.toNamed(
                                      AppRouteName.selectAddressRoute);
                                } else {
                                  await Get.toNamed(
                                      AppRouteName.editSelectAddressRoute);
                                }
                              },
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (final value) =>
                                  FormValidationUtils(validators: [
                                RequiredValidation(),
                              ]).validate(value),
                            ),
                          ),
                        ),
                      ],
                    )
                  : const SizedBox.shrink()),
              Utils.mediumGap,
              const Spacer(),
              AppButton(
                onPressed: () {
                  if (controller.formKey.currentState!.validate()) {
                    if (model != null) {
                      controller.editWorkPlace(EditWorkPlaceDto(
                          name: controller.companyNameController.text,
                          coverRadius: controller.corners.value.toInt(),
                          fixedPlace: controller.fixLocation.value,
                          place: controller.fixLocation.value
                              ? place.Place(
                                  lat: controller.latLng!.latitude,
                                  lon: controller.latLng!.longitude,
                                )
                              : null,
                          id: model!.id));
                    } else {
                      controller.addWorkPlace(AddWorkPlaceDto(
                          name: controller.companyNameController.text,
                          coverRadius: controller.corners.value.toInt(),
                          fixedPlace: controller.fixLocation.value,
                          place: controller.fixLocation.value
                              ? place.Place(
                                  lat: controller.latLng!.latitude,
                                  lon: controller.latLng!.longitude,
                                )
                              : null));
                    }
                  }
                },
                text: model == null ? 'ثبت کارگاه' : 'ویرایش کارگاه',
              )
            ],
          ),
        ),
      ),
    );
  }
}
