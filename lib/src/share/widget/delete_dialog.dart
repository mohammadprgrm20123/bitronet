import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../infrastructure/theme/app_color.dart';
import '../../../infrastructure/utils/utils.dart';
import 'app_button.dart';
import 'app_text.dart';

class DeleteDialog extends StatelessWidget {
  final void Function() onDelete;

  const DeleteDialog({
    required this.onDelete,
    super.key,
  });

  @override
  Widget build(final BuildContext context) => Dialog(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                AppText(
                  'ایا از حذف مطمعن هستید؟',
                  style: TextStyle(fontSize: 16),
                ),
                Utils.largeGap,
                Row(
                  children: [
                    Expanded(
                      child: AppButton.outlined(
                        borderRadius: 8,
                        height: 40,
                        onPressed: Get.backLegacy,
                        text: 'بازگشت',
                      ),
                    ),
                    Utils.mediumGap,
                    Expanded(
                      child: AppButton(
                        height: 40,
                        borderRadius: 8,
                        backgroundColor: AppColor.error.withOpacity(.9),
                        onPressed: onDelete,
                        text: 'حذف',
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
}
