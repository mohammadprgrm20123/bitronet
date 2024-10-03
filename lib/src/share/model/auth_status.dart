import 'package:flutter/material.dart';

import '../../../infrastructure/theme/app_color.dart';

enum AuthStatus {
  init(Colors.grey,'لطفا تمام اطلاعات خود را تایید کنید',null),
  cancel(AppColor.error,'لطفا تمام اطلاعات خود را تایید کنید',null),
  confirmed(AppColor.success,'اطلاعات تایید شده است',Icons.check_circle),
  rejected(AppColor.error,'لطفا تمام اطلاعات خود را تایید کنید',null),
  pending(AppColor.tritry,'اطلاعات شما در حال بررسی است',Icons.timelapse_sharp);

  final Color color;
  final String message;
  final IconData? icon;

  const AuthStatus(this.color,this.message,this.icon);

  static AuthStatus convert(final String value) {
    switch (value) {
      case 'INIT':
        return AuthStatus.init;
      case 'CANCELED':
        return AuthStatus.cancel;
      case 'PENDING':
        return AuthStatus.pending;
      case 'REJECTED':
        return AuthStatus.rejected;
      case 'CONFIRMED':
        return AuthStatus.confirmed;
    }

    return AuthStatus.init;
  }
}
