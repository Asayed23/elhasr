import 'package:elhasr/core/theme.dart';
import 'package:elhasr/pages/Auth/controller/currentUser_controller.dart';
import 'package:elhasr/pages/common_widget/mybottom_bar/my_bottom_bar.dart';
import 'package:elhasr/pages/common_widget/simple_appbar.dart';
import 'package:elhasr/pages/sub_category/control/subCategory_control.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/db_links/db_links.dart';
import '../../../core/size_config.dart';
import '../../Auth/register/register_page.dart';
import '../../category/control/category_controller.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final scrollController = ScrollController();
  //final SearchController searchController = Get.put(SearchController());
  final CurrentUserController currentUserController =
      Get.put(CurrentUserController());
  final SubCategoryController subCategoryController =
      Get.put(SubCategoryController());
  @override
  void initState() {
    super.initState();
    // categoryController.getdata();

    // scrollController.addListener(() {
    //   if (scrollController.position.pixels ==
    //       scrollController.position.maxScrollExtent) {
    //     if (categoryController.from.value < categoryController.totalListLen.value) {
    //       unlockController.getlist();
    //       categoryController.getdata();
    //     }

    //     //return state.products;
    //   }
    // });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: simplAppbar(true),
      body: Obx(() => ListView(
            children: [
              SizedBox(height: h(2)),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: w(22),
                  height: h(37),
                  decoration: BoxDecoration(
                      // color: Colors.grey,
                      // borderRadius: BorderRadius.circular(sp(8)),
                      // border: Border.all(
                      //   color: Colors.grey.shade800,
                      //   width: sp(1),
                      // ),
                      ),
                  child: Padding(
                      padding: EdgeInsets.all(sp(10)),
                      child: Hero(
                        tag:
                            subCategoryController.selectsubCategory.value.image,
                        child: Image.network(
                          dbImageurl +
                              subCategoryController
                                  .selectsubCategory.value.image,
                          fit: BoxFit.fill,
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            );
                          },
                        ),
                      )
                      //  fit: BoxFit.contain,
                      //   imageUrl: dbImageurl + subCategoryController.selectsubCategory.value.image,
                      //   progressIndicatorBuilder: (context, url, downloadProgress) =>
                      //       CircularProgressIndicator(value: downloadProgress.progress),
                      //   errorWidget: (context, url, error) => Icon(Icons.error),
                      // ),
                      ),
                ),
              ),
              Divider(),
              SizedBox(height: h(1)),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                    textDirection: TextDirection.rtl,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Text(
                          subCategoryController.selectsubCategory.value.name,
                          style: TextStyle(
                              overflow: TextOverflow.fade,
                              //  color: lgreen,
                              //  fontSize: h(2),
                              fontSize: sp(20)),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          subCategoryController.selectsubCategory.value.price
                                  .toString() +
                              ' SR',
                          style: TextStyle(
                              color: textbuttonColor,
                              //  fontSize: h(2),
                              fontSize: sp(15)),
                        ),
                      )
                    ]),
              ),
              // SizedBox(height: h(1)),
              // Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              //   Text(
              //     subCategoryController.selectsubCategory.value.price
              //             .toString() +
              //         ' SR',
              //     style: TextStyle(
              //         //  color: lgreen,
              //         //  fontSize: h(2),
              //         fontSize: sp(10)),
              //   ),
              //   Obx(() => currentUserController.currentUser.value.id == -1
              //       ? IconButton(
              //           onPressed: () {
              //             Get.to(RegisterPage());
              //           },
              //           icon: Icon(Icons.login))
              //       : IconButton(
              //           onPressed: () {
              //             cartController.cartIDList.contains(
              //                     subCategoryController
              //                         .selectsubCategory.value.service_id)
              //                 ? cartController.delFromCart(subCategoryController
              //                     .selectsubCategory.value.service_id)
              //                 : cartController.addtoCart(subCategoryController
              //                     .selectsubCategory.value.service_id);
              //           },
              //           icon: cartController.cartIDList.contains(
              //                   subCategoryController
              //                       .selectsubCategory.value.service_id)
              //               ? Icon(Icons.remove, color: Colors.red)
              //               : Icon(
              //                   Icons.add_chart,
              //                   color: Colors.grey,
              //                 )))
              // ]),
              SizedBox(height: h(1)),
              SizedBox(
                height: h(14),
                child: ListView(
                  children: [
                    Text(
                      subCategoryController.selectsubCategory.value.description
                          .toString(),
                      style: TextStyle(

                          //  color: lgreen,
                          //  fontSize: h(2),
                          fontSize: sp(10)),
                    )
                  ],
                ),
              ),
              SizedBox(height: h(1)),
              SizedBox(
                width: w(60),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      onPressed: () {
                        cartController.cartIDList.contains(subCategoryController
                                .selectsubCategory.value.service_id)
                            ? cartController.delFromCart(subCategoryController
                                .selectsubCategory.value.service_id)
                            : cartController.addtoCart(subCategoryController
                                .selectsubCategory.value.service_id);
                      },
                      child: cartController.cartIDList.contains(
                              subCategoryController
                                  .selectsubCategory.value.service_id)
                          ? Text('remove_from_cart')
                          : Text('add_tocart')),
                ),
              )
            ],
          )),
      bottomNavigationBar: mybottomBarWidget(),
    );
  }
}
