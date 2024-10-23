import 'package:get/get.dart';

import '../../../../../infrastructure/utils/utils.dart';
import '../../../../share/widget/loading.dart';
import '../model/add_shift_dto.dart';
import '../repository/modify_shift_repository.dart';

class ModifyShiftController extends GetxController {
  final ModifyShiftRepository _repository = ModifyShiftRepository();
  String id;

  ModifyShiftController(this.id);

  Future<void> addShift({required final AddShiftDto dto}) async {
    WaitingDialog().show();
    final result = await _repository.addShift(dto: dto);

    result.fold((final e) => Utils.showErrorToast(errors: e.errors), (final r) {
      Utils.showSuccessToast(message: 'با موفقیت ثبت شد');
      Get.back(result: true);
    });
    WaitingDialog().hide();
  }
}
