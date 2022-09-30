import 'package:elhasr/pages/Auth/controller/currentUser_controller.dart';
import 'package:elhasr/pages/Auth/profile/profile_page.dart';
import 'package:elhasr/pages/category/view/show_categ_item.dart';
import 'package:elhasr/pages/common_widget/mybottom_bar/my_bottom_bar.dart';
import 'package:elhasr/pages/common_widget/simple_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/size_config.dart';
import '../../common_widget/mybottom_bar/bottom_bar_controller.dart';
import '../control/category_controller.dart';
import 'show_category_item.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final scrollController = ScrollController();
  //final SearchController searchController = Get.put(SearchController());

  final CategoryController categoryController = Get.put(CategoryController());
  final CurrentUserController currentUserController =
      Get.put(CurrentUserController());
  final MyBottomBarCtrl myBottomBarCtrl = Get.put(MyBottomBarCtrl());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      categoryController.getdata();
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
    myBottomBarCtrl.selectedIndBottomBar.value = 0;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      drawer: Drawer(child: UserProfilePage(showbottombar: false)),
      appBar: simplAppbar(true),
      body: Obx(() => RefreshIndicator(
            onRefresh: categoryController.getdatarefresh,
            child: Column(children: [
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
              SizedBox(height: h(2)),
              SizedBox(
                height: h(30),
                child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage("assets/images/discount.jpg"),
                        ),
                      ),
                    )

                    //  FittedBox(
                    //   fit: BoxFit.fill,
                    //   child: Image.asset(
                    //     '',
                    //     fit: BoxFit.fill,
                    //   ),
                    // )

                    ),
              ),

              SizedBox(
                height: h(7),
                child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Text(
                        'departement'.tr,
                        style: GoogleFonts.tajawal(
                          textStyle: TextStyle(
                              color: Colors.blue,
                              fontSize: sp(14),
                              letterSpacing: .5),
                        ),
                      ),
                    )),
              ),
              SizedBox(
                height: h(50),
                child: GridView.builder(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    //controller: scrollController,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: sp(0.97),
                        crossAxisSpacing: sp(1),
                        mainAxisSpacing: sp(1),
                        crossAxisCount: 2),
                    //gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    //     maxCrossAxisExtent: sp(200),
                    //     childAspectRatio: 1 / 1,)
                    //     crossAxisSpacing: sp(10),
                    //     mainAxisSpacing: sp(10)),
                    itemCount: categoryController.shownCatgeroy.length - 1,
                    itemBuilder: (BuildContext ctx, index) {
                      return ShowCategoryItem(
                          shownItem:
                              categoryController.shownCatgeroy[index + 1],
                          selecteditem: index + 1);
                    }),
              ),
            ]),
          )),
      bottomNavigationBar: mybottomBarWidget(),
    );
  }
}
