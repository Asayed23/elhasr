import 'package:elhasr/pages/category/view/category.dart';
import 'package:elhasr/pages/sub_category/control/cart_controller.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:elhasr/core/db_links/db_links.dart';
import 'package:elhasr/pages/Auth/Model/users.dart';

import 'package:elhasr/pages/Auth/controller/currentUser_controller.dart';
import 'package:elhasr/pages/common_widget/error_snackbar.dart';

import '../../common_widget/mybottom_bar/bottom_bar_controller.dart';
import 'sharedpref_function.dart';

class LoginController extends GetxController {
  var phone = "".obs;
  var password = "".obs;
  var isLoading = false.obs;
  final CurrentUserController userctrl = Get.put(CurrentUserController());
  final CartController cartController = Get.put(CartController());
  final MyBottomBarCtrl myBottomBarCtrl = Get.put(MyBottomBarCtrl());

  @override
  void onInit() {
    super.onInit();
  }

  Future checkuser() async {
    try {
      isLoading(true);
      var dio = Dio();

      var response = await dio.post(
        login_url,
        data: {
          'username': phone.value,
          'password': password.value,
          'accountToken': userctrl.currentUser.value.accountToken,
        },
        options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return status! < 600;
          },
          //headers: {},
        ),
      );

      if (response.statusCode == 200) {
        User _regiuser = User.fromJson(response.data);
        userctrl.currentUser.value = _regiuser;

        storeUserData(userctrl.currentUser.value,
            'user'); // save UserID, User name , Phone Num

        myBottomBarCtrl.selectedIndBottomBar.value = 0;
        Get.offAll(CategoryPage());

        // to read all cart data ( can be removed in other apps)
        cartController.getcartList();
      } else {
        mySnackbar('failed'.tr, 'phone_password_not'.tr, false);
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future getplayeridlist(_userid) async {
    var dio = Dio();
    var response = await dio.get(
      "$playerlist_Url${_userid.toString()}/",
      options: Options(
        followRedirects: false,
        validateStatus: (status) {
          return status! < 505;
        },
        //headers: {},
      ),
    );
    var playeridlist = [];
    if (response.statusCode == 200) {
      //playerId

      for (var item in response.data) {
        item.forEach((k, v) {
          if (k == "playerId") {
            playeridlist.add(v);
          }
        });
      }

      //_regiuser.playerId = response.data[0]['playerId'];
    } else {
      print('Erro login');
    }
    return playeridlist;
  }
}
