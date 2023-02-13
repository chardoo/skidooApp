import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

import 'package:get/get.dart';
import 'package:skiddoapp/models/photos/Photo.dart';
import 'package:skiddoapp/controller/cart_controller.dart';

// ignore: must_be_immutable
class SearchImageComponents extends StatelessWidget {
  Photo photo = new Photo("", "", "", "", "", 0, "", "");
  SearchImageComponents({Key? key, required this.photo}) : super(key: key);
  CartController cartController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            photo.url,
            fit: BoxFit.cover,
          ),
        ),
        Container(
            alignment: Alignment.topRight,
            padding: const EdgeInsets.all(12),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
              Container(
                //  padding: EdgeInsets.all(5),
                decoration: const BoxDecoration(
                  shape: BoxShape.rectangle,
                  // color: Color.fromARGB(255, 242, 239, 239),
                ),
                child: Text("¢${photo.price.toString()}",
                    style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.red)),
              ),
              const SizedBox(
                height: 170,
              ),
              Container(
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromARGB(255, 207, 200, 200),
                  ),
                  child: photo.price == 0
                      ? GetBuilder<CartController>(
                          init: CartController(),
                          builder: (value) => InkWell(
                                onTap: () async {
                                  value.downloadeImage(photo.url);
                                },
                                child: const Icon(Icons.download,
                                    size: 15, color: Colors.black),
                              ))
                      : GetBuilder<CartController>(
                          init: CartController(),
                          builder: (value) => InkWell(
                                onTap: () {
                                  if (!value.cartItems.contains(photo)) {
                                    value.cartItems.add(photo);
                                    value.total();
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                            content: Text('Image added')));
                                  } else {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                            content:
                                                Text('Already added')));
                                  }
                                },
                                child: const Icon(Icons.shopping_cart,
                                    size: 15, color: Colors.black),
                              )))
            ]))
      ],
    );

    // Card(
    //     elevation: 6,
    //     margin: const EdgeInsets.all(2),
    //     child: Padding(
    //         padding: const EdgeInsets.all(0),
    //         child: Container(
    //             height: 250,
    //             decoration: BoxDecoration(
    //                 color: Colors.black,
    //                 border: Border.all(
    //                     width: 1, color: const Color.fromARGB(255, 246, 246, 246)),
    //                 // add drop shadow
    //                 // boxShadow: const [
    //                 //   BoxShadow(
    //                 //       blurRadius: 2, spreadRadius: 2, color: Colors.grey)
    //                 // ],
    //                  borderRadius: new BorderRadius.all(const Radius.circular(10.0)),
    //                 image: DecorationImage(
    //                     image: NetworkImage(photo.url), fit: BoxFit.cover)),
    //             child: Container(
    //                 alignment: Alignment.topRight,
    //                 padding: const EdgeInsets.all(12),
    //                 child: Container(
    //                     child: Column(
    //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                   children: [
    //                     Container(
    //                       //  padding: EdgeInsets.all(5),
    //                       decoration: const BoxDecoration(
    //                         shape: BoxShape.rectangle,
    //                        // color: Color.fromARGB(255, 242, 239, 239),
    //                       ),
    //                       child: Text("¢${photo.price.toString()}",
    //                           style: const TextStyle(
    //                               fontSize: 15,
    //                               fontWeight: FontWeight.bold,
    //                               color: Colors.red)),
    //                     ),
    //                     const SizedBox(
    //                       height: 50,
    //                     ),
    //                     Container(
    //                         padding: const EdgeInsets.all(5),
    //                         decoration: const BoxDecoration(
    //                           shape: BoxShape.circle,
    //                           color: Color.fromARGB(255, 242, 239, 239),
    //                         ),
    //                         child: photo.price == 0
    //                             ? GetBuilder<CartController>(
    //                                 init: CartController(),
    //                                 builder: (value) => InkWell(
    //                                       onTap: () async {
    //                                         value.downloadeImage(photo.url);
    //                                       },
    //                                       child: const Icon(Icons.download,size: 15,
    //                                           color: Colors.red),
    //                                     ))
    //                             : GetBuilder<CartController>(
    //                                 init: CartController(),
    //                                 builder: (value) => InkWell(
    //                                       onTap: () {
    //                                         if (!value.cartItems
    //                                             .contains(photo)) {
    //                                           value.cartItems.add(photo);
    //                                           value.total();
    //                                           ScaffoldMessenger.of(context)
    //                                               .showSnackBar(const SnackBar(
    //                                                   content:
    //                                                       Text('Image added')));
    //                                         } else {
    //                                           ScaffoldMessenger.of(context)
    //                                               .showSnackBar(const SnackBar(
    //                                                   content: Text(
    //                                                       'Already added')));
    //                                         }
    //                                       },
    //                                       child: const Icon(Icons.shopping_cart, size: 15,
    //                                           color: Colors.red),
    //                                     )))
    //                   ],
    //                 ))))));
  }
}
