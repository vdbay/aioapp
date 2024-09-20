import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Vsnackbar {
  static Future<void> showVSnackbar(String title, String message, {required VSnackBarType vSnackBarType, SnackPosition position = SnackPosition.BOTTOM}) async {
    Get.isSnackbarOpen ? await Get.closeCurrentSnackbar() : null;
    Get.snackbar(
      title,
      message,
      snackPosition: position,
      backgroundColor: vSnackBarType == VSnackBarType.success
          ? Colors.green
          : vSnackBarType == VSnackBarType.error
              ? Colors.red
              : vSnackBarType == VSnackBarType.warning
                  ? Colors.orange
                  : Colors.blue,
      colorText: Colors.white,
      icon: Icon(
        vSnackBarType == VSnackBarType.success
            ? Icons.check_circle_outline
            : vSnackBarType == VSnackBarType.error
                ? Icons.error_outline
                : vSnackBarType == VSnackBarType.warning
                    ? Icons.warning_amber_outlined
                    : Icons.info_outline,
        color: Colors.white,
      ),
      margin: const EdgeInsets.all(10),
      borderRadius: 10,
      duration: const Duration(seconds: 3),
      snackStyle: SnackStyle.FLOATING,
    );
  }
}

enum VSnackBarType { success, error, warning, info }
