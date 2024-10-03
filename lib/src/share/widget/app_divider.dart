import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


/// A thin horizontal line, with padding on either side.
class AppDivider extends StatelessWidget {
  /// The divider's padding extent.
  final double? padding;

  /// The thickness of the line drawn within the divider.
  final double? thickness;

  /// The amount of empty space to the leading edge of the divider.
  final double? startIndent;

  /// The amount of empty space to the trailing edge of the divider.
  final double? endIndent;

  /// The color to use when painting the line.
  final Color? color;

  /// style of iconButton using theme
  final String themeName;

  /// dash type
  final AppDividerDashType? dashType;

  /// list of dashed width and gaps
  ///
  /// [dash1, gap1, dash2, gap2, ...]
  final List<double>? dashList;

  /// dash width
  ///
  /// [dashType] should be [AppDividerDashType.dashed]
  final double? dashWidth;

  /// dash gap
  ///
  /// [dashType] should be [AppDividerDashType.dashed]
  final double? dashGap;

  /// Creates a material design divider.
  ///
  /// The [padding], [thickness], [startIndent], and [endIndent] must be null or
  /// non-negative.
  const AppDivider({
    super.key,
    this.padding,
    this.thickness,
    this.startIndent,
    this.endIndent,
    this.color,
    this.dashType,
    this.dashList,
    this.dashGap,
    this.dashWidth,
    this.themeName = 'divider',
  })  : assert(dashList == null || dashType == null,
  'only one of dashList or dashType should be set',),
        assert(padding == null || padding >= 0.0,
        'padding should be greater than 0',),
        assert(thickness == null || thickness >= 0.0,
        'thickness should be greater than 0',),
        assert(startIndent == null || startIndent >= 0.0,
        'startIndent should be greater than 0',),
        assert(endIndent == null || endIndent >= 0.0,
        'endIndent should be greater than 0',);

  @override
  Widget build(final BuildContext context) {

    return Padding(
      padding: EdgeInsetsDirectional.only(
        top: 2,
        bottom:  2,
      ),
      child: SizedBox(
        width: double.infinity,
        child: _hasDash
            ? DecoratedBox(
          decoration: AppDottedDecoration(
            dash: _dash,
          ),
        )
            : ColoredBox(color: Colors.grey),
      ),
    );
  }

  bool get _hasDash =>
      dashType == AppDividerDashType.dashed || dashList != null;

  List<double> get _dash {
    if (dashList != null) {
      return dashList!;
    }
    final width = dashWidth ?? 2;
    final gap = dashGap ?? 2;
    return [width, gap];
  }

}
enum AppDividerDashType { none, dashed }




class AppDottedDecoration extends Decoration {
  final LinePosition linePosition;
  final Shape shape;
  final Color color;
  final Color? fillColor;
  final BorderRadius? borderRadius;
  final List<double> dash;
  final double strokeWidth;

  /// dotted decoration
  const AppDottedDecoration({
    this.shape = Shape.line,
    this.linePosition = LinePosition.bottom,
    this.color = const Color(0xFF9E9E9E),
    this.fillColor,
    this.borderRadius,
    this.dash = const <double>[5, 5],
    this.strokeWidth = 1,
  });

  @override
  BoxPainter createBoxPainter([final VoidCallback? onChanged]) =>
      _DottedDecoratorPainter(
        shape,
        linePosition,
        color,
        fillColor,
        borderRadius,
        dash,
        strokeWidth,
      );
}

class _DottedDecoratorPainter extends BoxPainter {
  final LinePosition linePosition;
  final Shape shape;
  final Color color;
  final Color? fillColor;
  final BorderRadius borderRadius;
  final List<double> dash;
  final double strokeWidth;

  _DottedDecoratorPainter(
      this.shape,
      this.linePosition,
      this.color,
      this.fillColor,
      final BorderRadius? borderRadius,
      this.dash,
      this.strokeWidth,
      ) : borderRadius = borderRadius ?? BorderRadius.zero;

  @override
  void paint(
      final Canvas canvas,
      final Offset offset,
      final ImageConfiguration configuration,
      ) {
    final Path outPath = Path();
    if (shape == Shape.line) {
      _drawLine(
        outPath,
        offset,
        configuration,
      );
    } else if (shape == Shape.box) {
      _drawBox(
        offset,
        configuration,
        outPath,
      );
    } else if (shape == Shape.circle) {
      _drawCircle(
        outPath,
        offset,
        configuration,
      );
    }

    final PathMetrics metrics = outPath.computeMetrics(forceClosed: false);
    final Path drawPath = Path();

    for (final PathMetric me in metrics) {
      final double totalLength = me.length;
      int index = -1;

      for (double start = 0; start < totalLength;) {
        double to = start + dash[(++index) % dash.length];
        to = to > totalLength ? totalLength : to;
        final bool isEven = index.isEven;
        if (isEven) {
          drawPath.addPath(
            me.extractPath(
              start,
              to,
              startWithMoveTo: true,
            ),
            Offset.zero,
          );
        }
        start = to;
      }
    }
    if (fillColor != null && shape != Shape.line) {
      canvas.drawPath(
        outPath,
        Paint()
          ..style = PaintingStyle.fill
          ..color = fillColor!,
      );
    }
    canvas.drawPath(
      drawPath,
      Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth,
    );
  }

  void _drawLine(
      final Path outPath,
      final Offset offset,
      final ImageConfiguration configuration,
      ) {
    if (linePosition == LinePosition.left) {
      outPath
        ..moveTo(offset.dx, offset.dy)
        ..lineTo(offset.dx, offset.dy + configuration.size!.height);
    } else if (linePosition == LinePosition.top) {
      outPath
        ..moveTo(offset.dx, offset.dy)
        ..lineTo(offset.dx + configuration.size!.width, offset.dy);
    } else if (linePosition == LinePosition.right) {
      outPath
        ..moveTo(offset.dx + configuration.size!.width, offset.dy)
        ..lineTo(
          offset.dx + configuration.size!.width,
          offset.dy + configuration.size!.height,
        );
    } else {
      outPath
        ..moveTo(offset.dx, offset.dy + configuration.size!.height)
        ..lineTo(
          offset.dx + configuration.size!.width,
          offset.dy + configuration.size!.height,
        );
    }
  }

  void _drawBox(
      final Offset offset,
      final ImageConfiguration configuration,
      final Path outPath,
      ) {
    final RRect rect = RRect.fromLTRBAndCorners(
      offset.dx,
      offset.dy,
      offset.dx + configuration.size!.width,
      offset.dy + configuration.size!.height,
      bottomLeft: borderRadius.bottomLeft,
      bottomRight: borderRadius.bottomRight,
      topLeft: borderRadius.topLeft,
      topRight: borderRadius.topRight,
    );
    outPath.addRRect(rect);
  }

  void _drawCircle(
      final Path outPath,
      final Offset offset,
      final ImageConfiguration configuration,
      ) {
    outPath.addOval(Rect.fromLTWH(
      offset.dx,
      offset.dy,
      configuration.size!.width,
      configuration.size!.height,
    ),);
  }
}

enum LinePosition {
  left,
  top,
  right,
  bottom,
}
enum Shape {
  line,
  box,
  circle,
}
