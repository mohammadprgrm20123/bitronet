import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';

import '../../../infrastructure/theme/app_color.dart';
import 'svg_icon.dart';

class LogoWithImage extends StatelessWidget {
  const LogoWithImage({super.key});

  @override
  Widget build(final BuildContext context) => Row(
    children: [
      const Spacer(),
      FadeInDownBig(
        key: UniqueKey(),
        child: Image.asset(
          'assets/images/bitronet.png',
          width: 150,
        ),
      ),
      const Spacer(),
    ],
  );
}

class LogoImage extends StatelessWidget {
  const LogoImage({super.key});

  @override
  Widget build(final BuildContext context) => const SvgIcon(
        name: 'logo',
        size: 20,
        color: AppColor.primary,
      );
}
