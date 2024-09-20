import 'package:get/get.dart';

import '../../../utils/rootcommand.dart';
import '../../../utils/vsnackbar.dart';

class GamelauncherController extends GetxController {
  RxList<String> packagesList = <String>[].obs;
  RxBool isLoading = false.obs;

  Future<List<String>?> getInstalledPackages() async {
    String data = "${await RootCommand.run('pm list packages -3')}";
    List<String> lines = data.trim().split('\n');
    List<String>? res = lines.map((line) {
      return line.split(':')[1].trim();
    }).toList();
    return res;
  }

  Future<String?> runSelected(String packageName) async {
    await Vsnackbar.showVSnackbar('Please Wait', "Applying configuration...", vSnackBarType: VSnackBarType.info);
    String? res = await RootCommand.run('am force-stop $packageName');
    res = "$res\n${await RootCommand.run('settings put system peak_refresh_rate 120')}";
    res = "$res\n${await RootCommand.run('settings put system min_refresh_rate 120')}";
    res = "$res\n${await RootCommand.run('device_config put game_overlay $packageName mode=2,downscaleFactor=0.7:mode=3,downscaleFactor=0.7,fps=40:mode=3,fps=40')}";
    res = "$res\n${await RootCommand.run('cmd game mode performance $packageName')}";
    res = "$res\n${await RootCommand.run('cmd power set-fixed-performance-mode-enabled true')}";
    res = "$res\n${await RootCommand.run('cmd package compile -m everything -f $packageName')}";
    await Vsnackbar.showVSnackbar('Success', "Enjoy!", vSnackBarType: VSnackBarType.success);
    res = "$res\n${await RootCommand.run('monkey -p $packageName 1')}";
    res = "$res\n${await RootCommand.sendNotificationAndToast('Running and optimized!: $packageName')}";
    return res;
  }
}
