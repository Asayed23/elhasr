import 'package:elhasr/pages/Auth/controller/phone_controller.dart';
import 'package:elhasr/pages/category/view/category.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:elhasr/core/db_links/db_links.dart';

import 'package:elhasr/pages/Auth/controller/currentUser_controller.dart';
import 'package:elhasr/pages/Auth/login/login_page.dart';
import 'package:elhasr/pages/home_page/view/home_page.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../../common_widget/error_snackbar.dart';
import '../login/otp_forgetpassword.dart';

class ForgerPassController extends GetxController {
  var newPassword = "".obs;
  var oldPassword = "".obs;
  var resetPassword = "".obs;
  var isLoading = false.obs;
  String _token = '';
  final CurrentUserController currentUserController =
      Get.put(CurrentUserController());
  final PhoneController phoneController = Get.put(PhoneController());
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

        Get.to(() => CategoryPage());
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

  Future chdeck_number(String _number) async {
    // var f = _loadUserData('user');
    // print(f);

    try {
      isLoading(true);
      var dio = Dio(); // DIO is library to deal with APIs

      var response = await dio.post(
        phoneCheckUrl,
        data: {
          'phoneNumber': _number,
        },
        options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return status! < 505;
          },
          //headers: {},
        ),
      );

      if (response.statusCode == 200) {
        //final responseData = json.decode(response.data);
        if (response.data['Date'] == "phone number exist") {
          var resp = await phoneController.verifyPhone(_number);

          Get.to(OtpForgetPassPage());
        }
      } else {
        mySnackbar("Failed".tr, "invalid_num_or_already_exist".tr, "Error");
      }
    } finally {
      isLoading.value = false;
    }
  }
}
