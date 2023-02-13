import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skiddoapp/components/common/imageComponent.dart';
import 'package:skiddoapp/components/common/imageComponentWithAddtoCart.dart';
import 'package:skiddoapp/controller/Gallery_controller.dart';
import 'package:skiddoapp/controller/document_controller.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class GalleryNavigationScreen extends StatelessWidget {
  GalleryNavigationScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final GalleryController controller = Get.put(GalleryController());

    return RefreshIndicator(
      onRefresh: () async {
        print("refresh now ");
        controller.onInit();
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            "Gallery",
            style: TextStyle(
                color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.black,
        ),
        body: SafeArea(
            child: Scaffold(
                backgroundColor: const Color.fromARGB(255, 15, 15, 15),
                body: Column(children: [
                  Obx(() => Expanded(
                        child: controller.loading.value == true
                            ? Container(
                                alignment: Alignment.topCenter,
                                margin: const EdgeInsets.only(top: 20),
                                child: const CircularProgressIndicator(
                                  backgroundColor: Colors.grey,
                                  color: Colors.purple,
                                  strokeWidth: 10,
                                ))
                            : Container(
                                margin: const EdgeInsets.only(
                                    left: 16, right: 16, top: 10),
                                child: SizedBox(
                                    child: controller.gallery.value.isEmpty
                                        ? Container(
                                            margin: const EdgeInsets.only(
                                                left: 40, right: 40, top: 100),
                                            child: const Text(
                                                "No images in your Gallery ",
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 221, 217, 217))),
                                          )
                                        : Obx(() => Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 12.0),
                                              child: 
                                              ListView.builder(
                                                
                                                  itemCount: controller.gallery.length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    return imageComponents(imageURL: controller.gallery[index].url,);
                                                  }),
                                              // StaggeredGrid.count(
                                              //   crossAxisCount: 2,
                                              //   mainAxisSpacing: 4.0,
                                              //   crossAxisSpacing: 4.0,
                                              //   // staggeredTiles: _staggeredTiles,
                                              //   children:
                                              //       controller.gallery.map((
                                              //     dynamic item,
                                              //   ) {
                                              //     return imageComponents(
                                              //         imageURL: item.url!);
                                              //   }).toList(),
                                              // )
                                            ))),
                              ),
                      ))
                ]))),
      ),
    );
  }
}
