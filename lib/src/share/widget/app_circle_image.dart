
import 'dart:io';

import 'package:flutter/material.dart';
import 'app_network_image.dart';
import 'image_failure_widget.dart';

class AppCircleImage extends StatelessWidget {
  final String? url;
  final double size;
  final String? assetPath;
  final File? file;
  final Widget? failureIcon;
  final Widget Function()? placeHolderBuilder;
  final bool useCache;

  const AppCircleImage({
    this.url,
    this.assetPath,
    this.size = 60,
    super.key,
    this.file,
    this.failureIcon,
    this.placeHolderBuilder,
    this.useCache = true,
  });

  @override
  Widget build(final BuildContext context) {
    late Widget image;
    if (url != null) {
      image = AppNetworkImage(
              url: url!,
              height: size,
              width: size,
        fit: BoxFit.fill,
        failureIcon: failureIcon,
            );
    } else if (assetPath != null) {
      image = Image.asset(
        assetPath!,
        fit: BoxFit.cover,
        errorBuilder: (
          final context,
          final _,
          final __,
        ) =>
            ImageFailureWidget(
          width: size,
          height: size,
          failureIcon: failureIcon,
        ),
        width: size,
        height: size,
      );
    } else if (file != null) {
      image = Image.file(
        file!,
        fit: BoxFit.cover,
        errorBuilder: (
          final context,
          final _,
          final __,
        ) =>
            ImageFailureWidget(
          width: size,
          height: size,
          failureIcon: failureIcon,
        ),
        width: size,
        height: size,
      );
    } else {
      image = SizedBox(
        height: size,
        width: size,
        child: placeHolderBuilder?.call(),
      );
    }

    return ClipRRect(
      borderRadius: const BorderRadius.all(
        Radius.circular(
          100000,
        ),
      ),
      child: ColoredBox(
        color: Colors.white.withOpacity(.1),
        child: InkResponse(
          enableFeedback: true,
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: ClipRRect(
                borderRadius: const BorderRadius.all(
            Radius.circular(
            100000,
            ),
           ),
    child: image,
    ),
        ),
      )));
  }
}
