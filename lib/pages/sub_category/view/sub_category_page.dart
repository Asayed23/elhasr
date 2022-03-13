import 'package:elhasr/pages/common_widget/mybottom_bar/my_bottom_bar.dart';
import 'package:elhasr/pages/common_widget/simple_appbar.dart';
import 'package:elhasr/pages/sub_category/control/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animations/loading_animations.dart';

import '../../../core/size_config.dart';
import '../../../core/theme.dart';
import '../control/subCategory_control.dart';
import 'show_subcategory_item.dart';

class SubCategoryPage extends StatefulWidget {
  const SubCategoryPage({Key? key}) : super(key: key);

  @override
  _SubCategoryPageState createState() => _SubCategoryPageState();
}

class _SubCategoryPageState extends State<SubCategoryPage> {
  final scrollController = ScrollController();
  //final SearchController searchController = Get.put(SearchController());

  final SubCategoryController subcategoryController =
      Get.put(SubCategoryController());

  final CartController cartController = Get.put(CartController());
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      cartController.getcartList();
    });
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
      body: Obx(() => RefreshIndicator(
            onRefresh: subcategoryController.getdatarefresh,
            child: subcategoryController.isLoading.value
                ? Center(
                    child: LoadingBouncingGrid.circle(
                    backgroundColor: clickIconColor,
                  ))
                : Column(children: [
                    // Row(children: [
                    //   Expanded(
                    //     flex: 6,
                    //     child: TextField(
                    //       textInputAction: TextInputAction.search,
                    //       onSubmitted: (value) {
                    //         searchController.searchWords.value.searchWord = value;
                    //         searchController.from.value = 0;
                    //         searchController.shownItems.value = [
                    //           GlobalProfileModel()
                    //         ];
                    //         searchController.getdata(false);
                    //         Get.to(() => SearchPage());
                    //       },
                    //       style: TextStyle(color: Colors.white70),
                    //       decoration: InputDecoration(
                    //           enabledBorder: OutlineInputBorder(
                    //             borderRadius:
                    //                 BorderRadius.all(Radius.circular(sp(7))),
                    //             borderSide:
                    //                 BorderSide(width: 1, color: Colors.grey.shade700),
                    //           ),
                    //           prefixIcon: Icon(
                    //             Icons.search,
                    //             color: lgreen,
                    //           ),
                    //           fillColor: Colors.black,
                    //           filled: true,
                    //           hintText:
                    //               searchController.searchWords.value.searchWord != ""
                    //                   ? searchController.searchWords.value.searchWord
                    //                   : "Search.....",
                    //           hintStyle: TextStyle(color: Colors.white),
                    //           border: OutlineInputBorder(
                    //             borderRadius: BorderRadius.circular(sp(3)),
                    //             borderSide: BorderSide(
                    //               width: 0,
                    //               style: BorderStyle.none,
                    //             ),
                    //           )),
                    //     ),
                    //   ),
                    //   Expanded(
                    //     flex: 1,
                    //     child: IconButton(
                    //       onPressed: () {
                    //         //   Get.to(() => FilterSearch());
                    //       },
                    //       icon: FaIcon(
                    //         FontAwesomeIcons.filter,
                    //         color: Colors.white,
                    //         //size: 100,
                    //       ),
                    //     ),
                    //   ),
                    // ]),
                    SizedBox(
                      height: h(2),
                    ),
                    Expanded(
                      child: GridView.builder(
                          controller: scrollController,
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: sp(200),
                                  childAspectRatio: 1 / 1,
                                  crossAxisSpacing: sp(10),
                                  mainAxisSpacing: sp(10)),
                          itemCount:
                              subcategoryController.shownsubCatgeroy.length - 1,
                          itemBuilder: (BuildContext ctx, index) {
                            return showSubCategoryItem(
                                subcategoryController
                                    .shownsubCatgeroy[index + 1],
                                index + 1);
                          }),
                    ),
                  ]),
          )),
      bottomNavigationBar: mybottomBarWidget(),
    );
  }
}
