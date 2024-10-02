import 'package:get/get.dart';

import '../controllers/gamesettings_controller.dart';

class GamesettingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GamesettingsController>(
      () => GamesettingsController(),
    );
  }
}
