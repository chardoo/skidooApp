import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skiddoapp/controller/cart_controller.dart';
// import 'package:photoapp_mobile/contollers/cart_controller.dart';

class imageComponents extends StatelessWidget {
  String imageURL = "";
  imageComponents({required this.imageURL});

  CartController cartController = Get.put(CartController());
  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 6,
        margin: const EdgeInsets.all(2),
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Container(
            height: 250,
            decoration: BoxDecoration(
                color: Colors.black,
                border: Border.all(
                    width: 1, color: const Color.fromARGB(255, 246, 246, 246)),
                borderRadius: const BorderRadius.all(const Radius.circular(10.0)),
                image: DecorationImage(
                    image: NetworkImage(imageURL), fit: BoxFit.cover)),
            child: Container(
                alignment: Alignment.topRight,
                padding: const EdgeInsets.all(12),
                child: Container(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                      Container(
                          padding: const EdgeInsets.all(5),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromARGB(255, 242, 239, 239),
                          ),
                          child: GetBuilder<CartController>(
                              init: CartController(),
                              builder: (value) => InkWell(
                                    onTap: () async {
                                      value.downloadeImage(imageURL);
                                    },
                                    child: const Icon(Icons.download,
                                        color: Colors.red),
                                  )))
                    ]))),
          ),
        ));
  }
}
