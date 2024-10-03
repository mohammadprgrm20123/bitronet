
import 'package:flutter/material.dart';

/// Labeled widget
class AppLabeledWidget extends StatelessWidget {
  /// label widget
  final Widget? label;

  /// label width flex
  final int labelFlex;

  /// child widget
  final Widget? child;

  /// child width flex
  final int childFlex;

  /// padding
  final EdgeInsetsGeometry? padding;

  /// alignment of label widget
  final AlignmentGeometry labelAlignment;

  /// alignment of child widget
  final AlignmentGeometry childAlignment;

  /// Labeled widget
  const AppLabeledWidget({
    super.key,
    this.label,
    this.labelFlex = 4,
    this.child,
    this.childFlex = 3,
    this.labelAlignment = AlignmentDirectional.center,
    this.childAlignment = AlignmentDirectional.center,
    this.padding = const EdgeInsets.all(3),
  })  : assert(
  labelFlex >= 0,
  'labelFlex must be greater or equal than zero',
  ),
        assert(
        childFlex >= 0,
        'childFlex must be greater or equal than zero',
        );

  @override
  Widget build(final BuildContext context) => Padding(
    padding: padding ?? EdgeInsets.zero,
    child: Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [_labelWidget, _childWidget],
    ),
  );

  Widget get _labelWidget => Expanded(
    flex: labelFlex,
    child: Align(
      alignment: labelAlignment,
      child: label ?? const SizedBox.shrink(),
    ),
  );

  Widget get _childWidget => Expanded(
    flex: childFlex,
    child: Align(
      alignment: childAlignment,
      child: child ?? const SizedBox.shrink(),
    ),
  );
}
