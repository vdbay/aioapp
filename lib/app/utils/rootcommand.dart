import 'dart:developer';
import 'package:root/root.dart';

class RootCommand {
  static Future<bool?> checkRooted() async {
    bool? res = await Root.isRooted();
    return res;
  }

  static Future<bool?> checkRootAvailability() async {
    bool? res = await Root.isRootAvailable();
    return res;
  }

  static Future<String?> run(String? command) async {
    String? res = await Root.exec(cmd: command);
    log('$res');
    return res?.replaceAll(' ', '').replaceAll('\n', '').replaceAll('\t', "");
  }

  static Future<String?> sendNotificationAndToast(String message) async {
    String? res = await run('''su -lp 2000 -c "cmd notification post -S bigtext -t 'VDBay AIO' tag '$message'" >/dev/null 2>&1''');
    res = "$res\n${await run('am start -a android.intent.action.MAIN -e toasttext "$message" -n bellavita.toast/.MainActivity')}";
    return res;
  }
}
