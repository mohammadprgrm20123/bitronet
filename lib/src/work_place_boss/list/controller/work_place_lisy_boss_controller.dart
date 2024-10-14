import 'package:get/get.dart';

import '../../../../infrastructure/utils/utils.dart';
import '../../../share/widget/loading.dart';
import '../repository/work_place_list_repository.dart';

class WorkPlaceListBossController extends GetxController {
  final WorkPlaceListRepository _repository = WorkPlaceListRepository();

  RxBool showActive = false.obs;

  @override
  void onInit() {
    super.onInit();
    getAllWorkPLaces(isActive: showActive.value);
  }

  Future<void> getAllWorkPLaces({required final bool isActive}) async {
    WaitingDialog().show();

    final result = await _repository.getAllWorkPlace(isActive);

    result.fold(
        (final e) => Utils.showErrorToast(errors: e.errors), (final v) {});

    WaitingDialog().hide();
  }
}
