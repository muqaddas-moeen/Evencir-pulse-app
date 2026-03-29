import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Extensions {
  void showSnackBar(String title, String message) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.redAccent.withOpacity(0.1),
      colorText: Colors.white,
    );
  }
}
