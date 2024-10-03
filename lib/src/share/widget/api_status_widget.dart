

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../infrastructure/api_service/model/failure_model.dart';
import '../model/api_status.dart';
import 'loading_widget.dart';
import 'retry_widget.dart';

class ApiStatusWidget<T> extends StatelessWidget {
  final void Function() onRetry;
  final Rx<ApiStatus<T>> apiStatus;
  final Widget Function()? onLoading;
  final Widget Function()? onIdle;
  final Widget Function(T result) onSuccess;
  final Widget Function(
      FailureModel message,
      void Function() onRetry,
      )? onFailure;

  const ApiStatusWidget({
    required this.apiStatus,
    required this.onSuccess,
    required this.onRetry,
    this.onIdle,
    this.onLoading,
    this.onFailure,
    final Key? key,
  }) : super(key: key);

  @override
  Widget build(final BuildContext context) => Obx(
        () => apiStatus.value.when(
      idle: onIdle ?? () => const SizedBox.shrink(),
      success: onSuccess,
      failure: (final message) =>
      onFailure?.call(message, onRetry) ??
          RetryWidget(
            onRetry: onRetry,
            message: 'مشکلی بوجود آمده است',
          ),
      loading: () => onLoading?.call() ?? const LoadingWidget(),
    ),
  );
}