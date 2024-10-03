import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../infrastructure/theme/app_color.dart';
import '../../../infrastructure/theme/theme_constants.dart';
import '../../../infrastructure/utils/utils.dart';
import 'app_text.dart';

class AppButton extends StatefulWidget {
  /// Specifies the text of button.
  final String? text;

  final bool showLoading;
  final Icon? startIcon;
  final Icon? endIcon;
  final Color? backgroundColor;
  final Widget? progressIndicator;
  final Color? progressIndicatorColor;
  final Color? borderColor;
  final double? borderRadius;
  final ButtonStyle? style;
  final double? height;
  final EdgeInsetsGeometry contentPadding;
  final ButtonType type;
  final TextStyle? textStyle;
  final AppTextEnum textType;
  final void Function()? onPressed;
  final void Function()? onLongPressed;
  final Widget? child;

  const AppButton({
    required this.onPressed,
    this.height,
    this.borderRadius,
    this.progressIndicator,
    this.progressIndicatorColor,
    this.onLongPressed,
    this.textType = AppTextEnum.titleMedium,
    this.text,
    this.style,
    this.textStyle,
    this.type = ButtonType.filled,
    this.contentPadding = EdgeInsets.zero,
    this.showLoading = false,
    this.endIcon,
    this.backgroundColor,
    this.startIcon,
    this.child,
    super.key,
    this.borderColor,
  });

  factory AppButton.flat({
    required final void Function()? onPressed,
    final String? text,
    final Color? borderColor,
    final double? borderRadius,
    final bool showLoading = false,
    final Widget? progressIndicator,
    final Color? progressIndicatorColor,
    final Color? backgorundColor,
    final Icon? startIcon,
    final Icon? endIcon,
    final double? height,
    final ButtonStyle? style,
    final TextStyle? textStyle,
    final Widget? child,
    final EdgeInsetsGeometry contentPadding = EdgeInsets.zero,
    final AppTextEnum textType = AppTextEnum.titleMedium,
    final Key? key,
    final void Function()? onLongPressed,
  }) =>
      AppButton(
        text: text,
        borderColor: borderColor,
        backgroundColor: backgorundColor,
        borderRadius: borderRadius,
        onPressed: onPressed,
        progressIndicator: progressIndicator,
        progressIndicatorColor: progressIndicatorColor,
        onLongPressed: onLongPressed,
        height: height,
        style: style,
        type: ButtonType.flat,
        showLoading: showLoading,
        key: key,
        textStyle: textStyle,
        contentPadding: contentPadding,
        endIcon: endIcon,
        startIcon: startIcon,
        textType: textType,
        child: child,
      );

  factory AppButton.outlined({
    required final void Function()? onPressed,
    final String? text,
    final bool showLoading = false,
    final Icon? startIcon,
    final Color? borderColor,
    final Color? progressIndicatorColor,
    final Widget? progressIndicator,
    final double? borderRadius,
    final Icon? endIcon,
    final Color? backgroundColor,
    final ButtonStyle? style,
    final TextStyle? textStyle,
    final double? height,
    final Widget? child,
    final EdgeInsetsGeometry contentPadding = EdgeInsets.zero,
    final AppTextEnum textType = AppTextEnum.titleMedium,
    final Key? key,
    final void Function()? onLongPressed,
  }) =>
      AppButton(
        text: text,
        borderColor: borderColor,
        backgroundColor: backgroundColor,
        borderRadius: borderRadius,
        onPressed: onPressed,
        progressIndicatorColor: progressIndicatorColor,
        progressIndicator: progressIndicator,
        onLongPressed: onLongPressed,
        style: style,
        textStyle: textStyle,
        type: ButtonType.outlined,
        showLoading: showLoading,
        key: key,
        contentPadding: contentPadding,
        endIcon: endIcon,
        height: height,
        startIcon: startIcon,
        textType: textType,
        child: child,
      );

  factory AppButton.filled({
    required final void Function()? onPressed,
    final String? text,
    final bool showLoading = false,
    final Icon? startIcon,
    final Icon? endIcon,
    final Color? borderColor,
    final Color? progressIndicatorColor,
    final Color? backgroundColor,
    final Widget? progressIndicator,
    final double? borderRadius,
    final ButtonStyle? style,
    final double? height,
    final TextStyle? textStyle,
    final Widget? child,
    final EdgeInsetsGeometry contentPadding = EdgeInsets.zero,
    final AppTextEnum textType = AppTextEnum.titleMedium,
    final Key? key,
    final void Function()? onLongPressed,
  }) =>
      AppButton(
        text: text,
        borderColor: borderColor,
        textStyle: textStyle,
        backgroundColor: backgroundColor,
        borderRadius: borderRadius,
        progressIndicatorColor: progressIndicatorColor,
        onPressed: onPressed,
        progressIndicator: progressIndicator,
        onLongPressed: onLongPressed,
        style: style,
        height: height,
        type: ButtonType.filled,
        showLoading: showLoading,
        key: key,
        contentPadding: contentPadding,
        endIcon: endIcon,
        startIcon: startIcon,
        textType: textType,
        child: child,
      );

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  @override
  Widget build(final BuildContext context) {
    final double h = widget.height ?? 45;

    switch (widget.type) {
      case ButtonType.filled:
        return SizedBox(
          height: h,
          child: FilledButton(
            onPressed: !widget.showLoading ? widget.onPressed : () {},
            onLongPress: !widget.showLoading ? widget.onLongPressed : () {},
            style: _getFilledStyle(context),
            child: widget.child ?? _child(false),
          ),
        );
      case ButtonType.flat:
        return SizedBox(
          height: h,
          child: TextButton(
            onPressed: !widget.showLoading ? widget.onPressed : () {},
            onLongPress: !widget.showLoading ? widget.onLongPressed : () {},
            style: _getFlatStyle(context),
            child: widget.child ?? _child(true),
          ),
        );
      case ButtonType.outlined:
        return SizedBox(
          height: h,
          child: OutlinedButton(
            onPressed: !widget.showLoading ? widget.onPressed : null,
            onLongPress: !widget.showLoading ? widget.onLongPressed : null,
            style: _getOutlinedStyle(context),
            child: widget.child ?? _child(false),
          ),
        );
    }
  }

  Widget _child(final bool isText) => Padding(
        padding: widget.contentPadding,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.startIcon != null) ...[
              widget.startIcon!,
              Utils.smallGap,
            ],
            if (!widget.showLoading)
              switch (widget.type) {
                ButtonType.filled => _textFilled(),
                ButtonType.outlined => _outLineText(),
                ButtonType.flat => _flatText(),
              }
            else
              _progressIndicator(isTextButton: isText),
            if (widget.endIcon != null) ...[Utils.mediumGap, widget.endIcon!],
          ],
        ),
      );

  ButtonStyle? _getFilledStyle(final BuildContext context) =>
      widget.style != null
          ? widget.style!
          : Theme.of(context).filledButtonTheme.style != null
              ? Theme.of(context).filledButtonTheme.style!.copyWith(
                    shadowColor: WidgetStateProperty.resolveWith(
                      (final states) => states.contains(WidgetState.hovered)
                          ? null
                          : widget.backgroundColor ?? Colors.white,
                    ),
                    backgroundColor: WidgetStateProperty.resolveWith(
                      (final states) => states.contains(WidgetState.selected)
                          ? AppColor.primary.withOpacity(.9)
                          : widget.backgroundColor ??
                              Theme.of(context).colorScheme.primary,
                    ),
                    shape: WidgetStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          _borderRadius,
                        ),
                      ),
                    ),
                  )
              : ButtonStyle(
                  foregroundColor: WidgetStateProperty.resolveWith(
                    (final states) => states.contains(WidgetState.hovered)
                        ? null
                        : widget.backgroundColor ?? Colors.black,
                  ),
                  backgroundColor: WidgetStateProperty.resolveWith(
                    (final states) => states.contains(WidgetState.pressed)
                        ? Colors.red
                        : widget.backgroundColor ??
                            Theme.of(context).colorScheme.primary,
                  ),
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        _borderRadius,
                      ),
                    ),
                  ),
                );

  ButtonStyle _getOutlinedStyle(final BuildContext context) =>
      widget.style != null
          ? widget.style!
          : Theme.of(context).outlinedButtonTheme.style != null
              ? Theme.of(context).outlinedButtonTheme.style!.copyWith(
                    side: WidgetStateProperty.all(
                      BorderSide(
                          width: 2,
                          color: widget.borderColor ??
                              Theme.of(context).colorScheme.primary),
                    ),
                    backgroundColor: WidgetStateProperty.resolveWith(
                      (final states) => states.contains(WidgetState.pressed)
                          ? null
                          : widget.backgroundColor ?? Colors.transparent,
                    ),
                    shape: WidgetStateProperty.all(
                      RoundedRectangleBorder(
                        side: BorderSide(
                            width: 10,
                            color: widget.borderColor ??
                                Theme.of(context).colorScheme.primary),
                        borderRadius: BorderRadius.circular(_borderRadius),
                      ),
                    ),
                  )
              : ButtonStyle(
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      side: BorderSide(
                          width: 5,
                          color: widget.borderColor ??
                              Theme.of(context).colorScheme.primary),
                      borderRadius: BorderRadius.circular(_borderRadius),
                    ),
                  ),
                );

  ButtonStyle _getFlatStyle(final BuildContext context) {
    if (widget.style != null) {
      return _styleButton();
    } else {
      return Theme.of(context).textButtonTheme.style!.copyWith(
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(_borderRadius),
              ),
            ),
          );
    }
  }

  ButtonStyle _styleButton() => widget.style!.copyWith(
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_borderRadius),
          ),
        ),
      );

  Widget _textFilled() => AppText(
        widget.text!,
        isRequired: false,
        style: widget.textStyle ??
            Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: widget.type == ButtonType.filled
                      ? widget.onPressed != null
                          ? Colors.white
                          : Colors.white
                      : Colors.white,
                ),
        type: widget.textType,
      );

  Widget _outLineText() => AppText(
        widget.text!,
        isRequired: false,
        style: widget.textStyle ??
            Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: widget.type == ButtonType.filled
                      ? widget.onPressed != null
                          ? Theme.of(context).colorScheme.primary
                          : AppColor.grey
                      : Theme.of(context).colorScheme.primary,
                ),
        type: widget.textType,
      );

  Widget _flatText() => AppText(
        widget.text!,
        isRequired: false,
        style: widget.textStyle ??
            Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: widget.type == ButtonType.filled
                      ? widget.onPressed != null
                          ? Theme.of(context).colorScheme.primary
                          : AppColor.grey
                      : Colors.white,
                ),
        type: widget.textType,
      );

  Widget _progressIndicator({required final bool isTextButton}) => Row(
        children: [
          if (widget.progressIndicator == null)
            LoadingAnimationWidget.threeArchedCircle(
              size: 30,
              color: Colors.white,
            )
          else
            widget.progressIndicator!,
        ],
      );

  double get _borderRadius =>
      widget.borderRadius ?? ThemeConstants.borderRadius;
}

enum ButtonType { filled, outlined, flat }
