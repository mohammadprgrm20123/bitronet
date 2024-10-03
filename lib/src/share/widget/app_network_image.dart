import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'loading_widget.dart';

class AppNetworkImage extends StatefulWidget {
  const AppNetworkImage({
    required this.url,
    this.width = 60,
    this.height = 60,
    this.loading,
    this.failureIcon,
    this.fit,
    super.key,
  });

  final String url;
  final double width;
  final double height;
  final Widget? failureIcon;
  final Widget? loading;
  final BoxFit? fit;

  @override
  State<AppNetworkImage> createState() => _AppCachedNetworkImageState();
}

class _AppCachedNetworkImageState extends State<AppNetworkImage> {
  @override
  Widget build(final BuildContext context) => CachedNetworkImage(
        imageUrl: widget.url,
        height: widget.height,
        width: widget.width,
        fit: widget.fit ?? BoxFit.cover,
        progressIndicatorBuilder:
            (final context, final url, final downloadProgress) =>
                widget.loading ?? const LoadingWidget(),
        errorWidget: (final context, final url, final error) =>
            const Icon(Icons.error),
      );
}
