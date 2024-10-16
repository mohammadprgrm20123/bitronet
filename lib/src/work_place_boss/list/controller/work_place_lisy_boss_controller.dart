import 'package:get/get.dart';

import '../../../../infrastructure/utils/utils.dart';
import '../../../share/widget/loading.dart';
import '../models/work_place_model.dart';
import '../repository/work_place_list_repository.dart';

class WorkPlaceListBossController extends GetxController {
  final WorkPlaceListRepository _repository = WorkPlaceListRepository();

  RxBool showActive = true.obs;

  RxList<WorkPlaceModel> workPlaceList = <WorkPlaceModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getAllWorkPLaces(isActive: showActive.value);
  }

  Future<void> getAllWorkPLaces({required final bool isActive}) async {
    WaitingDialog().show();

    final result = await _repository.getAllWorkPlace(isActive);

    result.fold((final e) => Utils.showErrorToast(errors: e.errors), (final v) {
      workPlaceList.value = v;
    });

    WaitingDialog().hide();
  }

  Future<void> deleteWorkPlace({required final int id}) async {
    WaitingDialog().show();

    final result = await _repository.removeWorkPlace(id);

    result.fold(
            (final e) => Utils.showErrorToast(errors: e.errors), (final v) {
      Utils.showSuccessToast(message: 'کارگاه حذف شد');
      getAllWorkPLaces(isActive: showActive.value);
    });

    WaitingDialog().hide();
  }

  Future<void> activationWorkPLace({required final int id}) async {
    WaitingDialog().show();

    final result = await _repository.activationWorkPlace(id);

    result.fold(
        (final e) => Utils.showErrorToast(errors: e.errors), (final v) {
          Utils.showSuccessToast(message: showActive.value?'کارگاه غیر فعال شد':'کارگاه فعال شد');
          getAllWorkPLaces(isActive: showActive.value);

    });

    WaitingDialog().hide();
  }
}
