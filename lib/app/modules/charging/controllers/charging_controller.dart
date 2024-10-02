import 'package:get/get.dart';

import '../../../utils/rootcommand.dart';

class ChargingController extends GetxController {
  Future<String?> getAutocutEnable() async {
    return await RootCommand.run('getprop vdbay.autocut.enable');
  }

  Future<String?> setAutocutEnable(String value) async {
    return await RootCommand.run('resetprop -n vdbay.autocut.enable $value');
  }

  Future<String?> getAutocutLevel() async {
    return await RootCommand.run('getprop vdbay.autocut.level');
  }

  Future<String?> setAutocutLevel(String value) async {
    return await RootCommand.run('resetprop -n vdbay.autocut.level $value');
  }

  Future<String?> getBypassEnable() async {
    return await RootCommand.run('cat /sys/devices/platform/charger/bypass_charger');
  }

  Future<String?> setBypassEnable(String value) async {
    return await RootCommand.run('echo $value > /sys/devices/platform/charger/bypass_charger');
  }

  Future<ChargingSettings> getChargingSettings() async {
    return ChargingSettings(
      autocutEnable: await getAutocutEnable(),
      autocutLevel: await getAutocutLevel(),
      bypassEnable: await getBypassEnable(),
    );
  }
}

class ChargingSettings {
  String? autocutEnable;
  String? autocutLevel;
  String? bypassEnable;

  ChargingSettings({
    this.autocutEnable,
    this.autocutLevel,
    this.bypassEnable,
  });
}
