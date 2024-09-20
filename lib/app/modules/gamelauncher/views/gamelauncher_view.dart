import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:installed_apps/app_info.dart';

import '../controllers/gamelauncher_controller.dart';

class GamelauncherView extends GetView<GamelauncherController> {
  const GamelauncherView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Game Launcher'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: FutureBuilder<List<AppInfo>?>(
          future: controller.getInstalledApps(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data?.length ?? 0,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: (controller.isLoading.value == false)
                        ? () {
                            controller.runSelected(snapshot.data?[index].packageName ?? "");
                            Get.defaultDialog(
                                barrierDismissible: false,
                                title: 'Applying config...\nPlease dont click anything\nJust please wait...',
                                content: const Center(
                                  child: CircularProgressIndicator(),
                                ));
                          }
                        : null,
                    child: Container(
                        color: Colors.blueAccent,
                        padding: const EdgeInsets.all(16),
                        margin: const EdgeInsets.only(bottom: 16),
                        width: Get.width,
                        child: Obx(
                          () => Row(
                            children: [
                              controller.isLoading.value == false
                                  ? Image.memory(
                                      snapshot.data?[index].icon ?? Uint8List(0),
                                      width: 40,
                                    )
                                  : const CircularProgressIndicator(),
                              const SizedBox(
                                width: 24,
                              ),
                              Expanded(
                                child: Text(
                                  snapshot.data?[index].name ?? "-",
                                ),
                              )
                            ],
                          ),
                        )),
                  );
                },
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
      ),
    );
  }
}
