import 'package:flutter/material.dart';

import '../../../infrastructure/theme/app_color.dart';
import '../../../infrastructure/utils/utils.dart';
import 'app_text.dart';

class ColumnDataTitle extends StatelessWidget {
  final String title;
  final Widget textForm;
  final bool isRequired;

  const ColumnDataTitle({
    required this.title,
    required this.textForm,
    this.isRequired=false,
    super.key,
  });

  @override
  Widget build(final BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(

            children: [
              AppText(
                title,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
             if(isRequired) const AppText(' *',style: TextStyle(color: AppColor.error),),

            ],
          ),
          Utils.smallGap,
          textForm,
        ],
      );
}
