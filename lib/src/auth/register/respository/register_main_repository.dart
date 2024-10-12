import 'package:dartz/dartz.dart';

import '../../../../../infrastructure/api_service/api_end_points.dart';
import '../../../../../infrastructure/api_service/app_http_client.dart';
import '../../../../../infrastructure/api_service/model/failure_model.dart';
import '../model/register_model.dart';

class MainRegisterRepository {
  final AppHttpClient _appHttpClient = AppHttpClient();

  Future<Either<FailureModel, void>> register(
      {required final RegisterDto dto}) async {
    final result =
        await _appHttpClient.post(ApiEndPoint.register, data: dto.toJson());

    return result.fold(
        Left.new, (final r) => const Right(null));
  }
}
