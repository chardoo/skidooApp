// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:skiddoapp/API/photos.dart/photos.dart';
import 'package:skiddoapp/models/event/Event.dart';
import 'package:skiddoapp/models/photos/Photo.dart';
import 'package:skiddoapp/controller/Gallery_controller.dart';
import 'package:skiddoapp/controller/home_controller.dart';
import 'package:skiddoapp/pages/home.dart';
import 'package:skiddoapp/services/auth_service.dart';
import 'package:lecle_downloads_path_provider/lecle_downloads_path_provider.dart';
import 'package:open_file/open_file.dart';

class CartController extends GetxController {
  // ignore: deprecated_member_use
  PhotosHttpService apis = new PhotosHttpService();
  HomeController homeController = Get.find();
  GalleryController galleryController = Get.put(GalleryController());
  List<Photo> cartItems = List<Photo>.empty().obs;

  var totalAmount = 0.obs;
  var referenceId = "".obs;

  void total() {
    totalAmount.value = 0;
    for (var i = 0; i < cartItems.length; i++) {
      totalAmount += cartItems[i].price;
    }
    update();
  }

  onInit() async {
    total();
  }

  Future<dynamic> payForImages(
    String amount,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    Map<String, dynamic> payload = {
      "email": prefs.getString('email'),
      "amount": amount
    };
    return await apis.payForImages(payload);
  }

  Future<dynamic> completePayment(
    dynamic payload,
  ) async {
    String clientIds = await AuthService.getUserId();
    var mylist = [];
    for (var element in cartItems) {
      mylist.add({
        "pictureId": element.id,
        "clientId": clientIds,
        "userId": element.userId,
      });
    }
    Map<String, dynamic> payload = {
      "amount": totalAmount.value.toString(),
      "referenceId": referenceId.value,
      "clientId": clientIds,
      "PaidImage": mylist
    };
    var me = await apis.completePayment(payload);
    if (me['paidImages']['count'] > 0) {
      Get.snackbar(
        "Successful Payment",
        "Check your Gallery to download Image",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Color.fromARGB(255, 238, 244, 238),
      );
      homeController.index.value = 1;
      galleryController.onInit();
      Get.to(HomeScreen());
    } else {
      Get.snackbar(
        "Sorry Payment Unsuccessful",
        "Make Payment  again",
        icon: Icon(Icons.person, color: Colors.white),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Color.fromARGB(255, 238, 244, 238),
      );
      Get.offAllNamed("/cart");
    }
    return me;
  }

  void downloadeImage(String url) async {
    try {
      Get.snackbar(
        "Images is been Downloaded",
        " ",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Color.fromARGB(255, 238, 244, 238),
      );
      var newString = url.substring(url.length - 15);

      var dir = await DownloadsPath.downloadsDirectory();
      String downloadurl = '${dir?.path}/$newString';
      var response = await Dio().download(url, downloadurl);
      if (response.statusCode == 200) {
        Get.snackbar(
          "Successful Downloads",
          "Check your downloads",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Color.fromARGB(255, 238, 244, 238),
        );
       // print("hello how are oyur");
       // print(downloadurl);
        await OpenFile.open(downloadurl);
      }
    } catch (e) {
      print(e);
    }
  }
}
