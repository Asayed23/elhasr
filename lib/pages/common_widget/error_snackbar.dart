import 'package:flutter/material.dart';
import 'package:get/get.dart';

mySnackbar(title, message, type) {
  if (type == false) {
    return Get.snackbar(title, message,
        snackPosition: SnackPosition.TOP, backgroundColor: Colors.white);
  }

  return Get.snackbar(title, message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.white,
      colorText: Colors.green);
}
