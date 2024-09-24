import 'package:get/get.dart';
import 'package:installed_apps/app_info.dart';
import 'package:installed_apps/installed_apps.dart';

import '../../../utils/rootcommand.dart';

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
    isLoading(true);
    // force stop
    String? res = await RootCommand.run('am force-stop $packageName');
    // set refresh rate
    res = "$res\n${await RootCommand.run('settings put system peak_refresh_rate 60')}";
    res = "$res\n${await RootCommand.run('settings put system min_refresh_rate 60')}";
    res = "$res\n${await RootCommand.run('settings put system peak_refresh_rate 90')}";
    res = "$res\n${await RootCommand.run('settings put system min_refresh_rate 90')}";
    res = "$res\n${await RootCommand.run('settings put system peak_refresh_rate 120')}";
    res = "$res\n${await RootCommand.run('settings put system min_refresh_rate 120')}";
    // set game overlay
    res = "$res\n${await RootCommand.run('device_config put game_overlay $packageName mode=1,downscaleFactor=0.7,fps=60,loadingBoost=28800000,useAngle=true:mode=2,downscaleFactor=0.7,fps=60,loadingBoost=28800000,useAngle=true:mode=3,downscaleFactor=0.7,fps=60,loadingBoost=28800000,useAngle=true')}";
    res = "$res\n${await RootCommand.run('device_config put game_overlay $packageName mode=1,downscaleFactor=0.7,fps=90,loadingBoost=28800000,useAngle=true:mode=2,downscaleFactor=0.7,fps=90,loadingBoost=28800000,useAngle=true:mode=3,downscaleFactor=0.7,fps=90,loadingBoost=28800000,useAngle=true')}";
    res = "$res\n${await RootCommand.run('device_config put game_overlay $packageName mode=1,downscaleFactor=0.7,fps=120,loadingBoost=28800000,useAngle=true:mode=2,downscaleFactor=0.7,fps=120,loadingBoost=28800000,useAngle=true:mode=3,downscaleFactor=0.7,fps=120,loadingBoost=28800000,useAngle=true')}";
    // set game performance
    res = "$res\n${await RootCommand.run('cmd game mode performance $packageName')}";
    // // clear ART JIT
    // res = "$res\n${await RootCommand.run('pm compile --reset $packageName')}";
    // res = "$res\n${await RootCommand.run('pm art clear-app-profiles $packageName')}";
    // res = "$res\n${await RootCommand.run('cmd package compile -m verify -f $packageName')}";
    // // force ART JIT
    // res = "$res\n${await RootCommand.run('cmd package compile -m speed -f $packageName')}";
    // launch
    res = "$res\n${await RootCommand.run('monkey -p $packageName 1')}";
    res = "$res\n${await RootCommand.sendNotificationAndToast('Running and optimized!: $packageName')}";
    isLoading(false);
    Get.back(closeOverlays: true);
    return res;
  }
}
