import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../../infrastructure/utils/utils.dart';
import '../../../../share/widget/loading.dart';
import '../model/shift_model.dart';
import '../repository/main_tab_boss_repository.dart';

class MainTabBossController extends GetxController {
  final String workPLaceId;

  final MainTabBossRepository _repository = MainTabBossRepository();

  List<ShiftModel> shiftModels = <ShiftModel>[].obs;

  final PagingController<int, int> employeePagingController = PagingController(
    firstPageKey: 1,
  );
  final PagingController<int, ShiftModel> shiftPagingController =
      PagingController(
    firstPageKey: 1,
  );
  final PagingController<int, int> requestPagingController = PagingController(
    firstPageKey: 1,
  );

  MainTabBossController(this.workPLaceId);

  Future<void> deleteShift({required final String id}) async {
    WaitingDialog().show();
    final result = await _repository.deleteShift(id: id);

    result.fold((final e) => Utils.showErrorToast(errors: e.errors), (final r) {
      shiftPagingController.refresh();
    });

    WaitingDialog().hide();
  }

  Future<void> getAllShifts({required final String id}) async {
    final result = await _repository.getAllShifts(workPlaceId: id);

    result.fold((final e) => Utils.showErrorToast(errors: e.errors), (final r) {
      shiftPagingController.appendLastPage(r);
    });
  }

  @override
  void onInit() {
    employeePagingController.addPageRequestListener((final pageKey) {
      print(pageKey);
    });

    shiftPagingController.addPageRequestListener((final pageKey) {
      getAllShifts(id: workPLaceId);
    });

    requestPagingController.addPageRequestListener((final pageKey) {});

    super.onInit();
  }
}
