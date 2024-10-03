import 'package:flutter/material.dart';

class AppScaffold extends StatelessWidget {
  final AppBar appBar;
  final Widget body;
  final Widget? floatingButton;

  const AppScaffold(
      {required this.appBar,
      required this.body,
      super.key,
      this.floatingButton});

  @override
  Widget build(final BuildContext context) => Scaffold(
        appBar: appBar,
        floatingActionButton: floatingButton,
        body: body,
      );
}
