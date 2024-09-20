import 'package:get/get.dart';

import '../controllers/gamelauncher_controller.dart';

class GamelauncherBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GamelauncherController>(
      () => GamelauncherController(),
    );
  }
}
