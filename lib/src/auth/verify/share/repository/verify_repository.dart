import 'package:dartz/dartz.dart';

import '../../../../../infrastructure/api_service/api_end_points.dart';
import '../../../../../infrastructure/api_service/app_http_client.dart';
import '../../../../../infrastructure/api_service/model/failure_model.dart';
import '../model/resend_dto.dart';
import '../model/verify_dto.dart';
import '../model/verify_model.dart';

class VerifyRepository {
  final AppHttpClient _appHttpClient = AppHttpClient();

  Future<Either<FailureModel, VerifyModel>> verify(
      {required final VerifyDto dto}) async {
    final result =
        await _appHttpClient.post(ApiEndPoint.verifyCode, data: dto.toJson());

    return result.fold(Left.new,
        (final response) => Right(VerifyModel.fromJson(response.data)));
  }

  Future<Either<FailureModel, void>> resendCode(
      {required final ResendDto dto}) async {
    final result = await _appHttpClient.post(ApiEndPoint.resendVerifyCode,
        data: dto.toJson());

    return result.fold(Left.new, (final r) => const Right(null));
  }
}
