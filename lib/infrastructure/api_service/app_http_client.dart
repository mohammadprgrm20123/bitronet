import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import '../env/base_env.dart';
import 'app_interceptor.dart';
import 'logger_interceptor.dart';
import 'model/failure_model.dart';

class AppHttpClient {
  final Dio dio;
  final Left<String, Response<T>> Function<T>(
    DioException dioError,
  )? exceptionHandler;

  AppHttpClient({
    this.exceptionHandler,
  }) : dio = Dio(
          BaseOptions(
            baseUrl: ProductionEnv().getBaseUrl(),
            connectTimeout: const Duration(milliseconds: 20000),
            receiveTimeout: const Duration(milliseconds: 20000),
          ),
        ) {

    (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () =>
        HttpClient()
          ..badCertificateCallback =
              (final cert, final host, final port) => true;

    dio.interceptors.addAll([
      AppInterceptor(),
      if (kDebugMode)
        PrettyDioLogger(
            requestBody: true,
            requestHeader: true,
            request: true,
            responseBody: true,
            responseHeader: true),
    ]);
  }

  Future<Either<FailureModel, Response<T>>> get<T>(
    final String path, {
    final Map<String, dynamic>? queryParameters,
    final dynamic data,
    final Options? options,
    final CancelToken? cancelToken,
    final ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final res = await dio.get<T>(
        path,
        cancelToken: cancelToken,
        data: data,
        onReceiveProgress: onReceiveProgress,
        options: options,
        queryParameters: queryParameters,
      );

      return Right(res);
    } on DioException catch (dioError) {
      return _defaultExceptionHandler<T>(dioError);
    }
  }

  Future<Either<FailureModel, Response<T>>> post<T>(
    final String path, {
    final Map<String, dynamic>? queryParameters,
    final Options? options,
    final dynamic data,
    final CancelToken? cancelToken,
    final ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final res = await dio.post<T>(
        path,
        data: data,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
        options: options,
        queryParameters: queryParameters,
      );

      return Right(res);
    } on DioException catch (dioError) {
      return _defaultExceptionHandler<T>(dioError);
    }
  }

  Future<Either<FailureModel, Response<T>>> put<T>(
    final String path, {
    final Map<String, dynamic>? queryParameters,
    final Options? options,
    final dynamic data,
    final CancelToken? cancelToken,
    final ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final res = await dio.put<T>(
        path,
        data: data,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
        options: options,
        queryParameters: queryParameters,
      );

      return Right(res);
    } on DioException catch (dioError) {
      return _defaultExceptionHandler<T>(dioError);
    }
  }

  Future<Either<FailureModel, Response<T>>> patch<T>(
    final String path, {
    final Map<String, dynamic>? queryParameters,
    final Options? options,
    final dynamic data,
    final CancelToken? cancelToken,
    final ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final res = await dio.patch<T>(
        path,
        data: data,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
        options: options,
        queryParameters: queryParameters,
      );

      return Right(res);
    } on DioException catch (dioError) {
      return _defaultExceptionHandler<T>(dioError);
    }
  }

  Future<Either<dynamic, Response<T>>> delete<T>(
    final String path, {
    final Map<String, dynamic>? queryParameters,
    final Options? options,
    final dynamic data,
    final CancelToken? cancelToken,
  }) async {
    try {
      final res = await dio.delete<T>(
        path,
        data: data,
        cancelToken: cancelToken,
        options: options,
        queryParameters: queryParameters,
      );

      return Right(res);
    } on DioException catch (dioError) {
      return _defaultExceptionHandler<T>(dioError);
    }
  }

  Left<FailureModel, Response<T>> _defaultExceptionHandler<T>(
    final DioException dioError,
  ) {
    final List<String> errorList = [];




    if (dioError.type == DioExceptionType.connectionError ||
        DioExceptionType.connectionTimeout == dioError.type) {
      errorList.add('خطا در اتصال ...');
    } else {
      if (dioError.response != null) {
        if (dioError.response?.data != null) {
          if (dioError.response?.data['errors'] != null) {
            final newMap = dioError.response?.data['errors'];

            if (newMap is List) {
              for (final element in newMap) {
                errorList.add(element);
              }
            }

            if (newMap is String) {
              errorList.add(newMap);
            }
            if (newMap is Map) {
              newMap.forEach((final key, final value) {
                if (value is List) {
                  for (final element in value) {
                    if (element is List) {
                      errorList.addAll(element.cast<String>().toList());
                    } else {
                      errorList.add(element);
                    }
                  }
                } else {
                  errorList.add(value);
                }
              });
            }
          } else {
            errorList.add('خطای نامشخص ');
          }
        } else {
          errorList.add('خطا ناشناس');
        }
      } else {
        errorList.add(defaultErrorMessage);
      }
    }

    final errorModel = FailureModel(
        errors: errorList, statusCode: dioError.response?.statusCode);


    debugPrint(errorModel.errors.toString());

    return Left(errorModel);
  }

  String get defaultErrorMessage => 'مشکلی پیش آمده است';
}
