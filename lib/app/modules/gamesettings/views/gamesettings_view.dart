import 'package:aioapp/app/modules/gamelauncher/controllers/gamelauncher_controller.dart';
import 'package:aioapp/app/utils/vsnackbar.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/gamesettings_controller.dart';

class GamesettingsView extends GetView<GamesettingsController> {
  const GamesettingsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Game Boosters'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: FutureBuilder<GameSettingsModel>(
            future: controller.gameLauncherController.getGameSettings(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Expanded(child: Text('⚡ GPU Boost:')),
                          const SizedBox(
                            width: 16,
                          ),
                          Flexible(
                            child: DropdownMenu<String>(
                              initialSelection: snapshot.data?.useAngle,
                              onSelected: (String? value) async {
                                await controller.gameLauncherController.setUseAngle("$value");
                              },
                              dropdownMenuEntries: const [
                                DropdownMenuEntry<String>(
                                  value: "true",
                                  label: "Yes",
                                ),
                                DropdownMenuEntry<String>(
                                  value: "false",
                                  label: "No",
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          const Expanded(child: Text('⏳ Loading Boost:')),
                          const SizedBox(
                            width: 16,
                          ),
                          Flexible(
                            child: DropdownMenu<String>(
                              initialSelection: snapshot.data?.loadingBoost,
                              onSelected: (String? value) async {
                                await controller.gameLauncherController.setLoadingBoost("$value");
                              },
                              dropdownMenuEntries: const [
                                DropdownMenuEntry<String>(
                                  value: "${8 * 60 * 60 * 1000}",
                                  label: "Yes",
                                ),
                                DropdownMenuEntry<String>(
                                  value: "${0}",
                                  label: "No",
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          const Expanded(child: Text('🚀 FPS Boost:')),
                          const SizedBox(
                            width: 16,
                          ),
                          Flexible(
                            child: DropdownMenu<String>(
                              initialSelection: snapshot.data?.fps,
                              onSelected: (String? value) async {
                                await controller.gameLauncherController.setFps("$value");
                              },
                              dropdownMenuEntries: const [
                                DropdownMenuEntry<String>(
                                  value: "60",
                                  label: "60 FPS",
                                ),
                                // DropdownMenuEntry<String>(
                                //   value: "90",
                                //   label: "90 FPS",
                                // ),
                                DropdownMenuEntry<String>(
                                  value: "120",
                                  label: "120 FPS",
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          const Expanded(child: Text('🖼️ Resolution:')),
                          const SizedBox(
                            width: 16,
                          ),
                          Flexible(
                            child: DropdownMenu<String>(
                              initialSelection: snapshot.data?.downscaleFactor,
                              onSelected: (String? value) async {
                                await controller.gameLauncherController.setDownscaleFactor("$value");
                              },
                              dropdownMenuEntries: const [
                                DropdownMenuEntry<String>(
                                  value: "1",
                                  label: "100% (FHD+)", // Full HD+
                                ),
                                DropdownMenuEntry<String>(
                                  value: "0.9",
                                  label: "90% (HD)", // High Definition
                                ),
                                DropdownMenuEntry<String>(
                                  value: "0.8",
                                  label: "80% (qHD)", // Quarter HD
                                ),
                                DropdownMenuEntry<String>(
                                  value: "0.7",
                                  label: "70% (SD)", // Standard Definition
                                ),
                                DropdownMenuEntry<String>(
                                  value: "0.6",
                                  label: "60% (nHD)", // Near HD
                                ),
                                DropdownMenuEntry<String>(
                                  value: "0.5",
                                  label: "50% (LD)", // Low Definition
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Text("\n🚀 For an ultra experience, go with Disable Thermals & ANY Performance modules!"),
                      const Text("\n⚠️ Note: Some games may not support these game boosters settings. Please check:"),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Vsnackbar.showVSnackbar("URL", "https://developer.android.com/games/optimize/adpf/gamemode/gamemode-interventions", vSnackBarType: VSnackBarType.success);
                            },
                            child: const Text(
                              "documentation.",
                              style: TextStyle(
                                color: Colors.blue, // Change color to indicate it's clickable
                                decoration: TextDecoration.underline, // Underline for clarity
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ));
  }
}
