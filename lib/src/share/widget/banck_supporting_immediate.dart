import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../infrastructure/theme/app_color.dart';
import '../../../infrastructure/utils/utils.dart';
import '../model/local_bank_model.dart';
import 'app_text.dart';
import 'bank_icon.dart';


class BackSupportingImmediate extends StatelessWidget {
  final List<LocalBankModel> bankList;

  const BackSupportingImmediate({super.key, required this.bankList});

  @override
  Widget build(final BuildContext context) =>
      FadeIn(
        child: DecoratedBox(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColor.tritry),
              color: AppColor.tritry.withOpacity(0.1)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const AppText('بانک های پشتیبانی شده'),
                Utils.largeGap,
                Wrap(
                  runAlignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    ...bankList
                        .map((final e) =>
                    e.isPng
                        ? Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: AppColor.tritry),
                        ),
                        child: BankIcon(
                          model: e,
                        ),
                      ),
                    )
                        : Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: AppColor.tritry),
                        ),
                        child: BankIcon(
                          model: e,
                        ),
                      ),
                    ))
                        .toList()
                  ],
                ),
                Utils.mediumGap,
                const AppText(
                  'تسویه‌ی آنی فقط در روزهای کاری قابل انجام'
                      ' است. شما می‌توانید درخواست تسویه‌ی آنی خود را از شنبه تا چهارشنبه'
                      ' از ساعت ۹ صبح تا ۱۶ و روز پنجشنبه از ساعت ۹ صبح تا ۱۳ ثبت کنید. ضمنا '
                      'توجه داشته باشید که مبلغ 25,000 تومان بابت تسویه آنی از مبلغ نهایی کسر خواهد شد.',
                  overflow: TextOverflow.visible,
                )
              ],
            ),
          ),
        ),
      );
}
