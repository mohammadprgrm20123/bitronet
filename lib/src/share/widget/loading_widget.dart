import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingWidget extends StatelessWidget {
  final Color? color;

  const LoadingWidget({super.key, this.color});

  @override
  Widget build(final BuildContext context) {
    return LoadingAnimationWidget.staggeredDotsWave(
      size: 30,
      color: color ?? Colors.white,
    );
  }
}
