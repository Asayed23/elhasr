import 'package:elhasr/pages/Auth/login/change_password.dart';
import 'package:elhasr/pages/Auth/login/forget_password.dart';
import 'package:elhasr/pages/category/view/category.dart';
import 'package:elhasr/pages/common_widget/mybottom_bar/my_bottom_bar.dart';
import 'package:elhasr/pages/common_widget/simple_appbar.dart';
import 'package:elhasr/pages/sub_category/control/cart_controller.dart';
import 'package:elhasr/translation/translation_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
String _size = "";

class _UserProfilePageState extends State<UserProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: simplAppbar(false),
      body: ListView(
        children: [
          SizedBox(
            height: h(2),
          ),
          Obx(() => Visibility(
                visible: currentUserController.currentUser.value.id != -1,
                child: Center(
                    child: Text(
                        'Hi  ${currentUserController.currentUser.value.fullName}',
                        style: TextStyle(fontSize: sp(17)))),
              )),

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
          Obx(() => Visibility(
                visible: currentUserController.currentUser.value.id != -1,
                child: ListTile(
                    trailing: Text('edit'.tr),
                    leading: FaIcon(FontAwesomeIcons.houseUser),
                    title: Text('myarea_size'.tr +
                        ' ${currentUserController.currentUser.value.villaArea.toString()}'),
                    onTap: () async {
                      Get.defaultDialog(
                          title: '',
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextField(
                                onChanged: ((value) {
                                  setState(() {
                                    _size = value;
                                  });
                                }),
                                keyboardType: TextInputType.number,
                                maxLines: 1,
                                decoration: InputDecoration(
                                    labelText: 'enter_size'.tr,
                                    hintMaxLines: 1,
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.green, width: 4.0))),
                              ),
                              SizedBox(
                                height: h(2),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  if (_size != "") {
                                    currentUserController.currentUser.value
                                        .villaArea = int.parse(_size);
                                    Navigator.of(context).pop();
                                    Get.to(() => const UserProfilePage());

                                    setState(() {
                                      currentUserController.currentUser.value
                                          .villaArea = int.parse(_size);
                                    });

                                    //Get.back();
                                  }
                                },
                                child: Text('update_size'.tr),
                              )
                            ],
                          ),
                          radius: 10.0);
                    }),
              )),
          Divider(),

          ///
          ///
          // Change Password
          ///
          ///
          Obx(() => Visibility(
                visible: currentUserController.currentUser.value.id != -1,
                child: ListTile(
                    leading: Icon(
                      Icons.lock_open,
                      color: clickIconColor,
                    ),
                    title: Text('change_password'.tr),
                    onTap: () async {
                      Get.to(ChangePassword());
                    }),
              )),

          ///
          ///
          // Forget Password
          ///
          ///
          Obx(() => Visibility(
                visible: currentUserController.currentUser.value.id != -1,
                child: ListTile(
                    leading: Icon(
                      Icons.history,
                      color: clickIconColor,
                    ),
                    title: Text('order_histroy'.tr),
                    onTap: () async {}),
              )),

          ListTile(
              leading: FaIcon(FontAwesomeIcons.hardHat),
              title: Text('aboutus'.tr),
              onTap: () async {}),

          ListTile(
              leading: FaIcon(FontAwesomeIcons.headset),
              title: Text('contactus'.tr),
              onTap: () async {}),

          ///
          ///
          // Language
          ///
          ///
          ListTile(
              leading: Icon(
                Icons.language,
                color: clickIconColor,
              ),
              title: Text('change_language'.tr),
              onTap: () async {
                Get.to(TrnaslationPage());
              }),

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
