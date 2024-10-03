import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

import '../../../infrastructure/api_service/model/failure_model.dart';
import '../../../infrastructure/utils/utils.dart';
import '../model/api_status.dart';
import 'rx_listener.dart';

class ApiStatusListener<T> extends StatelessWidget {
  const ApiStatusListener({
    required this.apiStatus,
    required this.child,
    this.onSuccess,
    this.onFailure,
    this.onLoading,
    super.key,
  }); /*: assert(
          onSuccess != null || onFailure != null,
          '''Incorrect use of ApiStatusListener, at least one of onSuccess or onFailure methods should be provided''',
        );*/

  final void Function(FailureModel message)? onFailure;
  final void Function(T result)? onSuccess;
  final void Function()? onLoading;
  final Rx<ApiStatus<T>> apiStatus;
  final Widget child;

  void _onStatusChanged(final ApiStatus<T> apiStatus) => apiStatus.maybeWhen(
        orElse: ()=> null,
        loading: () => onLoading?.call(),
        failure: (final message) => onFailure == null
            ? Utils.showErrorToast(errors: message.errors)
            : onFailure?.call(message),
        success: (final result) => onSuccess?.call(result),
      );

  @override
  Widget build(final BuildContext context) => RxListener<ApiStatus<T>>(
        listenable: apiStatus,
        onChanged: _onStatusChanged,
        child: child,
      );
}
