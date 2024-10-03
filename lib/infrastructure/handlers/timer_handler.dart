import 'dart:async';

import 'lock_screen_handler.dart';

class TimerHandler {
  static Timer? timer;

  static void stop() {
    if (timer != null) {
      timer!.cancel();
    }
  }

  static void startTimer() {
    stop();
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (final timer) {
        if (timer.tick == 180) {
          LockScreenHandler.lockScreen();
          stop();
        }
      },
    );
  }
}
