import '../widget/loading.dart';

class WaitingDialog {
  LoadingController loading = LoadingController();

 void hide() {
    loading.hide();
  }

  void show() {
    loading.show();
  }
}
