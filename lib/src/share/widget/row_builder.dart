import 'package:flutter/material.dart';
import 'app_text.dart';

class RowBuilder extends StatelessWidget {
  final String title;
  final Widget? valueWidget;
  final String value;
  final int titleFlex;
  final int valueFlex;
  final TextStyle? valueStyle;

  const RowBuilder({
    required this.title,
    required this.value,
    this.valueWidget,
    this.titleFlex = 1,
    this.valueFlex = 0,
    super.key,
    this.valueStyle,
  });

  @override
  Widget build(final BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          children: [
            Expanded(
                flex: titleFlex,
                child: AppText.bodyMedium(
                  title,
                  style: style(context).copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: Colors.white),
                )),
            Expanded(
              flex: valueFlex,
              child: valueWidget ??
                  AppText(
                    ' $value ',
                    maxLines: 3,
                    overflow: TextOverflow.visible,
                    style: valueStyle ??
                        style(context).copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            color: Colors.white),
                  ),
            )
          ],
        ),
      );

  TextStyle style(final BuildContext context) =>
      Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white);
}