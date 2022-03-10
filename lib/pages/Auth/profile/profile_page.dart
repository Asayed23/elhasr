import 'package:elhasr/pages/Auth/login/change_password.dart';
import 'package:elhasr/pages/Auth/login/forget_password.dart';
import 'package:elhasr/pages/category/view/category.dart';
import 'package:elhasr/pages/common_widget/mybottom_bar/my_bottom_bar.dart';
import 'package:elhasr/pages/sub_category/control/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/size_config.dart';
import '../../../core/theme.dart';
import '../../common_widget/error_snackbar.dart';
import '../../common_widget/mybottom_bar/bottom_bar_controller.dart';
import '../../sub_category/model/cart_model.dart';
import '../Model/users.dart';
import '../controller/currentUser_controller.dart';
import '../controller/sharedpref_function.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({Key? key}) : super(key: key);

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

final CurrentUserController currentUserController =
    Get.put(CurrentUserController());
final CartController cartController = Get.put(CartController());
final MyBottomBarCtrl myBottomBarCtrl = Get.put(MyBottomBarCtrl());

class _UserProfilePageState extends State<UserProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          SizedBox(
            height: h(2),
          ),
          Center(
              child: Text(
                  'Hi  ${currentUserController.currentUser.value.fullName}')),

          ///
          ///
          // UserName
          ///
          ///
          ListTile(
              leading: Icon(
                Icons.person,
                color: clickIconColor,
              ),
              title: Text(currentUserController.currentUser.value.username),
              onTap: () async {
                mySnackbar('Failed'.tr, 'please_Loging_First'.tr, 'Error');
              }),

          ///
          ///
          // Villa Size
          ///
          ///
          ListTile(
              leading: Icon(
                Icons.format_size,
                color: clickIconColor,
              ),
              title: Text(
                  'Villa_size is ${currentUserController.currentUser.value.villaArea.toString()}'),
              onTap: () async {
                mySnackbar('Failed'.tr, 'please_Loging_First'.tr, 'Error');
              }),
          Divider(),

          ///
          ///
          // Change Password
          ///
          ///
          ListTile(
              leading: Icon(
                Icons.remove_circle,
                color: clickIconColor,
              ),
              title: Text('Change Password'),
              onTap: () async {
                Get.to(ChangePassword());
              }),

          ///
          ///
          // Forget Password
          ///
          ///
          ListTile(
              leading: Icon(
                Icons.lock,
                color: clickIconColor,
              ),
              title: Text('Forget Password'),
              onTap: () async {
                Get.to(ForgetPassword());
              }),

          ///
          ///
          // UserName
          ///
          ///
          ListTile(
              leading: Icon(
                Icons.language,
                color: clickIconColor,
              ),
              title: Text('Change Language'),
              onTap: () async {}),

          ///
          ///
          // Logout
          ///
          ///
          Obx(() => currentUserController.currentUser.value != -1
              ? ListTile(
                  title: Text('logout'.tr),
                  leading: Icon(Icons.exit_to_app),
                  onTap: () async {
                    await removeUserData('user');
                    currentUserController.currentUser.value = User();
                    cartController.cartIDList.value = [];
                    cartController.cart = CartModel().obs;
                    myBottomBarCtrl.selectedIndBottomBar.value = 0;

                    Get.to(CategoryPage());
                  })
              : Text('')),
        ],
      ),
      bottomNavigationBar: mybottomBarWidget(),
    );
  }
}
