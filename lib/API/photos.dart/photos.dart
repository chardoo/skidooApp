import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skiddoapp/models/event/Event.dart';
import 'package:skiddoapp/models/photos/Photo.dart';

class PhotosHttpService {
  // static const BASE_URL = "http://api.skiiddo.com";
  static const BASE_URL = "http://api.skiiddo.com";
  static const loginApi = BASE_URL + '/client/login';
  static const userdashApi = BASE_URL + '/client/clientDashboard';
  static const eventsApi = BASE_URL + '/client/events';
  static const searchEndpoint = BASE_URL + '/client/searchEventImages';
  static const payForImageURL = BASE_URL + '/client/payForImages';
  static const completePaymentURL = BASE_URL + '/client/completePayment';

  Future<List<Photo>> userDash(String clientId) async {
    print("clientId");
    print(clientId);
    var res = await post(Uri.parse(userdashApi), body: {"clientId": clientId});
    print("heeloeroroeroeroeroer");
    print(res.body);
    List<dynamic> body = jsonDecode(res.body);
    List<Photo> photos = body
        .map(
          (dynamic item) => Photo.fromMap(item),
        )
        .toList();

    return photos;
  }

  Future<List<Event>> getEvent(String searchKey) async {
    var res =
        await post(Uri.parse(eventsApi), body: {"queryString": searchKey});
    List<dynamic> body = jsonDecode(res.body);
    List<Event> events = body
        .map(
          (dynamic item) => Event.fromMap(item),
        )
        .toList();
    return events;
  }

  Future<List<Photo>> SearchEventImages(
      String eventName, String uniqueName) async {
    print("uniqur");
    print(uniqueName);
    var res = await post(Uri.parse(searchEndpoint),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(
            {"uiqueName": uniqueName, "eventName": eventName, "isTrue": true}));

    print("response of the search");
    print(res.body);
    List<dynamic> body = jsonDecode(res.body);
    List<Photo> events = body
        .map(
          (dynamic item) => Photo.fromMap2(item),
        )
        .toList();
    return events;
  }

  Future<dynamic> payForImages(payload) async {
    var res = await post(Uri.parse(payForImageURL), body: payload);
    print("body response");
    print(res.body);
    return jsonDecode(res.body);
  }

  Future<dynamic> completePayment(payload) async {
    var res = await post(Uri.parse(completePaymentURL),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(payload));
    print("body response");
    print(res.body);
    // ignore: unrelated_type_equality_checks
    if (res.statusCode == '200') {
      return jsonDecode(res.body);
    } else {
      return jsonDecode(res.body);
    }
  }
}
