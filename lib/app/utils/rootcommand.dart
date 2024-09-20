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
    return res;
  }

  static Future<String?> sendNotificationAndToast(String message) async {
    String? firstRun = await run('''su -lp 2000 -c "cmd notification post -S bigtext -t 'VDBay AIO' tag '$message'" >/dev/null 2>&1''');
    String? secondRun = await run('am start -a android.intent.action.MAIN -e toasttext "$message" -n bellavita.toast/.MainActivity');
    return '$firstRun :: $secondRun';
  }
}
