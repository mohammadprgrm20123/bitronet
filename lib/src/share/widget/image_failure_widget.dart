import 'package:flutter/material.dart';

class ImageFailureWidget extends StatelessWidget {
  const ImageFailureWidget({
    required this.width,
    required this.height,
    this.onRetry,
    this.failureIcon,
    super.key,
  });

  final double width;
  final double height;
  final Widget? failureIcon;
  final void Function()? onRetry;

  @override
  Widget build(final BuildContext context) => onRetry != null
      ? GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onRetry,
          child: SizedBox(
            width: width,
            height: height,
            child: failureIcon ??
                const Icon(
                  Icons.refresh,
                ),
          ),
        )
      : SizedBox(
          width: width,
          height: height,
          child: failureIcon ??
              const Icon(
                Icons.error,
              ),
        );
}
