import 'package:flutter/material.dart';

import '../../../infrastructure/utils/utils.dart';
import 'app_button.dart';
import 'app_text.dart';

class RetryWidget extends StatelessWidget {
  const RetryWidget({
    required this.onRetry,
    this.message,
    this.padding,
    super.key,
  });

  final void Function() onRetry;
  final String? message;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(final BuildContext context) => Padding(
    padding: padding ??
        const EdgeInsets.symmetric(
          horizontal: Utils.giantSpace * 2.5,
        ),
    child: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppText.bodyMedium(
            message ?? 'مشکلی بوجود آمده است',
            textAlign: TextAlign.center,
          ),
          Utils.mediumGap,
          AppButton.outlined(
            onPressed: onRetry,
            text: 'تلاش مجدد',
            contentPadding: const EdgeInsets.symmetric(
              horizontal: Utils.smallSpace,
            ),
          ),
        ],
      ),
    ),
  );
}