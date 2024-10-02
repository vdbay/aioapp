import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/charging_controller.dart';

class ChargingView extends GetView<ChargingController> {
  const ChargingView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Charging Control'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: FutureBuilder<ChargingSettings>(
            future: controller.getChargingSettings(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Expanded(child: Text('✂️ Autocut Charging:')),
                          const SizedBox(
                            width: 16,
                          ),
                          Flexible(
                            child: DropdownMenu<String>(
                              initialSelection: snapshot.data?.autocutEnable,
                              onSelected: (String? value) async {
                                await controller.setAutocutEnable("$value");
                              },
                              dropdownMenuEntries: const [
                                DropdownMenuEntry<String>(
                                  value: "1",
                                  label: "Enabled",
                                ),
                                DropdownMenuEntry<String>(
                                  value: "0",
                                  label: "Disabled",
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          const Expanded(child: Text('💯 Autocut Battery Level:')),
                          const SizedBox(
                            width: 16,
                          ),
                          Flexible(
                            child: DropdownMenu<String>(
                              initialSelection: snapshot.data?.autocutLevel,
                              onSelected: (String? value) async {
                                await controller.setAutocutLevel("$value");
                              },
                              dropdownMenuEntries: const [
                                DropdownMenuEntry<String>(
                                  value: "100",
                                  label: "Full",
                                ),
                                DropdownMenuEntry<String>(
                                  value: "90",
                                  label: "90%",
                                ),
                                DropdownMenuEntry<String>(
                                  value: "80",
                                  label: "80%",
                                ),
                                DropdownMenuEntry<String>(
                                  value: "70",
                                  label: "70%",
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          const Expanded(child: Text('🔌 Bypass Charging:')),
                          const SizedBox(
                            width: 16,
                          ),
                          Flexible(
                            child: DropdownMenu<String>(
                              initialSelection: snapshot.data?.bypassEnable,
                              enabled: (snapshot.data?.bypassEnable == "1" || snapshot.data?.bypassEnable == "0") ? true : false,
                              onSelected: (String? value) async {
                                await controller.setBypassEnable("$value");
                              },
                              dropdownMenuEntries: const [
                                DropdownMenuEntry<String>(
                                  value: "1",
                                  label: "Enabled",
                                ),
                                DropdownMenuEntry<String>(
                                  value: "0",
                                  label: "Disabled",
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const Text("\n⚙️ Optimize your device with smart charging settings and power management for extended battery life!"),
                      const Text("\n📝 Note: Kindly allow approximately 1 minute for the changes to take effect. If not, please consider re-plugging the charger."),
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
