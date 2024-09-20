import 'package:get/get.dart';
import 'package:installed_apps/app_info.dart';
import 'package:installed_apps/installed_apps.dart';

import '../../../utils/rootcommand.dart';
// import '../../../utils/vsnackbar.dart';

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

  Future<List<AppInfo>> getInstalledApps() async {
    List<AppInfo> apps = await InstalledApps.getInstalledApps(true, true);
    return apps;
  }

  Future<String?> runSelected(String packageName) async {
    // await Vsnackbar.showVSnackbar('Please Wait', "Applying configuration...", vSnackBarType: VSnackBarType.info);
    String? res = await RootCommand.run('am force-stop $packageName');
    res = "$res\n${await RootCommand.run('settings put system peak_refresh_rate 120')}";
    res = "$res\n${await RootCommand.run('settings put system min_refresh_rate 120')}";
    res = "$res\n${await RootCommand.run('device_config put game_overlay $packageName mode=2,downscaleFactor=0.7:mode=3,downscaleFactor=0.7,fps=60:mode=3,fps=60')}";
    res = "$res\n${await RootCommand.run('device_config put game_overlay $packageName mode=2,downscaleFactor=0.7:mode=3,downscaleFactor=0.7,fps=90:mode=3,fps=90')}";
    res = "$res\n${await RootCommand.run('device_config put game_overlay $packageName mode=2,downscaleFactor=0.7:mode=3,downscaleFactor=0.7,fps=120:mode=3,fps=120')}";
    res = "$res\n${await RootCommand.run('cmd game mode performance $packageName')}";
    res = "$res\n${await RootCommand.run('cmd power set-fixed-performance-mode-enabled true')}";
    // res = "$res\n${await RootCommand.run('cmd package compile -m everything -f $packageName')}";
    // await Vsnackbar.showVSnackbar('Success', "Enjoy!", vSnackBarType: VSnackBarType.success);
    res = "$res\n${await RootCommand.run('monkey -p $packageName 1')}";
    res = "$res\n${await RootCommand.sendNotificationAndToast('Running and optimized!: $packageName')}";
    Get.back(closeOverlays: true);
    return res;
  }
}
