import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';

import '../model/level_status.dart';
import 'app_text.dart';
import 'svg_icon.dart';

class LevelWidget extends StatelessWidget {
  final LevelStatus status;

  const LevelWidget({
    required this.status,
    super.key,
  });

  @override
  Widget build(final BuildContext context) => Row(
        children: [
          Swing(
            child: SvgIcon(
              name: 'medal',
              color: status.color,
              size: 20,
            ),
          ),
          AppText
            (
            status.title,
            style: TextStyle(color: status.color),
          )
        ],
      );
}
