import 'package:get/get.dart';
import 'package:installed_apps/app_info.dart';
import 'package:installed_apps/installed_apps.dart';

import '../../../utils/rootcommand.dart';

class GamelauncherController extends GetxController {
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

  Future<String?> getDownscaleFactor() async {
    return await RootCommand.run('getprop vdbay.game.downscaleFactor');
  }

  Future<String?> setDownscaleFactor(String value) async {
    return await RootCommand.run('resetprop -n vdbay.game.downscaleFactor $value');
  }

  Future<String?> getFps() async {
    return await RootCommand.run('getprop vdbay.game.fps');
  }

  Future<String?> setFps(String value) async {
    return await RootCommand.run('resetprop -n vdbay.game.fps $value');
  }

  Future<String?> getLoadingBoost() async {
    return await RootCommand.run('getprop vdbay.game.loadingBoost');
  }

  Future<String?> setLoadingBoost(String value) async {
    return await RootCommand.run('resetprop -n vdbay.game.loadingBoost $value');
  }

  Future<String?> getUseAngle() async {
    return await RootCommand.run('getprop vdbay.game.useAngle');
  }

  Future<String?> setUseAngle(String value) async {
    return await RootCommand.run('resetprop -n vdbay.game.useAngle $value');
  }

  Future<String?> runSelectedPackageWithGameSettings(
    String packageName, {
    GameSettingsModel? settings,
  }) async {
    isLoading(true);
    String? res = await RootCommand.run('am force-stop $packageName');
    res = "$res\n${await RootCommand.run('settings put system peak_refresh_rate ${settings?.fps}')}";
    res = "$res\n${await RootCommand.run('settings put system min_refresh_rate ${settings?.fps}')}')}";
    res = "$res\n${await RootCommand.run('device_config put game_overlay $packageName mode=1,downscaleFactor=${settings?.downscaleFactor},fps=${settings?.fps},loadingBoost=${settings?.loadingBoost},useAngle=${settings?.useAngle}:mode=2,downscaleFactor=${settings?.downscaleFactor},fps=${settings?.fps},loadingBoost=${settings?.loadingBoost},useAngle=${settings?.useAngle}:mode=3,downscaleFactor=${settings?.downscaleFactor},fps=${settings?.fps},loadingBoost=${settings?.loadingBoost},useAngle=${settings?.useAngle}')}";
    res = "$res\n${await RootCommand.run('cmd game mode performance $packageName')}";
    res = "$res\n${await RootCommand.run('monkey -p $packageName 1')}";
    res = "$res\n${await RootCommand.sendNotificationAndToast('Running and optimized!: $packageName')}";
    isLoading(false);
    Get.back(closeOverlays: true);
    return res;
  }

  Future<GameSettingsModel> getGameSettings() async {
    return GameSettingsModel(
      downscaleFactor: await getDownscaleFactor(),
      fps: await getFps(),
      loadingBoost: await getLoadingBoost(),
      useAngle: await getUseAngle(),
    );
  }
}

class GameSettingsModel {
  String? downscaleFactor;
  String? fps;
  String? loadingBoost;
  String? useAngle;

  GameSettingsModel({
    this.downscaleFactor,
    this.fps,
    this.loadingBoost,
    this.useAngle,
  });
}
