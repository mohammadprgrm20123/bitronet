import 'package:dartz/dartz.dart';

import '../../../../../infrastructure/api_service/api_end_points.dart';
import '../../../../../infrastructure/api_service/app_http_client.dart';
import '../../../../../infrastructure/api_service/model/failure_model.dart';
import '../model/shift_model.dart';

class MainTabBossRepository {
  final AppHttpClient _appHttpClient = AppHttpClient();

  Future<Either<FailureModel, List<ShiftModel>>> getAllShifts(
      {required final String workPlaceId}) async {
    final result = await _appHttpClient
        .get('${ApiEndPoint.getAllShifts}?workplaceID=$workPlaceId');

    return result.fold(Left.new, (final r) {
      final List<dynamic> list = r.data['msgData'];
      final List<ShiftModel> models = [];

      for (final e in list) {
        models.add(ShiftModel.fromJson(e));
      }
      return Right(models);
    });
  }

  Future<Either<FailureModel, void>> deleteShift(
      {required final String id}) async {
    final result =
    await _appHttpClient.post('${ApiEndPoint.deleteShift}?id=$id');

    return result.fold(Left.new, (final r) => const Right(null));
  }
}
