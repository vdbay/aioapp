import 'package:flutter/material.dart';

import 'package:get/get.dart';

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
        child: FutureBuilder<List<String>?>(
          future: controller.getInstalledPackages(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data?.length ?? 0,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: (controller.isLoading.value == false)
                        ? () async {
                            await controller.runSelected(snapshot.data?[index] ?? "-");
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
                              controller.isLoading.value == false ? const Icon(Icons.android_rounded) : const CircularProgressIndicator(),
                              const SizedBox(
                                width: 24,
                              ),
                              Expanded(
                                child: Text(
                                  snapshot.data?[index] ?? "-",
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
