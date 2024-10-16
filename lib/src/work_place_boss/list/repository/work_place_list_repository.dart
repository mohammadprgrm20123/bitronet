

import 'package:dartz/dartz.dart';

import '../../../../infrastructure/api_service/api_end_points.dart';
import '../../../../infrastructure/api_service/app_http_client.dart';
import '../../../../infrastructure/api_service/model/failure_model.dart';
import '../../../share/repository/work_place_repository.dart';

class WorkPlaceListRepository  with WorkPlaceRepository{

  final AppHttpClient _appHttpClient = AppHttpClient();


  Future<Either<FailureModel, void>> activationWorkPlace(
      final int id) async {
    final result = await _appHttpClient
        .post('${ApiEndPoint.activationWorkPlace}?id=$id');

    return result.fold(Left.new, (final r) => const Right(null));
  }

  Future<Either<FailureModel, void>> removeWorkPlace(
      final int id) async {
    final result = await _appHttpClient
        .post('${ApiEndPoint.removeWorkPlace}?id=$id');

    return result.fold(Left.new, (final r) => const Right(null));
  }

}