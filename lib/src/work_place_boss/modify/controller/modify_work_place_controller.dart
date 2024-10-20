import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:latlong2/latlong.dart';

import '../../../../infrastructure/utils/utils.dart';
import '../model/add_work_place_dto.dart';
import '../model/edit_work_place_dto.dart';
import '../repository/work_place_modify_repository.dart';

class ModifyWorkPlaceController extends GetxController {

  final WorkPlaceModifyRepository _repository = WorkPlaceModifyRepository();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  RxDouble corners = 0.0.obs;

  GlobalKey<FormState> formKey = GlobalKey();
  RxBool fixLocation = false.obs;

  LatLng? latLng = const LatLng(0, 0);


  Future<void> addWorkPlace(final AddWorkPlaceDto dto) async {
    final result = await _repository.addWorkPlace(dto);


    result.fold((r) => Utils.showErrorToast(errors: r.errors), (r) {
      Get.back(result: true);
      Utils.showSuccessToast(message: 'با موفقیت ثبت شد');

    });
  }


  Future<void> editWorkPlace(final EditWorkPlaceDto dto) async {
    final result = await _repository.editWorkPlace(dto);


    result.fold((r) => Utils.showErrorToast(errors: r.errors), (r) {
      Get.back(result: true);
      Utils.showSuccessToast(message: 'با موفقیت ویرایش شد');

    });
  }


}