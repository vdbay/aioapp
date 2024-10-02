import 'package:get/get.dart';

import '../modules/charging/bindings/charging_binding.dart';
import '../modules/charging/views/charging_view.dart';
import '../modules/gamelauncher/bindings/gamelauncher_binding.dart';
import '../modules/gamelauncher/views/gamelauncher_view.dart';
import '../modules/gamesettings/bindings/gamesettings_binding.dart';
import '../modules/gamesettings/views/gamesettings_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';

// ignore_for_file: constant_identifier_names

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.GAMELAUNCHER,
      page: () => const GamelauncherView(),
      binding: GamelauncherBinding(),
    ),
    GetPage(
      name: _Paths.CHARGING,
      page: () => const ChargingView(),
      binding: ChargingBinding(),
    ),
    GetPage(
      name: _Paths.GAMESETTINGS,
      page: () => const GamesettingsView(),
      binding: GamesettingsBinding(),
    ),
  ];
}
