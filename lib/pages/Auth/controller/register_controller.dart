import 'package:elhasr/pages/category/view/category.dart';
import 'package:elhasr/pages/common_widget/mybottom_bar/bottom_bar_controller.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:elhasr/core/db_links/db_links.dart';
import 'package:elhasr/pages/Auth/Model/users.dart';

import 'package:elhasr/pages/Auth/controller/currentUser_controller.dart';
import 'package:elhasr/pages/common_widget/error_snackbar.dart';

import 'sharedpref_function.dart';

class RegisterController extends GetxController {
  // Loading flag for Registeration
  var isLoading = false.obs;
  final CurrentUserController currentUserController =
      Get.put(CurrentUserController());

  final MyBottomBarCtrl myBottomBarCtrl = Get.put(MyBottomBarCtrl());
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
          'villaArea': registeruserdata.value.villaArea,
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

        storeUserData(currentUserController.currentUser.value,
            'user'); // save UserID, User name , Phone Num
        myBottomBarCtrl.selectedIndBottomBar.value = 0;
        Get.offAll(CategoryPage());
      } else {
        mySnackbar("Failed".tr, "validate_data".tr, "Error");
      }
    } finally {
      isLoading.value = false;
    }
  }
}
