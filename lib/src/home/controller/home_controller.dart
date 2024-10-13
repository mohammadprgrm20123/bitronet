import 'package:get/get.dart';

import '../repositry/home_repository.dart';

class HomeController extends GetxController {
  final HomeRepository _repository = HomeRepository();

  @override
  void onInit() {
    super.onInit();
    getWorkPlaces(showActive: false);
    getUserDetails();
  }

  Future<void> getWorkPlaces({required final bool showActive}) async {
    final result = await _repository.getAllWorkPlace(showActive);

    result.fold((final e) {}, (final r) {});
  }

  Future<void> getUserDetails() async {
    final result = await _repository.getUserDetails();

    result.fold((final e) {}, (final r) {});
  }
}
