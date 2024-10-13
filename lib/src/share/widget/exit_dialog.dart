

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../infrastructure/theme/app_color.dart';
import '../../../infrastructure/utils/utils.dart';
import 'app_button.dart';
import 'app_text.dart';

class ExitDialog extends StatelessWidget {
  const ExitDialog({super.key});

  @override
  Widget build(final BuildContext context) => Dialog(
          insetPadding: const EdgeInsets.all(32),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                children: [
                  const AppText('آیا میخواهید از حساب کاربری خود خارج شوید؟'),
                  Utils.largeGap,
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
                          onPressed: () {
                            Utils.exitFromAccount();
                          },
                          text: 'خروج',
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