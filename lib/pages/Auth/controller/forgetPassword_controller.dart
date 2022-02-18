import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:elhasr/core/db_links/db_links.dart';

import 'package:elhasr/pages/Auth/controller/currentUser_controller.dart';
import 'package:elhasr/pages/Auth/login/login_page.dart';
import 'package:elhasr/pages/home_page/view/home_page.dart';

class ForgerPassController extends GetxController {
  var newPassword = "".obs;
  var oldPassword = "".obs;
  var resetPassword = "".obs;
  var isLoading = false.obs;
  String _token = '';
  final CurrentUserController currentUserController =
      Get.put(CurrentUserController());

  @override
  void onInit() {
    super.onInit();
  }

  Future updatePassword() async {
    try {
      isLoading(true);
      var dio = Dio();

      var response = await dio.post(
        changepassword_Url,
        data: {
          'oldPassword': oldPassword.value,
          'newPassword': newPassword.value
        },
        options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
          headers: {
            'Authorization':
                'Token ${currentUserController.currentUser.value.token}'
          },
        ),
      );

      if (response.statusCode == 200) {
        Get.snackbar('Thanks'.tr, 'Password_changed_Successfuly'.tr,
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.greenAccent);
        // _redirectUser();

        Get.to(() => HomePage());
      } else {
        _failmessage(response);
      }
    } finally {
      isLoading.value = false;
    }
  }

  _failmessage(response) async {
    isLoading(false);

    Get.snackbar('${response.data['errorCode']}', 'login_failed'.tr,
        snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.white);
  }

  Future resetpassword(_password, _username) async {
    try {
      isLoading(true);
      var dio = Dio();

      var response = await dio.post(
        resetpassword_Url,
        data: {'username': _username, 'password': _password},
        options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
          // headers: {
          //   'Authorization':
          //       'Token ${currentUserController.currentUser.value.token}'
          // },
        ),
      );

      if (response.statusCode == 200) {
        Get.snackbar('Thanks'.tr, 'Password_changed_Successfuly'.tr,
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.greenAccent);
        // _redirectUser();

        Get.to(() => LoginPage());
      } else {
        _failmessage(response);
      }
    } finally {
      isLoading.value = false;
    }
  }
}
