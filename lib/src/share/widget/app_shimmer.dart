

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class AppShimmerEffect extends StatefulWidget {
  const AppShimmerEffect({
    required this.child,
    this.color = Colors.white54,
    this.widthPercent = 0.4,
    this.pausePercent = 0.4,
    this.enabled = true,
    this.curve = Curves.easeOutSine,
    this.duration = const Duration(milliseconds: 1500),
    this.direction = TaavShimmerEffectDirection.topRightToBottomLeft,
    super.key,
  })  : assert(widthPercent >= 0 && widthPercent <= 1,
  'widthPercent must be positive and lower than 1',),
        assert(pausePercent >= 0 && pausePercent < 1,
        'pausePercent must be positive and lower than 1',);

  /// diameter of animation in range of 0..1
  final double widthPercent;

  /// pause animation duration in range of 0..1
  final double pausePercent;

  /// animation curve
  final Curve curve;

  /// duration of aniamtion
  final Duration duration;

  /// color of aniamtion
  final Color color;

  /// child
  final Widget child;

  /// play shimmer effect
  final bool enabled;

  /// shimmer direction
  final TaavShimmerEffectDirection direction;

  @override
  State<AppShimmerEffect> createState() => _AppShimmerEffectState();
}

class _AppShimmerEffectState extends State<AppShimmerEffect>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: widget.duration,
  );
  late final Animation<double> _animation = Tween<double>(
    begin: 0,
    end: 1,
  ).animate(
    CurvedAnimation(
      parent: _controller,
      curve: Interval(
        0,
        1.0 - widget.pausePercent,
        curve: widget.curve,
      ),
    ),
  )..addListener(() => setState(() {}));

  @override
  void initState() {
    super.initState();
    if (widget.enabled) {
      _controller.repeat();
    }
  }

  @override
  void didUpdateWidget(covariant final AppShimmerEffect oldWidget) {
    if (widget.duration.inMilliseconds != oldWidget.duration.inMilliseconds) {
      _controller.duration = widget.duration;
      if (widget.enabled) {
        _controller.repeat();
      }
    }
    if (widget.enabled != oldWidget.enabled) {
      if (widget.enabled) {
        _controller.repeat();
      } else {
        _controller.stop();
        _controller.value = 0;
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(final BuildContext context) => AnimatedBuilder(
    animation: _controller,
    child: widget.child,
    builder: (final context, final child) => _Shimmer(
      direction: widget.direction,
      percent: _animationValue,
      color: widget.color,
      width: widget.widthPercent,
      child: child,
    ),
  );

  double get _animationValue {
    double start;
    double end;
    switch (widget.direction) {
      case TaavShimmerEffectDirection.topLeftToBottomRight:
        start = -widget.widthPercent;
        end = 1;
        break;
      case TaavShimmerEffectDirection.bottomRightToTopLeft:
        start = 1;
        end = -widget.widthPercent;
        break;
      case TaavShimmerEffectDirection.topRightToBottomLeft:
        start = 0;
        end = widget.widthPercent + 1;
        break;
      case TaavShimmerEffectDirection.bottomLeftToTopRight:
        start = widget.widthPercent + 1;
        end = 0;
        break;
    }

    return start + (end - start) * _animation.value;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

@immutable
class _Shimmer extends SingleChildRenderObjectWidget {
  final double percent;
  final double width;
  final TaavShimmerEffectDirection direction;
  final Color color;

  const _Shimmer({
    required this.percent,
    required this.width,
    required this.direction,
    required this.color,
    super.child,
  });

  @override
  _ShimmerFilter createRenderObject(final BuildContext context) =>
      _ShimmerFilter(
        direction,
        percent,
        width,
        color,
      );

  @override
  void updateRenderObject(
      final BuildContext context,
      final _ShimmerFilter shimmer,
      ) {
    shimmer.percent = percent;
    shimmer.color = color;
    shimmer.direction = direction;
    shimmer.width = width;
  }
}

class _ShimmerFilter extends RenderProxyBox {
  TaavShimmerEffectDirection _direction;
  double _percent;
  double _width;
  Color _color;

  _ShimmerFilter(
      this._direction,
      this._percent,
      this._width,
      this._color,
      );

  @override
  bool get alwaysNeedsCompositing => child != null;

  set percent(final double newValue) {
    if (newValue == _percent) {
      return;
    }
    _percent = newValue;
    markNeedsPaint();
  }

  set width(final double newWidth) {
    if (newWidth == _width) {
      return;
    }
    _width = newWidth;
    markNeedsPaint();
  }

  set direction(final TaavShimmerEffectDirection newDirection) {
    if (newDirection == _direction) {
      return;
    }
    _direction = newDirection;
    markNeedsLayout();
  }

  set color(final Color newColor) {
    if (newColor == _color) {
      return;
    }
    _color = newColor;
    markNeedsLayout();
  }

  @override
  void paint(final PaintingContext context, final Offset offset) {
    if (child == null) {
      return;
    }
    final rect = Rect.fromLTRB(
      offset.dx,
      offset.dy,
      offset.dx + size.width,
      offset.dy + size.height,
    );
    context.canvas.saveLayer(rect, Paint());
    super.paint(context, offset);
    _drawOverlay(context.canvas, rect);
    context.canvas.restore();
  }

  void _drawOverlay(final Canvas canvas, final Rect rect) {
    final path = Path();
    _drawPath(path, rect);
    path.close();

    final paint = Paint()
      ..color = _color
      ..blendMode = BlendMode.srcATop;
    canvas.drawPath(path, paint);
  }

  void _drawPath(final Path path, final Rect rect) {
    final size = max(rect.width, rect.height);
    final animatedSize = size * _width;
    final start = size * _percent * 2;

    if (isLeftToRight) {
      path
        ..moveTo(rect.left + start, rect.top)
        ..lineTo(rect.left, rect.top + start)
        ..lineTo(rect.left, rect.top + start + animatedSize)
        ..lineTo(rect.left + start + animatedSize, rect.top);
    } else {
      path
        ..moveTo(rect.right - start, rect.top)
        ..lineTo(rect.right, rect.top + start)
        ..lineTo(rect.right + animatedSize, rect.top + start)
        ..lineTo(rect.right - start + animatedSize, rect.top);
    }
  }

  bool get isLeftToRight =>
      _direction == TaavShimmerEffectDirection.bottomRightToTopLeft ||
          _direction == TaavShimmerEffectDirection.topLeftToBottomRight;
}

enum TaavShimmerEffectDirection {
  topLeftToBottomRight,
  bottomRightToTopLeft,
  topRightToBottomLeft,
  bottomLeftToTopRight,
}
