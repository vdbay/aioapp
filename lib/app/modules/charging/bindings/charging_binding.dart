import 'package:get/get.dart';

import '../controllers/charging_controller.dart';

class ChargingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChargingController>(
      () => ChargingController(),
    );
  }
}
