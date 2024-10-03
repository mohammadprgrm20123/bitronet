import 'package:flutter/cupertino.dart';

import '../../../infrastructure/theme/app_color.dart';
import '../../../infrastructure/utils/utils.dart';
import '../model/cash_service_model.dart';
import 'app_button.dart';
import 'app_text.dart';

class CashServiceItem extends StatelessWidget {
  final CashServiceData model;
  final void Function() onTap;

  const CashServiceItem({
    required this.model,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(final BuildContext context) => GestureDetector(
    onTap: onTap,
    child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: AppColor.secondary2,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Utils.mediumGap,
                  Expanded(
                      child: AppText.bodyMedium(
                          'فروش ${model.name} به اول پرداخت ')),
                  AppButton.filled(
                    borderRadius: 8,
                    onPressed: onTap,
                    height: 35,
                    contentPadding: const EdgeInsets.all(8),
                    child: const AppText(' فروش '),
                  ),
                ],
              ),
            ),
          ),
        ),
  );
}
