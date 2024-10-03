import 'dart:async';

import 'package:bitronet_attendance/infrastructure/theme/app_color.dart';
import 'package:bitronet_attendance/src/share/widget/loading_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../infrastructure/utils/utils.dart';

import 'app_text.dart';

class Loading extends StatefulWidget {
  final Widget child;

  const Loading({
    required this.child,
    super.key,
  });

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  LoadingController loadingController = LoadingController();

  @override
  Widget build(final BuildContext context) => Scaffold(
        body: StreamBuilder(
          stream: loadingController.countStream.stream,
          builder: (final context, final asyncSnapshot) {
            int count = 0;
            if (asyncSnapshot.data != null) {
              count = asyncSnapshot.data as int;
            }

            return SizedBox.expand(
              child: Stack(
                children: [
                  widget.child,
                  Stack(
                    children: loadingDialogList(count, context),
                  ),
                ],
              ),
            );
          },
        ),
      );

  List<Widget> loadingDialogList(final int count, final BuildContext context) =>
      List<Widget>.generate(count, (final index) => loadingDialog(context));

  Widget loadingDialog(final BuildContext context) => Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.black87,
        alignment: Alignment.center,
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 120,
              width: 120,
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(children: [
                  LoadingWidget(),
                  Utils.largeGap,
                  AppText(
                    'صبر کنید...',
                    style: TextStyle(color: Colors.white),
                  ),
                ]),
              ),
            )
          ],
        ),
      );
}

class LoadingController {
  factory LoadingController() => _loadingController;

  LoadingController._internal();

  static final LoadingController _loadingController =
      LoadingController._internal();

  int _stackCount = 0;

  final countStream = StreamController<int>();

  show() {
    _stackCount++;
    countStream.add(_stackCount);
  }

  hide() {
    if (_stackCount > 0) {
      _stackCount--;
      countStream.add(_stackCount);
    }
  }
}

class WaitingDialog {
  LoadingController loading = LoadingController();

  void hide() {
    loading.hide();
  }

  void show() {
    loading.show();
  }
}
