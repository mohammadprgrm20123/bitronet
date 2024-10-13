import 'package:dartz/dartz.dart';

import '../../../../infrastructure/api_service/api_end_points.dart';
import '../../../../infrastructure/api_service/app_http_client.dart';
import '../../../../infrastructure/api_service/model/failure_model.dart';
import '../../share/model/auth_model.dart';
import '../model/login_dto.dart';

class LoginRepository {
  final AppHttpClient _appHttpClient = AppHttpClient();


  Future<Either<FailureModel, String>> sendLoginCode(
      {required final String mobile}) async {
    final result = await _appHttpClient
        .post(ApiEndPoint.sendLoginCode, data: {'Mobile': mobile});

    return result.fold(Left.new, (final r) => Right(r.data['msgName']));
  }

}
