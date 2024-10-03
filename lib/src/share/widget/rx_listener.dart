
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class RxListener<T> extends StatefulWidget {
  const RxListener({
    required this.listenable,
    required this.child,
    required this.onChanged,
    super.key,
  });

  final void Function(T value) onChanged;
  final Rx<T> listenable;
  final Widget child;

  @override
  State<RxListener<T>> createState() => _RxListenerState<T>();
}

class _RxListenerState<T> extends State<RxListener<T>> {
  late final StreamSubscription<T> apiStatusStream;

  @override
  void initState() {
    apiStatusStream = widget.listenable.listen(_onStatusChanged);
    super.initState();
  }

  void _onStatusChanged(final T value) => widget.onChanged(value);

  @override
  void dispose() {
    apiStatusStream.cancel();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) => widget.child;
}