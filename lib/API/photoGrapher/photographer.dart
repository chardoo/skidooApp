import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skiddoapp/models/event/Event.dart';
import 'package:skiddoapp/models/photographer/photographerModel.dart';
import 'package:skiddoapp/models/photos/Photo.dart';

class PhotoGraphersHttpService {
  // static const BASE_URL = "http://api.skiiddo.com";
  static const BASE_URL = "http://api.skiiddo.com";
  static const getPhotgraphers = '$BASE_URL/client/getphotographers';
  static const searchPhotgraphers = '$BASE_URL/client/searchPhotographers';
  Future<List<PhotographerModel>> getPhotoGraphers(dynamic payload) async {
    print("get photographers");

    var res = await post(Uri.parse(getPhotgraphers), body: payload);
    List<dynamic> body = jsonDecode(res.body);
    List<PhotographerModel> photoGraphers = body
        .map(
          (dynamic item) => PhotographerModel.fromJson(item),
        )
        .toList();

    return photoGraphers;
  }

  Future<List<PhotographerModel>> searchPhotoGraphers(dynamic payload) async {
    print("search photographers");

    var res = await post(Uri.parse(searchPhotgraphers), body: payload);
    List<dynamic> body = jsonDecode(res.body);
    List<PhotographerModel> photoGraphers = body
        .map(
          (dynamic item) => PhotographerModel.fromJson(item),
        )
        .toList();
    print("hello ajsjjds");
    print(photoGraphers);
    return photoGraphers;
  }
}
