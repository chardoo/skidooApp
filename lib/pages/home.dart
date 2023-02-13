import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skiddoapp/components/Screens/Account.dart';
import 'package:skiddoapp/components/Screens/Gallery.dart';
import 'package:skiddoapp/components/Screens/Home.dart';
import 'package:skiddoapp/controller/Gallery_controller.dart';
import 'package:skiddoapp/controller/cart_controller.dart';
import 'package:skiddoapp/controller/home_controller.dart';
import 'package:skiddoapp/controller/userProfile_controller.dart';

class HomeScreen extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());
  final CartController Cartcontroller = Get.put(CartController());
  final GalleryController controllerr = Get.put(GalleryController());
   final UserController rerer =     Get.put(UserController());
  // final DocumentController controller1 = Get.put(DocumentController());
  static const colorizeTextStyle =
      TextStyle(fontSize: 25.0, fontFamily: 'SF', color: Colors.redAccent);
  bool secureTest = true;
   Color mycolor = Color.fromARGB(255, 15, 19, 26);
    Color whitecolor = Colors.white;
  HomeScreen({Key? key}) : super(key: key);

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  // ignore: prefer_final_fields
  static List<Widget> _widgetOptions = <Widget>[
    HomeNavigationScreen(),
    GalleryNavigationScreen(),
    AccountNavigationScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: body(context));
  }

  Widget body(context) {
    return SafeArea(
        child: Scaffold(
            // backgroundColor: const Color.fromARGB(255, 177, 178, 179),
            body: Obx(() => Center(
                  child: _widgetOptions.elementAt(controller.index.value),
                )),
            resizeToAvoidBottomInset: false,
            
            bottomNavigationBar: Obx(
              () => BottomNavigationBar(
                unselectedItemColor: Color.fromARGB(255, 141, 137, 137),
                backgroundColor: Color.fromARGB(255, 10, 13, 17),
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.home,
                      ),
                      label: 'Home',
                      backgroundColor: Colors.white),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.photo_album,
                    ),
                    label: 'Gallery',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.person,
                    ),
                    label: 'Account',
                  )
                ],
                currentIndex: controller.index.value,
                selectedItemColor: Color.fromARGB(255, 255, 255, 255),
                onTap: (value) {
                  controller.index.value = value;
                },
              ),
            )));
  }
}
