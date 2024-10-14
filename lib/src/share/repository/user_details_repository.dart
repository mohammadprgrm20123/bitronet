import 'package:dartz/dartz.dart';

import '../../../infrastructure/api_service/api_end_points.dart';
import '../../../infrastructure/api_service/app_http_client.dart';
import '../../../infrastructure/api_service/model/failure_model.dart';

mixin UserDetailsRepository {
  final AppHttpClient _appHttpClient = AppHttpClient();

  Future<Either<FailureModel, void>> getUserDetails() async {
    final result = await _appHttpClient.post(ApiEndPoint.getUseDetails);

    return result.fold(Left.new, (final r) => const Right(null));
  }
}
