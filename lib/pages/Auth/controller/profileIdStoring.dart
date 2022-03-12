// import 'package:dio/dio.dart';
// import 'package:get/get.dart';
// import 'package:elhasr/core/db_links/db_links.dart';
// import 'package:elhasr/pages/Auth/Model/users.dart';
// import 'package:elhasr/pages/Auth/controller/currentUser_controller.dart';
// import 'package:elhasr/pages/Auth/controller/sharedpref_function.dart';
// import 'package:elhasr/pages/home_page/view/home_page.dart';

// import '../../common_widget/error_snackbar.dart';
// // import 'package:elhasr/pages/pay/pay_controller/pay_controller.dart';
// // import 'package:elhasr/pages/profile/controller/current_profile_Controller.dart';
// // import 'package:elhasr/pages/common_widget/error_snackbar.dart';
// // import 'package:elhasr/pages/search/search_page.dart';

// final CurrentUserController _currentuser = Get.put(CurrentUserController());
// // final PaySelectionController paySelectionController =
// //     Get.put(PaySelectionController());
// // final CurrentProfileController currentProfileController =
// //     Get.put(CurrentProfileController());
// getprofileID(User _user) async {
//   var dio = Dio();
//   // get proper ulr based on accountType
//   String _url = "";
//   String _key = "";
//   if (_user.accountType == "Player") {
//     _url = playerlist_Url;
//     _key = "playerId";
//   } else if (_user.accountType == "Agent") {
//     _url = agentlist_Url;
//     _key = "agentId";
//   } else if (_user.accountType == "Club") {
//     _url = clublist_Url;
//     _key = "clubId";
//   } else if (_user.accountType == "Company") {
//     _url = companylist_Url;
//     _key = "companyId";
//   }

//   var response = await dio.post(
//     _url,
//     data: {"userId": _user.id},
//     options: Options(
//       //followRedirects: false,
//       validateStatus: (status) {
//         return status! < 505;
//       },
//       // headers: {
//       //   'Content-Type': 'application/json; charset=UTF-8',
//       //   "Cache-Control": "no-cache"
//       // },
//     ),
//   );

//   if (response.statusCode == 200) {
//     _currentuser.currentUser.value.accountId = response.data[0][_key];
//     // currentProfileController.profile.value.accountId = response.data[0][_key];
//     // make by default Silver

//     // User will be saved after Silver upgrade
//     storeUserData(_currentuser.currentUser.value,
//         'user'); // save UserID, User name , Phone Num
//     Get.offAll(HomePage());
//     // create PlayerId and save it to shared preference
//     print(_currentuser.currentUser.value);

//     // Show Snackbar
//     mySnackbar('Thanks'.tr, 'Login_success'.tr, true);

//     //_regiuser.playerId = response.data[0]['playerId'];
//   } else {
//     mySnackbar('Failed'.tr, 'Login_fail'.tr, false);
//   }

//   // _dioCacheManager.clearAll();
//   dio.close();
// }
