import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skiddoapp/controller/login_controller.dart';
import 'package:skiddoapp/controller/signUp_controller.dart';
import 'package:skiddoapp/controller/userProfile_controller.dart';
import 'package:skiddoapp/pages/home.dart';
import 'package:skiddoapp/pages/signUp.dart';
import 'package:skiddoapp/pages/cartScreen.dart';
import 'package:skiddoapp/pages/login.dart';
import 'package:skiddoapp/pages/serchview.dart';
import 'package:skiddoapp/pages/splash.dart';
import 'package:firebase_core/firebase_core.dart';


import 'package:camera/camera.dart';
import 'package:skiddoapp/services/auth_service.dart';

// import 'package:camera/camera.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final cameras = await availableCameras();
  final firstCamera = cameras.first;

  // Obtain a list of the available cameras on the device.
  await Firebase.initializeApp();
  var prefs = await SharedPreferences.getInstance();
  Get.put(prefs);
  String token = await AuthService.getToken();

  // Get.put(prefs);
  Get.lazyPut(() => UserController());
  Get.lazyPut<LoginController>(() => LoginController());
  Get.put(SignUpController());
  runApp(GetMaterialApp(
    home: token.isEmpty ? LoginScreen() : HomeScreen(),
    getPages: [
      GetPage(
        name: '/splash',
        page: () => const SplashScreen(),
      ),
      GetPage(
        name: '/home', page: () => HomeScreen(),
        //middlewares: [AuthMiddleWare()]
      ),
      GetPage(
        name: '/signUp',
        page: () => SignUpScreen(
          camera: firstCamera,
        ),
      ),
      GetPage(name: '/login', page: () => LoginScreen()),
      GetPage(name: '/searchresults', page: () => SearchResultsView()),
      GetPage(name: '/cart', page: () => CartScreen()),
    ],
  ));
}
