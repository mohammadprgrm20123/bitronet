import 'package:flutter/material.dart';

import '../../../infrastructure/theme/app_color.dart';
import 'app_text.dart';

class RulesWidget extends StatelessWidget {
  final bool checkRules;
  final void Function() onChange;
  final void Function()? onTap;

  const RulesWidget(
      {required this.checkRules,
      required this.onChange,
      super.key,
      this.onTap});

  @override
  Widget build(final BuildContext context) => GestureDetector(
    behavior: HitTestBehavior.translucent,
    onTap: onChange,
    child: Row(
          children: [
            Checkbox(
                value: checkRules,
                onChanged: (final value) {
                  onChange.call();
                }),
            GestureDetector(
              onTap: onTap,
              child: AppText.bodySmall(
                ' قوانین و مقررات  ',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: AppColor.primary,fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: AppText.bodySmall('را مطالعه کرده ام و آن را قبول دارم'),
            ),
          ],
        ),
  );
}
