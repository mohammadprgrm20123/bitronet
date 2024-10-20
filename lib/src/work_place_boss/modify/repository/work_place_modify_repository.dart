import 'package:dartz/dartz.dart';

import '../../../../infrastructure/api_service/api_end_points.dart';
import '../../../../infrastructure/api_service/app_http_client.dart';
import '../../../../infrastructure/api_service/model/failure_model.dart';
import '../model/add_work_place_dto.dart';
import '../model/edit_work_place_dto.dart';

class WorkPlaceModifyRepository {
  final AppHttpClient _appHttpClient = AppHttpClient();

  Future<Either<FailureModel, void>> addWorkPlace(
      final AddWorkPlaceDto dto) async {
    final result = await _appHttpClient.post(ApiEndPoint.modifyWorkPlace,
        data: dto.toJson());

    return result.fold(Left.new, (r) => const Right(null));
  }

  Future<Either<FailureModel, void>> editWorkPlace(
      final EditWorkPlaceDto dto) async {
    final result = await _appHttpClient.post(ApiEndPoint.modifyWorkPlace,
        data: dto.toJson());

    return result.fold(Left.new, (r) => const Right(null));
  }
}
