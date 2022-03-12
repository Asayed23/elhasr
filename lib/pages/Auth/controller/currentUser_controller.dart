import 'package:get/get.dart';

import 'package:elhasr/pages/Auth/Model/users.dart';

class CurrentUserController extends GetxController {
  // Just this currentuser fetch User Model
  var currentUser = User().obs;

  @override
  void onInit() async {
    super.onInit();
  }
}
