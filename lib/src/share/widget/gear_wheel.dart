import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../infrastructure/theme/app_color.dart';
import 'app_divider.dart';
import 'app_text.dart';



/// gear wheel
class AppGearWheel extends StatefulWidget {
  /// items of list
  final List<AppGearWheelItem> items;

  /// color of lines
  final Color? lineColor;

  /// color of icons
  final Color? iconColor;

  /// color of selectedColor
  final Color? selectedColor;

  /// text style for main button
  final TextStyle? textStyle;

  /// logo widget
  final Widget? logo;

  /// button background color
  final Color? buttonBackgroundColor;

  /// gear wheel
  const AppGearWheel({
    required final this.items,
    final super.key,
    final this.lineColor,
    final this.iconColor,
    final this.selectedColor,
    final this.textStyle,
    final this.logo,
    final this.buttonBackgroundColor,
  })  : assert(items.length > 0, 'items is required and must not be empty');

  @override
  _AppGearWheelState createState() => _AppGearWheelState();
}

const _upperVerticalPadding = 32.0;
const _mainButtonSize = 84.0;
const _leftPaddingCoefficient = 0.4;
const _dash = [4.0, 4.0];

class _AppGearWheelState extends State<AppGearWheel>
    with TickerProviderStateMixin {
  double _offsetValue = 0;
  double _lastDelta = 0;
  Duration _lastTapDownTime = Duration.zero;
  Offset _lastTapDownPosition = Offset.zero;
  double _savedTapOffsetValue = 0;
  double _savedAnimatedOffsetValue = 0;
  late double _xRadius;
  late double _yRadius;
  late double _circleLeftOffset;
  late double _rightLeftover;

  //double _audioLevel;
  late int _currentIndex;
  late int _currentSoundIndex;
  bool _isNewPositionApplied = true;
  bool _hasMovement = true;
  late AnimationController _tapAnimationController;
  late AnimationController _movementAnimationController;

  //AudioCache _audioPlayer;

  @override
  void initState() {
    _currentIndex = widget.items.length ~/ 2;
    _currentSoundIndex = _currentIndex;
    // _audioPlayer = AudioCache(prefix: 'packages/taav_ui/assets/');
    // _audioPlayer.fetchToMemory(_assetFile);
    super.initState();
    _initTapAnimations();
    _initMovementAnimations();
    //_initAudioStreamType();
  }

  @override
  void didUpdateWidget(covariant final AppGearWheel oldWidget) {
    _currentIndex = math.min(
      widget.items.length - 1,
      math.max(0, _currentIndex),
    );
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(final BuildContext context) => LayoutBuilder(
        builder: (final context, final constraints) {
          _yRadius = (constraints.maxHeight - _upperVerticalPadding * 2) / 2;
          _xRadius = math.min(_yRadius, constraints.maxWidth * 5 / 8);
          _circleLeftOffset = _xRadius * _leftPaddingCoefficient;
          _rightLeftover = constraints.maxWidth - _xRadius + _circleLeftOffset;

          return _child();
        },
      );

  // void _initAudioStreamType() async {
  //   try {
  //     await Volume.controlVolume(AudioManager.STREAM_SYSTEM);
  //     final systemLevel = await Volume.getVol / await Volume.getMaxVol;
  //
  //     await Volume.controlVolume(AudioManager.STREAM_MUSIC);
  //     final musicLevel = await Volume.getVol / await Volume.getMaxVol;
  //
  //     _audioLevel = math.min(1.0, systemLevel / musicLevel);
  //   } catch (e) {}
  // }

  void _initTapAnimations() {
    _tapAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    final animator = Tween<double>(begin: 1, end: 0).animate(CurvedAnimation(
      parent: _tapAnimationController,
      curve: Curves.easeOut,
    ),);
    animator.addListener(() {
      setState(() => _offsetValue = animator.value * _savedTapOffsetValue);
    });
  }

  void _initMovementAnimations() {
    _movementAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    final movementAnimation =
        Tween<double>(begin: 1, end: 0).animate(CurvedAnimation(
      parent: _movementAnimationController,
      curve: Curves.easeOutCirc,
    ),);
    movementAnimation.addListener(() {
      if (!_isNewPositionApplied) {
        _isNewPositionApplied = true;
        _applyNewIndex();
      }
      setState(
        () =>
            _offsetValue = movementAnimation.value * _savedAnimatedOffsetValue,
      );
    });
  }

  Widget _child() => Padding(
        padding: const EdgeInsets.symmetric(vertical: _upperVerticalPadding),
        child: Listener(
          onPointerDown: _onPointerDown,
          onPointerMove: _onPointerMove,
          onPointerUp: (final e) =>
              _onPointerUpOrCancel(e.position, e.timeStamp),
          onPointerCancel: (final e) =>
              _onPointerUpOrCancel(e.position, e.timeStamp),
          child: Stack(
            alignment: Alignment.center,
            children: [
              const SizedBox.expand(
                child: ColoredBox(color: Colors.transparent),
              ),
              if (widget.logo != null) _logo(),
              _mainCircle(),
              _buttonDescription(),
              for (int i = 0; i < widget.items.length; i++) _buttons(i),
            ],
          ),
        ),
      );

  Widget _logo() {
    final double size = math.max(
      24,
      math.min(
        _xRadius - _mainButtonSize / 2,
        math.min(
          _yRadius - _mainButtonSize,
          96,
        ),
      ),
    );

    return Positioned(
      top: _yRadius - size / 2,
      left: 8,
      child: Container(
        height: size,
        width: size,
        alignment: Alignment.centerLeft,
        child: widget.logo,
      ),
    );
  }

  Widget _mainCircle() {
    final double circleXDiameter = _xRadius * 2;
    final double circleYDiameter = _yRadius * 2;
    final circleLeft = _xRadius + _circleLeftOffset;

    return Positioned(
      left: -circleLeft,
      top: 0,
      width: circleXDiameter,
      height: circleYDiameter,
      child: DecoratedBox(
        decoration: AppDottedDecoration(
          shape: Shape.circle,
          color: _lineColor,
          dash: _dash,
        ),
      ),
    );
  }

  Widget _buttonDescription() {
    const textHeight = 36.0;
    const halfTextSize = textHeight / 2;
    final double maxWidth =
        math.min(140, _rightLeftover - halfTextSize * 2 - 16);
    final left = _xRadius - _circleLeftOffset + 16 + _mainButtonSize / 2;
    final opacity = 0.2 +
        _abs(_abs(_offsetValue) - _abs(_offsetValue).toInt() - 0.5) * 2 * 0.8;

    return Positioned(
      top: _yRadius - halfTextSize,
      left: left,
      height: textHeight,
      child: Opacity(
        opacity: _isOutOfIndex ? 0 : opacity,
        child: Container(
          decoration: AppDottedDecoration(
            shape: Shape.box,
            borderRadius: BorderRadius.circular(halfTextSize),
            strokeWidth: 1.5,
            dash: _dash,
            color: _lineColor,
          ),
          padding: const EdgeInsets.all(1),
          child: MaterialButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(textHeight / 2),
            ),
            clipBehavior: Clip.hardEdge,
            padding: EdgeInsets.zero,
            onPressed: widget.items[visibleItemIndex].onTap,
            child: Container(
              constraints: BoxConstraints(
                minWidth: math.min(84, maxWidth),
                maxWidth: maxWidth,
              ),
              padding: const EdgeInsets.symmetric(horizontal: halfTextSize),
              alignment: Alignment.center,
              child: FittedBox(
                child: AppText(
                  widget.items[_animatedCurrentItem].text,
                  style: _textStyle,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buttons(final int num) {
    final int position = num + _currentIndex - widget.items.length + 1;
    final number = position + _offsetValue;

    final abs = math.max(number, -number);
    final coefficient = math.pow(1 / (abs + 1), 0.4);

    final buttonSize = _mainButtonSize * coefficient;
    final halfButtonSize = buttonSize / 2;
    final iconSize = halfButtonSize;

    final radians = number * math.pi / 6;
    final top = _yRadius + math.sin(radians) * _yRadius - halfButtonSize;
    final left =
        math.cos(radians) * _xRadius - _circleLeftOffset - halfButtonSize;

    final hide = radians > math.pi * 3 / 2 || radians < -3 * math.pi / 2;

    final dash = 4 / math.pow(coefficient, 2.0);

    return Positioned(
      left: left,
      top: top,
      width: buttonSize,
      height: buttonSize,
      child: hide
          ? const SizedBox.shrink()
          : DecoratedBox(
              decoration: AppDottedDecoration(
                shape: Shape.circle,
                strokeWidth: 3,
                dash: [dash, dash],
                color: _lineColor,
              ),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _buttonColorColor,
                ),
                child: MaterialButton(
                  shape: const CircleBorder(),
                  onPressed: () => _onButtonTapped(num),
                  padding: EdgeInsets.zero,
                  child: Icon(
                    widget.items[num].icon,
                    size: iconSize,
                    color: _iconColor(num),
                  ),
                ),
              ),
            ),
    );
  }

  void _onButtonTapped(final int num) {
    if (num == visibleItemIndex) {
      widget.items[num].onTap?.call();
    } else {
      final newIndex = math.max(widget.items.length - 1, 0) - num;
      final diff = _currentIndex - newIndex;
      _offsetValue += _currentIndex - newIndex;
      _currentIndex = newIndex;
      _savedTapOffsetValue = _offsetValue;
      try {
        _movementAnimationController.stop();
        _tapAnimationController.duration = Duration(
          milliseconds: 300 * _abs(diff.toDouble()).toInt(),
        );
        _tapAnimationController.forward(from: 0);
      } on TickerCanceled {
      }
    }
  }

  void _animatedToNearStep() {
    if (_offsetValue == 0) {
      return;
    }
    try {
      if (_tapAnimationController.status == AnimationStatus.forward) {
        _tapAnimationController.forward();
      } else {
        _movementAnimationController.forward();
      }
    } on TickerCanceled {
    }
  }

  void _onPointerMove(final PointerMoveEvent moveEvent) {
    final deltaY = moveEvent.delta.dy / (_yRadius / 2);
    final deltaX = _abs(moveEvent.delta.dx) / _xRadius;
    _lastDelta = deltaY + deltaX;
    if (!_hasMovement) {
      _hasMovement = _abs(_lastDelta) > 0.008;
      if (!_hasMovement) {
        return;
      }
    }
    setState(() {
      final coefficient = _isOutOfIndex ? 0.1 : 1.0;
      _offsetValue += _lastDelta * coefficient;
      _onOffsetChanged();
    });
  }

  void _onPointerDown(final PointerDownEvent e) {
    _lastTapDownTime = e.timeStamp;
    _lastTapDownPosition = e.position;
    try {
      _tapAnimationController.stop(canceled: false);
      _movementAnimationController.stop(canceled: false);
    } catch (e) {
    }
  }

  void _applyNewIndex() {
    final amplifiedOffset = _offsetValue * _abs(_lastDelta / 10);
    final predictedIndex =
        (amplifiedOffset > 0.0 ? amplifiedOffset + 0.3 : amplifiedOffset - 0.3)
                .round() +
            _currentIndex;
    final newIndex = math.min(
      widget.items.length - 1,
      math.max(0, predictedIndex),
    );
    _offsetValue += _currentIndex - newIndex;
    _currentIndex = newIndex;
    _savedAnimatedOffsetValue = _offsetValue;
  }

  void _onPointerUpOrCancel(
    final Offset position,
    final Duration timestamp,
  ) {
    final distance = (position - _lastTapDownPosition).distance;
    final dt = (timestamp - _lastTapDownTime).inMilliseconds;
    final coefficient = dt < 10 ? 1.0 : distance * 24.0 / dt;
    if (!_hasMovement) {
      _animatedToNearStep();

      return;
    }
    _hasMovement = false;
    _isNewPositionApplied = false;
    try {
      _tapAnimationController.stop();
      _lastDelta = coefficient;
      final duration = (300 * _abs(_lastDelta)).toInt();
      final int limitedDuration = math.max(600, math.min(2500, duration));
      _movementAnimationController.duration =
          Duration(milliseconds: limitedDuration);
      _movementAnimationController.forward(from: 0);
    } catch (e) {
    }
  }

  void _onOffsetChanged() {
    if (_currentSoundIndex == _newAnimatedPosition) {
      return;
    }
    _currentSoundIndex = _newAnimatedPosition;
    // _audioPlayer.play(
    //   _assetFile,
    //   volume: _audioLevel,
    //   mode: PlayerMode.LOW_LATENCY,
    // );
  }

  int get _newAnimatedPosition => math.min(
        widget.items.length - 1,
        math.max(0, _offsetValue.round() + _currentIndex),
      );

  int get visibleItemIndex =>
      math.max(widget.items.length - 1, 0) - _currentIndex;

  Color get _buttonColorColor =>
      widget.buttonBackgroundColor ?? AppColor.tritry;

  Color get _lineColor => widget.lineColor ?? AppColor.tritry;

  Color _iconColor(final int position) {
    final unSelectedColor = widget.iconColor ?? Theme.of(context).primaryColor;
    final selectedColor = widget.selectedColor;
    if (position != _animatedCurrentItem ||
        selectedColor == null ||
        _isOutOfIndex) {
      return unSelectedColor;
    }
    double offset = _abs(_offsetValue.toInt() - _offsetValue);
    if (offset > 0.5) {
      offset = 1 - offset;
    }

    offset = 1 - offset;
    offset -= 0.5;
    offset *= 2;
    offset = math.min(1, offset);

    final int firstWeight = (offset * 0xff).toInt();
    final int secondWeight = 0xff - firstWeight;

    return Color.fromARGB(
      0xff,
      (firstWeight * selectedColor.red + secondWeight * unSelectedColor.red) ~/
          0xff,
      (firstWeight * selectedColor.green +
              secondWeight * unSelectedColor.green) ~/
          0xff,
      (firstWeight * selectedColor.blue +
              secondWeight * unSelectedColor.blue) ~/
          0xff,
    );
  }

  TextStyle get _textStyle =>
      widget.textStyle ??
      const TextStyle(fontWeight: FontWeight.bold, fontSize: 14);

  double _abs(final double unsigned) => math.max(unsigned, -unsigned);

  int get _animatedCurrentItem {
    final int index = (visibleItemIndex - _offsetValue).round();

    return math.max(
      0,
      math.min(widget.items.length - 1, index),
    );
  }

  bool get _isOutOfIndex {
    final indexWithOffset = _currentIndex + _offsetValue;

    return indexWithOffset < -0.5 ||
        indexWithOffset > widget.items.length - 0.5;
  }

  @override
  void dispose() {
    _tapAnimationController.dispose();
    _movementAnimationController.dispose();
    super.dispose();
  }
}

/// gear wheel item
class AppGearWheelItem {
  /// icon
  final IconData icon;

  /// text
  final String text;

  /// callback when item tapped
  final VoidCallback? onTap;

  /// gear wheel item
  const AppGearWheelItem({
    required final this.icon,
    required final this.text,
    required final this.onTap,
  });
}
