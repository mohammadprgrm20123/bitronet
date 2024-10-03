import 'package:flutter/material.dart';

import '../../../infrastructure/theme/app_color.dart';

enum CardBankStatus {
  pending('در حال بررسی',AppColor.tritry),
  rejected('رد شده',AppColor.error),
  confirmed('تایید شده',AppColor.success);

  const CardBankStatus(this.title,this.color);

  final Color color;
  final String title;


  static CardBankStatus? convert(String status) {
    switch (status) {
      case 'CONFIRMED':
        return CardBankStatus.confirmed;
      case 'REJECTED':
        return CardBankStatus.rejected;
      case 'PENDING':
        return CardBankStatus.pending;
    }

    return CardBankStatus.pending;
  }
}
