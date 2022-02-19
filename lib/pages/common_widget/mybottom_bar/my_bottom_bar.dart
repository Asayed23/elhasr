import 'package:elhasr/pages/Auth/register/register_page.dart';
import 'package:elhasr/pages/home_page/view/home_page.dart';
import 'package:elhasr/pages/order/view/order_page.dart';
import 'package:elhasr/pages/user_profile/view/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Auth/controller/currentUser_controller.dart';
import '../../category/view/category.dart';
import 'bottom_bar_controller.dart';

final MyBottomBarCtrl myBottomBarCtrl = Get.put(MyBottomBarCtrl());
final CurrentUserController userctrl = Get.put(CurrentUserController());

mybottomBarWidget() {
  return Obx(() => BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.remove_from_queue),
            label: 'Requst',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Profile',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.chat),
          //   label: 'Chats',
          // ),
        ],
        currentIndex: myBottomBarCtrl.selectedIndBottomBar.value,
        onTap: (index) {
          myBottomBarCtrl.selectedIndBottomBar.value = index;
          if (index == 0) {
            Get.to(const CategoryPage());
          } else if (index == 1) {
            Get.to(const OrderPage());
          } else if (index == 2) {
            userctrl.currentUser.value.id != -1
                ? Get.to(const UserProfilePage())
                : Get.to(RegisterPage());
          }
        },
      ));
}
