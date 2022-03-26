// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:elhasr/pages/Auth/controller/currentUser_controller.dart';
// import 'package:elhasr/pages/category/model/category_model.dart';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../../../core/db_links/db_links.dart';
// import '../../../core/size_config.dart';
// import '../../common_widget/local_colors.dart';
// import '../../sub_category/control/subCategory_control.dart';
// import '../../sub_category/view/sub_category_page.dart';
// import '../control/category_controller.dart';

// final SubCategoryController subCategoryController =
//     Get.put(SubCategoryController());
// final CurrentUserController currentUserController =
//     Get.put(CurrentUserController());

// Widget showCategoryItem(CategoryModel shownItem, int _selecteditem) {
//   return GestureDetector(
//     onTap: () async {
//       if (currentUserController.currentUser.value.showsizeSelect) {
//         Get.defaultDialog(
//             // barrierDismissible: false,
//             title: '',
//             content: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 TextFormField(
//                   initialValue: currentUserController
//                       .currentUser.value.villaArea
//                       .toString(),
//                   onChanged: ((value) {
//                     currentUserController.currentUser.value.villaAreatemp =
//                         value;
//                   }),
//                   keyboardType: TextInputType.number,
//                   maxLines: 1,
//                   decoration: InputDecoration(
//                       labelText: 'enter_size'.tr,
//                       hintMaxLines: 1,
//                       border: OutlineInputBorder(
//                           borderSide:
//                               BorderSide(color: Colors.green, width: 4.0))),
//                 ),
//                 SizedBox(
//                   height: h(2),
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     if (currentUserController.currentUser.value.villaAreatemp !=
//                         "") {
//                       Get.back();
//                       currentUserController.currentUser.value.villaArea =
//                           int.parse(currentUserController
//                               .currentUser.value.villaAreatemp);

//                       currentUserController.updateUserData(
//                           currentUserController.currentUser.value);
//                       // Get.back(closeOverlays: true);
//                       subCategoryController.selecteditem = _selecteditem;
//                       subCategoryController.categoryimage.value =
//                           shownItem.image;
//                       subCategoryController.getsubcategorydata(shownItem.id);

//                       //Get.back();
//                     }
//                   },
//                   child: Text('update_size'.tr),
//                 ),
//                 Obx(() => CheckboxListTile(
//                       title: Text("don't show again"), //    <-- label
//                       value: !currentUserController
//                           .currentUser.value.showsizeSelect,
//                       onChanged: (value) {
//                         currentUserController.currentUser.value.showsizeSelect =
//                             !value!;
//                       },
//                     ))
//               ],
//             ),
//             radius: 10.0);
//       }
//     },
//     child: Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Container(
//         decoration: BoxDecoration(
//             color: Colors.grey[300], borderRadius: BorderRadius.circular(15)),
//         alignment: Alignment.center,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             Container(
//               width: w(22),
//               height: h(12),
//               decoration: BoxDecoration(
//                 color: Colors.grey[100],
//                 borderRadius: BorderRadius.circular(sp(8)),
//                 border: Border.all(
//                   color: Colors.grey.shade800,
//                   width: sp(1),
//                 ),
//               ),
//               child: Padding(
//                   padding: EdgeInsets.all(sp(0)),
//                   child: Image.network(
//                     dbImageurl + shownItem.image,
//                     fit: BoxFit.fill,
//                     loadingBuilder: (BuildContext context, Widget child,
//                         ImageChunkEvent? loadingProgress) {
//                       if (loadingProgress == null) return child;
//                       return Center(
//                         child: CircularProgressIndicator(
//                           value: loadingProgress.expectedTotalBytes != null
//                               ? loadingProgress.cumulativeBytesLoaded /
//                                   loadingProgress.expectedTotalBytes!
//                               : null,
//                         ),
//                       );
//                     },
//                   )
//                   //  fit: BoxFit.contain,
//                   //   imageUrl: dbImageurl + shownItem.image,
//                   //   progressIndicatorBuilder: (context, url, downloadProgress) =>
//                   //       CircularProgressIndicator(value: downloadProgress.progress),
//                   //   errorWidget: (context, url, error) => Icon(Icons.error),
//                   // ),
//                   ),
//             ),
//             AutoSizeText(
//               shownItem.name,
//               style: TextStyle(fontSize: sp(20)),
//               minFontSize: sp(13),
//               maxLines: 1,
//               overflow: TextOverflow.ellipsis,
//             ),
//             // Text(
//             //   shownItem.name,
//             //   style: TextStyle(
//             //       //  color: lgreen,
//             //       //  fontSize: h(2),
//             //       fontSize: sp(20)),
//             // )
//           ],
//         ),
//       ),
//     ),
//   );
// }
