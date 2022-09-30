import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:elhasr/pages/Auth/controller/currentUser_controller.dart';
import 'package:elhasr/pages/category/model/category_model.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/db_links/db_links.dart';
import '../../../core/size_config.dart';
import '../../common_widget/local_colors.dart';
import '../../sub_category/control/subCategory_control.dart';
import '../../sub_category/view/sub_category_page.dart';
import '../control/category_controller.dart';

class ShowCategoryItem extends StatefulWidget {
  CategoryModel shownItem;
  int selecteditem;
  ShowCategoryItem(
      {Key? key, required this.shownItem, required this.selecteditem})
      : super(key: key);

  @override
  State<ShowCategoryItem> createState() => _ShowCategoryItemState();
}

class _ShowCategoryItemState extends State<ShowCategoryItem> {
  final SubCategoryController subCategoryController =
      Get.put(SubCategoryController());
  final CurrentUserController currentUserController =
      Get.put(CurrentUserController());
  bool _checkvalue = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _textEditingController = TextEditingController();

  Future<void> showInformationDialog(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          bool isChecked = false;
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              backgroundColor: Colors.white.withOpacity(0.9),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(sp(10)))),
              content: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              int.parse(value) < 20) {
                            return 'less_size_100'.tr;
                          }
                          return null;
                        },
                        initialValue: currentUserController
                            .currentUser.value.villaArea
                            .toString(),
                        onChanged: ((value) {
                          currentUserController
                              .currentUser.value.villaAreatemp = value;
                        }),
                        keyboardType: TextInputType.number,
                        //controller: _textEditingController,
                        decoration: InputDecoration(hintText: "enter_size".tr),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("not_show_again".tr),
                          Checkbox(
                              value: isChecked,
                              onChanged: (checked) {
                                setState(() {
                                  isChecked = checked!;
                                  currentUserController.currentUser.value
                                      .showsizeSelect = !checked;
                                });
                              })
                        ],
                      )
                    ],
                  )),
              title: Text('enter_size'.tr),
              actions: <Widget>[
                ElevatedButton(
                  child: Text('OK'.tr),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Do something like updating SharedPreferences or User Settings etc.
                      currentUserController.currentUser.value.villaArea =
                          int.parse(currentUserController
                              .currentUser.value.villaAreatemp);
                      currentUserController.updateUserData(
                          currentUserController.currentUser.value);
                      // Get.back(closeOverlays: true);
                      subCategoryController.selecteditem = widget.selecteditem;
                      subCategoryController.categoryimage.value =
                          widget.shownItem.image;
                      Navigator.of(context).pop();
                      subCategoryController
                          .getsubcategorydata(widget.shownItem.id);
                    }
                  },
                ),
              ],
            );
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (currentUserController.currentUser.value.showsizeSelect) {
          showInformationDialog(context);
          // Get.defaultDialog(
          //     // barrierDismissible: false,
          //     title: '',
          //     content: Column(
          //       mainAxisSize: MainAxisSize.min,
          //       children: [
          //         TextFormField(
          //           initialValue:
          //               currentUserController.currentUser.value.villaArea != 0
          //                   ? currentUserController.currentUser.value.villaArea
          //                       .toString()
          //                   : null,
          //           onChanged: ((value) {
          //             currentUserController.currentUser.value.villaAreatemp =
          //                 value;
          //           }),
          //           keyboardType: TextInputType.number,
          //           maxLines: 1,
          //           decoration: InputDecoration(
          //               labelText: 'enter_size'.tr,
          //               hintMaxLines: 1,
          //               border: OutlineInputBorder(
          //                   borderSide:
          //                       BorderSide(color: Colors.green, width: 4.0))),
          //         ),
          //         SizedBox(
          //           height: h(2),
          //         ),
          //         ElevatedButton(
          //           onPressed: () {
          //             if (currentUserController
          //                     .currentUser.value.villaAreatemp !=
          //                 "") {
          //               //Get.back();
          //               currentUserController.currentUser.value.villaArea =
          //                   int.parse(currentUserController
          //                       .currentUser.value.villaAreatemp);

          //               currentUserController.updateUserData(
          //                   currentUserController.currentUser.value);
          //               // Get.back(closeOverlays: true);
          //               subCategoryController.selecteditem =
          //                   widget.selecteditem;
          //               subCategoryController.categoryimage.value =
          //                   widget.shownItem.image;
          //               subCategoryController
          //                   .getsubcategorydata(widget.shownItem.id);

          //               //Get.back();
          //             }
          //           },
          //           child: Text('update_size'.tr),
          //         ),
          //         CheckboxListTile(
          //           title: Text("don't show again"), //    <-- label
          //           value: _checkvalue,
          //           onChanged: (newvalue) {
          //             setState(() {
          //               _checkvalue = newvalue!;
          //               currentUserController.currentUser.value.showsizeSelect =
          //                   newvalue;
          //             });
          //           },
          //         )
          //       ],
          //     ),
          //     radius: 10.0);

        } else {
          subCategoryController.selecteditem = widget.selecteditem;
          subCategoryController.categoryimage.value = widget.shownItem.image;

          subCategoryController.getsubcategorydata(widget.shownItem.id);
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            // border: Border ,
            borderRadius: BorderRadius.circular(20), //border corner radius
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3), //color of shadow
                spreadRadius: sp(1), //spread radius
                blurRadius: sp(1), // blur radius
                offset: Offset(0, 1.2), // changes position of shadow
                //first paramerter of offset is left-right
                //second parameter is top to down
              ),
              //you can set more BoxShadow() here
            ],
          ),
          child: Column(
            textDirection: TextDirection.rtl,
            //alignment: Alignment.bottomRight,
            //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Center(
                child: Container(
                  width: w(30),
                  height: h(14),

                  //  decoration: BoxDecoration(
                  //color: Colors.grey,
                  //  borderRadius: BorderRadius.circular(sp(10)),
                  //border: Border.all(
                  //   //color: Colors.grey.shade800,
                  //   width: sp(1),
                  // ),
                  //  ),
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: ClipRRect(
                      borderRadius:
                          BorderRadius.circular(sp(10)), // Image border

                      child: Image.network(
                        dbImageurl + widget.shownItem.image,
                        fit: BoxFit.fill,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(2),
                child: Container(
                  width: w(30),
                  //height: h(8),
                  decoration: BoxDecoration(
                    // color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(sp(20)),
                    // border: Border.all(
                    //   color: Colors.grey.shade800,
                    //   width: sp(1),
                    // ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: sp(8), right: sp(8)),
                    child: Center(
                      child: AutoSizeText(
                        widget.shownItem.name,

                        style: TextStyle(fontSize: sp(16)),
                        //minFontSize: sp(13),
                        //maxLines: 2,
                        overflow: TextOverflow.fade,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
