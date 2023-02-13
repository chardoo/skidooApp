import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skiddoapp/models/photos/Photo.dart';
import 'package:skiddoapp/controller/cart_controller.dart';

// ignore: must_be_immutable
class CartItem extends StatelessWidget {
  Photo photo = Photo("", "", "", "", "", 0, "", "");

  CartController cartController = Get.find();
  CartItem({Key? key, required this.photo}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final int price = photo.price;
    return Card(
        elevation: 6,
        margin: const EdgeInsets.all(2),
        child: Padding(
            padding: const EdgeInsets.all(0),
            child: Container(
                height: 300,
                decoration: BoxDecoration(
                         color: Colors.black,
                border: Border.all(
                    width: 1, color: const Color.fromARGB(255, 246, 246, 246)),
                borderRadius: new BorderRadius.all(const Radius.circular(10.0)),
                    image: DecorationImage(
                        // image: CachedNetworkImage()
                        image: NetworkImage(photo.url),
                        fit: BoxFit.cover)),
                child: Container(
                    alignment: Alignment.bottomRight,
                    padding: const EdgeInsets.all(12),
                    child: Container(
                        margin: EdgeInsets.all(0),
                        height: 30,
                        color: Color.fromARGB(255, 15, 7, 7),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(photo.eventName,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(179, 233, 53, 53))),
                            SizedBox(width: 50),
                            IconButton(
                              onPressed: () {
                                cartController.cartItems.remove(photo);
                                cartController.total();
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Image Removed')));
                              },
                              icon: const Icon(
                                Icons.remove,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ))))));
  }
}
