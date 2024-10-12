import 'package:dio/dio.dart';
import 'package:get/get.dart' as getx;
import 'package:get_secure_storage/get_secure_storage.dart';

import '../handlers/timer_handler.dart';
import '../routing/app_route_name.dart';
import '../utils/app_parameters.dart';
import '../utils/key_parameters.dart';

class AppInterceptor extends Interceptor {
  static const int _userNotValidStatusCode = 403;
  static const String invalidTokenResponse =
      'Failed to validate your account credentials. Please login again';

  @override
  void onError(
    final DioException err,
    final ErrorInterceptorHandler handler,
  ) async {
    if (err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.receiveTimeout ||
        err.type == DioExceptionType.sendTimeout ||
        err.type == DioExceptionType.connectionError ||
        err.type == DioExceptionType.unknown) {
      final response = Response(
        requestOptions: RequestOptions(path: ''),
        data: err.error,
        statusCode: 400,
      );

      super.onError(
        err.copyWith(response: response),
        handler,
      );
    }

    if (err.response == null) {
      final response = Response(
        requestOptions: RequestOptions(path: ''),
        data: err.error,
        statusCode: 400,
      );

      super.onError(
        err.copyWith(response: response),
        handler,
      );
    } else {
      if (err.response!.statusCode.toString() == '429') {
        handler.next(err);
      }

      if (err.response!.statusCode.toString() == '500') {}

      if (err.response!.statusCode == _userNotValidStatusCode) {
        _logout();
      }

      if (err.response!.statusCode.toString() == '401') {
        await getx.Get.offAllNamed(AppRouteName.loginRoute);
        final box = GetSecureStorage();
        await box.remove(KeyParameters.tokenKey);
        TimerHandler.stop();
        handler.next(err);
      }

      super.onError(err, handler);
    }
  }

  @override
  void onResponse(
      final Response response, final ResponseInterceptorHandler handler) {
    print(response.data['msgID']);
    if (response.data['msgID'] == 1) {
      return handler.next(response);
    } else {
      return handler.reject(DioException(
          type: DioExceptionType.badResponse,
          error: {
            'errors': [
              '${response.data['msgName']}',
              '${response.data['msgDescription']}'
            ]
          },
          message: 'Has Error',
          requestOptions: response.requestOptions,
          response: Response(data: {
            'errors': [
              '${response.data['msgName']}',
            ]
          }, requestOptions: response.requestOptions)));
    }

    super.onResponse(response, handler);
  }

  @override
  void onRequest(
    final RequestOptions options,
    final RequestInterceptorHandler handler,
  ) async {
    options.headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'pop-scope-q': true,
      'x-scope': 'avalpardakht-web-application',
      'Authorization': 'Bearer ${AppParameters.token}',
      'X-Requested-With': 'XMLHttpRequest',
    };
    handler.next(options);
  }

  void _logout() {}
}
