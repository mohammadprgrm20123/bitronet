import 'package:dartz/dartz.dart';

import '../../../infrastructure/api_service/api_end_points.dart';
import '../../../infrastructure/api_service/app_http_client.dart';
import '../../../infrastructure/api_service/model/failure_model.dart';
import '../../work_place_boss/list/models/work_place_model.dart';

mixin WorkPlaceRepository {
  final AppHttpClient _appHttpClient = AppHttpClient();



  Future<Either<FailureModel, List<WorkPlaceModel>>> getAllWorkPlace(
      final bool showActiveList) async {
    final result = await _appHttpClient
        .get('${ApiEndPoint.getAllWorkPlaces}?activeList=$showActiveList');

    return result.fold(Left.new, (final r) {
      final List<dynamic> list = r.data['msgData'];

      final List<WorkPlaceModel> models = [];

      for (final e in list) {
        models.add(WorkPlaceModel.fromJson(e));
      }

      return Right(models);
    });
  }
}
