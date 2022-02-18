import 'package:elhasr/pages/home_page/view/home_page.dart';
import 'package:elhasr/pages/order/view/order_page.dart';
import 'package:elhasr/pages/user_profile/view/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'bottom_bar_controller.dart';

final MyBottomBarCtrl myBottomBarCtrl = Get.put(MyBottomBarCtrl());

mybottomBarWidget() {
  return Obx(() => BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.remove_from_queue),
            label: 'Requst',
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
            Get.to(HomePage());
          } else if (index == 1) {
            Get.to(UserProfilePage());
          } else if (index == 2) {
            Get.to(OrderPage());
          }
        },
      ));
}
