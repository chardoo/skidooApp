import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:skiddoapp/API/photoGrapher/photographer.dart';
import 'package:skiddoapp/API/photos.dart/photos.dart';
import 'package:skiddoapp/models/event/Event.dart';
import 'package:skiddoapp/models/photos/Photo.dart';
import 'package:skiddoapp/services/auth_service.dart';

class PhotoGrapherController extends GetxController {
  var photoGraphers = [].obs;
  var foundPhotoGraphers = [].obs;

  PhotoGraphersHttpService photoGraphersHttpService =
      new PhotoGraphersHttpService();

  @override
  onInit() async {
    var results = await photoGraphersHttpService.getPhotoGraphers("eventName");
    photoGraphers.value = results;
  }

  void searhPhotographer(dynamic payload) async {
    var searchResults =
        await photoGraphersHttpService.searchPhotoGraphers(payload);
    foundPhotoGraphers.value = searchResults;
  }
}
