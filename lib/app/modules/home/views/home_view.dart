import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text('VDBay All in One (Rooted: ${controller.isRooted})')),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          shrinkWrap: true,
          children: [
            InkWell(
              onTap: () {
                Get.toNamed(Routes.GAMELAUNCHER);
              },
              child: Container(
                color: Colors.blueAccent,
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.only(bottom: 16),
                width: Get.width,
                child: const Row(
                  children: [
                    Icon(Icons.games_rounded),
                    SizedBox(
                      width: 24,
                    ),
                    Expanded(
                      child: Text(
                        "Game Launcher",
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
