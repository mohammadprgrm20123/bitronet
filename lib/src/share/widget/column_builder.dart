

import 'package:flutter/material.dart';
import '../../../infrastructure/utils/utils.dart';
import 'app_text.dart';

class ColumnBuilder extends StatelessWidget {
  final String title;
  final String value;
  final TextStyle? valueStyle;

  const ColumnBuilder({
    required this.title,
    required this.value,
    super.key,
    this.valueStyle,
  });

  @override
  Widget build(final BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppText.bodyMedium(
          title,
          style: style(context).copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 13,
              color: Colors.white),
        ),
        Utils.tinyGap,
        AppText(
          ' $value ',
          maxLines: 3,
          overflow: TextOverflow.visible,
          style: style(context).copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 13,
              color: Colors.white),
        )
      ],
    ),
  );

  TextStyle style(final BuildContext context) =>
      Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white);
}
