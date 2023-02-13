import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:skiddoapp/API/photos.dart/photos.dart';
import 'package:skiddoapp/models/event/Event.dart';
import 'package:skiddoapp/models/photos/Photo.dart';
import 'package:skiddoapp/services/auth_service.dart';

class GalleryController extends GetxController {
   var gallery  = [].obs;
  var loading = false.obs;
  PhotosHttpService photoApi = new PhotosHttpService();

  onInit() async {
    loading.value = true;
    String clientId = await AuthService.getUserId();
    var apievent = await photoApi.userDash(clientId);
    gallery.value = apievent;
    loading.value = false;
  }
}
