import 'package:flutter/material.dart';

enum CardBannerPosition {
  topLeft,
  topRight,
  bottomLeft,
  bottomRight,
}

class AppCardBanner extends StatelessWidget {
  const AppCardBanner({
    required this.child, required this.text, super.key,
    this.position = CardBannerPosition.topLeft,
    this.color = Colors.blue,
    this.edgeColor = const Color.fromARGB(255, 7, 86, 150),
    this.radius = 4,
    this.padding = 8.0,
    this.edgeSize = 6,
    this.textStyle = const TextStyle(fontSize: 14, color: Colors.white),
  });

  final Widget child;
  final String text;
  final Color color;
  final Color edgeColor;
  final double edgeSize;
  final double radius;
  final double padding;
  final CardBannerPosition position;
  final TextStyle textStyle;

  @override
  Widget build(final BuildContext context) => Stack(
        clipBehavior: Clip.none,
        children: [
          child,
          Positioned.fill(
            right: position.toString().contains('Right') ? -6 : null,
            left: position.toString().contains('Left') ? -10 : null,
            top: position.toString().contains('top') ? 15 : null,
            bottom: position.toString().contains('Bottom') ? 15 : null,
            child: CustomPaint(
              painter: DesignCardBanner(edgeColor, position, edgeSize),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(radius),
                    topRight: Radius.circular(radius),
                    bottomLeft: position.toString().contains('Left')
                        ? Radius.zero
                        : Radius.circular(radius),
                    bottomRight: position.toString().contains('Right')
                        ? Radius.zero
                        : Radius.circular(radius),
                  ),
                  color: color,
                ),
                child: Text(text, style: textStyle),
              ),
            ),
          ),
        ],
      );
}

class DesignCardBanner extends CustomPainter {
  DesignCardBanner(this.color, this.position, this.edgeSize);

  final Color color;
  final CardBannerPosition position;
  final double edgeSize;

  @override
  void paint(final Canvas canvas, final Size size) {
    if (position.toString().contains('Left')) {
      final Paint paint = Paint()..color = color;
      final path = Path();
      path.moveTo(0, 0);
      path.lineTo(0, size.height);
      path.lineTo(10, size.height + edgeSize);
      path.lineTo(10, size.height);
      path.lineTo(0, size.height);
      path.close();
      canvas.drawPath(path, paint);
    } else {
      final Paint paint = Paint()..color = color;
      final path = Path();
      path.moveTo(size.width, size.height);

      path.lineTo(size.width - 10, size.height + edgeSize);
      path.lineTo(size.width - 10, size.height);
      path.lineTo(size.width, size.height);
      path.close();
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant final CustomPainter oldDelegate) => false;
}
