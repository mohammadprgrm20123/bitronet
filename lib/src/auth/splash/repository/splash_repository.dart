import 'package:dartz/dartz.dart';

import '../../../../infrastructure/api_service/api_end_points.dart';
import '../../../../infrastructure/api_service/app_http_client.dart';
import '../../../../infrastructure/api_service/model/failure_model.dart';
import '../model/app_update_model.dart';
import '../model/device_type.dart';

class SplashRepository {
  final AppHttpClient _appHttpClient = AppHttpClient();

  Future<Either<FailureModel, AppUpdateModel>> getAppUpdateInfo(
      {required final DeviceType type}) async {
    final result = await _appHttpClient.get(ApiEndPoint.getVersion(type.name));

    return result.fold(
        Left.new, (final r) => Right(AppUpdateModel.fromJson(r.data)));
  }
}
