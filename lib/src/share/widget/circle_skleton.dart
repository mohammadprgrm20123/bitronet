
import 'package:flutter/material.dart';

class CircleSkeleton extends StatelessWidget {
  const CircleSkeleton({final Key? key, this.size = 24,this.color}) : super(key: key);

  final double? size;
  final Color? color;

  @override
  Widget build(final BuildContext context) => Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        color: color ?? Colors.white38.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
    );
}