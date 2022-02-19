import 'package:elhasr/pages/common_widget/mybottom_bar/my_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/size_config.dart';
import '../control/category_controller.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final scrollController = ScrollController();
  //final SearchController searchController = Get.put(SearchController());

  final CategoryController categoryController = Get.put(CategoryController());
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
      appBar: AppBar(),
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
              SizedBox(
                height: h(2),
              ),
              Expanded(
                child: GridView.builder(
                    controller: scrollController,
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: sp(200),
                        childAspectRatio: 4 / 2,
                        crossAxisSpacing: sp(10),
                        mainAxisSpacing: sp(10)),
                    itemCount: categoryController.shownCatgeroy.length - 1,
                    itemBuilder: (BuildContext ctx, index) {
                      return Text('Ahmed');

                      // shownCatgeroy(categoryController.shownCatgeroy[index + 1]);
                    }),
              ),
            ]),
          )),
      bottomNavigationBar: mybottomBarWidget(),
    );
  }
}
