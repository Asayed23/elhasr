import 'package:get/get.dart';

import 'package:elhasr/pages/Auth/Model/users.dart';

class CurrentUserController extends GetxController {
  var currentUser = User().obs;

  @override
  void onInit() async {
    super.onInit();
    //currentUser.value = await loadUserData('user');
    //s print(loadUserData('user').id.toString());
  }
}
