import 'package:aioapp/app/utils/rootcommand.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  @override
  Future onInit() async {
    super.onInit();
    isRootAvailable(await RootCommand.checkRootAvailability());
    isRooted(await RootCommand.checkRooted());
  }

  RxBool isRooted = false.obs;
  RxBool isRootAvailable = false.obs;
}
