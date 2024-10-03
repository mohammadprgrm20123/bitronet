import 'package:dartz/dartz.dart';

import '../../../../infrastructure/api_service/api_end_points.dart';
import '../../../../infrastructure/api_service/app_http_client.dart';
import '../../../../infrastructure/api_service/model/failure_model.dart';
import '../../share/model/auth_model.dart';
import '../model/login_dto.dart';

class LoginRepository {
  final AppHttpClient _appHttpClient = AppHttpClient();

  Future<Either<FailureModel, AuthModel>> login(
      {required final LoginDto dto}) async {
    final result =
        await _appHttpClient.post(ApiEndPoint.loginApi, data: dto.toJson());

    return result.fold(
        Left.new,
        (final r) => Right(AuthModel.fromJson(r.data)));
  }
}
