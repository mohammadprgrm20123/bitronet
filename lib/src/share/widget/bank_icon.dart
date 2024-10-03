import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../model/local_bank_model.dart';
import 'logo_with_image.dart';

class BankIcon extends StatelessWidget {
  final LocalBankModel? model;
  final double? size;

  const BankIcon({
    this.model,
    this.size,
    super.key,
  });

  @override
  Widget build(final BuildContext context) => (model == null)
      ? const LogoImage()
      : model!.isPng
          ? Padding(
              padding: const EdgeInsets.all(4.0),
              child: Image.asset(
                'assets/banks/${model!.logo}',
                height: width(),
                width: width(),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(4.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: SvgPicture.asset(
                  'assets/banks/${model!.logo}',
                  allowDrawingOutsideViewBox: true,
                  width: width(),
                  height: width(),
                ),
              ),
            );

  double width() => size ?? 30.0;
}
