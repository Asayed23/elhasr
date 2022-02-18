import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:elhasr/core/db_links/db_links.dart';
import 'package:elhasr/pages/Auth/Model/users.dart';
import 'package:elhasr/pages/Auth/controller/profileIdStoring.dart';

import 'package:elhasr/pages/Auth/controller/currentUser_controller.dart';
import 'package:elhasr/pages/home_page/view/home_page.dart';
import 'package:elhasr/pages/common_widget/error_snackbar.dart';

class RegisterController extends GetxController {
  // Loading flag for Registeration
  var isLoading = false.obs;
  final CurrentUserController currentUserController =
      Get.put(CurrentUserController());
  var registeruserdata = User().obs;
  @override
  void onInit() {
    super.onInit();
  }

  Future registeruser() async {
    // var f = _loadUserData('user');
    // print(f);

    try {
      isLoading(true);
      var dio = Dio(); // DIO is library to deal with APIs

      registeruserdata.value.accountType = registeruserdata.value.showType;

// Trainer  è player

// Physiotherapistè player

// Nutritionist   à player

// Academy  à Club
      if ((registeruserdata.value.accountType == "Trainer" ||
              registeruserdata.value.accountType == "Physiotherapist") ||
          (registeruserdata.value.accountType == "Nutritionist")) {
        registeruserdata.value.accountType = "Player";
      } else if (registeruserdata.value.accountType == "Academy") {
        registeruserdata.value.accountType = "Club";
      }

      var response = await dio.post(
        register_url,
        data: {
          'username': registeruserdata
              .value.phoneNumber, //registeruserdata.value.username,
          'password': registeruserdata.value.password,
          'email': registeruserdata.value.email,
          'phoneNumber': registeruserdata.value.phoneNumber,
          'fullName': registeruserdata.value.fullName,
          'accountToken': currentUserController.currentUser.value.accountToken,
          // 'country': registeruserdata.value.country,
          'accountType': registeruserdata.value.accountType,
          'showType': registeruserdata.value.showType,
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
        User _regiuser = User.fromJson(response.data);

        currentUserController.currentUser.value = _regiuser;

        ///
        ///
        ///
        // Remove it later
        ///
        ///
        ///
        /// to make user Silver after registeration
        // currentUserController.currentUser.value.membership = "Silver";
        // currentUserController.currentUser.value.memberShipExpireDate =
        //     DateFormat('yyyy-MM-dd')
        //         .format(DateTime.now().add(Duration(days: 30)));

        getprofileID(_regiuser);

        //paySelectionController.upgrademyaccount("Silver");
        Get.defaultDialog(
          barrierDismissible: false,
          title: "Congratulation".tr,
          content: Text("won_prize".tr),
          onConfirm: () {
            Get.offAll(HomePage());
          },
        );

        // storeUserData(currentUserController.currentUser.value,
        //     'user'); // save UserID, User name , Phone Num
        // print(_regiuser.playerId);
        // // create PlayerId and save it to shared preference

        // // Show Snackbar
        // Get.snackbar('Thanks'.tr, 'register_Successfuly'.tr,
        //     snackPosition: SnackPosition.BOTTOM,
        //     backgroundColor: Colors.greenAccent);

        // Get.to(()=>SearchPage());
        // _redirectUser();
        print(_regiuser);
      } else {
        mySnackbar("Failed".tr, "validate_data".tr, "Error");
      }
    } finally {
      isLoading.value = false;
    }
  }
}
