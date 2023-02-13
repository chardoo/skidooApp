import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:skiddoapp/components/common/imageComponentWithAddtoCart.dart';
import 'package:skiddoapp/controller/cart_controller.dart';
import 'package:skiddoapp/controller/home_controller.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class SearchResultsView extends StatelessWidget {
  final HomeController searchController = Get.find();
  final CartController Cartcontroller = Get.put(CartController());
  SearchResultsView({Key? key}) : super(key: key);
  Color mycolor = Color.fromARGB(255, 15, 19, 26);
  Color whitecolor = Colors.white;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Get.offNamed('/home');
          },
          color: const Color.fromARGB(255, 17, 17, 17), // <-- SEE HERE
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.shopping_bag,
              color: whitecolor,
            ),
            onPressed: () {
              Get.offNamed('/cart');
            },
          )
        ],
        backgroundColor: mycolor,
        title: Text(
          "search results",
          style: TextStyle(
            color: whitecolor,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
      ),
      body: SafeArea(
          child: Scaffold(
              backgroundColor: const Color.fromARGB(255, 12, 12, 12),
              body: Column(children: [
                const SizedBox(
                  height: 10,
                ),
                Obx(() => Expanded(
                      child: searchController.loading.value == true
                          ? Container(
                              alignment: Alignment.topCenter,
                              margin: const EdgeInsets.only(top: 20),
                              child: const CircularProgressIndicator(
                                backgroundColor: Colors.grey,
                                color: Colors.purple,
                                strokeWidth: 10,
                              ))
                          : Container(
                              margin:
                                  const EdgeInsets.only(left: 16, right: 16),
                              child: Obx(
                                () => SizedBox(
                                    child: searchController
                                            .searchImage.value.isEmpty
                                        ? Container(
                                            margin: const EdgeInsets.only(
                                                left: 60, right: 40, top: 100),
                                            child: const Text(
                                                "sorry search again in a 30secs later ",
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 221, 217, 217))),
                                          )
                                        :
                                        //  ListView.builder(
                                        //     scrollDirection: Axis.vertical,
                                        //     itemCount: searchController
                                        //         .searchImage.value.length,
                                        //     itemBuilder:
                                        //         (BuildContext ctxt, int index) {
                                        //       return SearchImageComponents(
                                        //           photo: searchController
                                        //               .searchImage
                                        //               .value[index]);
                                        //     },
                                        //   )

                                        Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: MasonryGridView.count(
                                                crossAxisCount: 2,
                                                mainAxisSpacing: 8,
                                                crossAxisSpacing: 8,
                                                itemCount: searchController
                                                    .searchImage.length,
                                                itemBuilder: (context, index) {
                                                  return Column(children: [
                                                    // ClipRRect(
                                                    //   borderRadius:
                                                    //       BorderRadius.circular(
                                                    //           15),
                                                    //   child: Image.network(
                                                    //     searchController
                                                    // .searchImage[index].url,
                                                    //     fit: BoxFit.cover,
                                                    //   ),
                                                    // ),

                                                    SearchImageComponents(
                                                      photo: searchController
                                                          .searchImage[index],
                                                    )
                                                  ]);
                                                }))
                                    // Padding(
                                    //     padding: const EdgeInsets.only(
                                    //         top: 12.0),
                                    //     child: StaggeredGrid.count(

                                    //       crossAxisCount: 2,
                                    //       mainAxisSpacing: 4.0,
                                    //       crossAxisSpacing: 4.0,
                                    //       // staggeredTiles: _staggeredTiles,
                                    //       children: searchController
                                    //           .searchImage.value
                                    //           .map((dynamic item) {
                                    //         return SearchImageComponents(
                                    //             photo: item);
                                    //       }).toList(),
                                    //     )
                                    //     )

                                    ),
                              ),
                            ),
                    ))
              ]))),
    );
  }
}
