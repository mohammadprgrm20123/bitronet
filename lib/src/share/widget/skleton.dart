import 'package:flutter/material.dart';

class AppSkeleton extends StatelessWidget {
  const AppSkeleton({Key? key, this.height, this.width}) : super(key: key);

  final double? height, width;

  @override
  Widget build(final BuildContext context) => Container(
      height: height,
      width: width,
      padding: const EdgeInsets.all(8 / 2),
      decoration: BoxDecoration(
          color:Colors.white38.withOpacity(0.1),
          borderRadius:
          const BorderRadius.all(Radius.circular(16))),
    );
}