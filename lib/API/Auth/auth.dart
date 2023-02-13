import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as httpre;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skiddoapp/models/Auth/LoginResponse.dart';
import 'package:skiddoapp/models/badrequest.dart';
// import 'package:docoradi/Models/Auth/LoginResponse.dart';

class AuthHttpService {
  // static const BASE_URL = "https://docoradi-app-phrl5joxbq-uc.a.run.app";
  static const BASE_URL = "http://api.skiiddo.com";
  static const userloginUrl = BASE_URL + '/client/login';
  static const userRegisterUrl = BASE_URL + '/client/createClient';
  Future<dynamic> login(Map<String, dynamic> resquestData) async {
    var res = await post(Uri.parse(userloginUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(resquestData));
    print("back tot ejrjer");
    print(res.body);
    switch (res.statusCode) {
      case 200:
        dynamic body = jsonDecode(res.body);
        LoginResponseObject LoggedInuser = LoginResponseObject.fromJson(body);
        return LoggedInuser;
      default:
        dynamic body = jsonDecode(res.body);
        BadRequest badRequest = BadRequest.fromMap(body);
        return badRequest;
    }
  }

  Future<dynamic> register(Map<String, String> resquestData, File file) async {
    // Map<String, String> resquestData, List<File> file) async {
    print("hello");

    var request = httpre.MultipartRequest(
      "POST",
      Uri.parse(userRegisterUrl),
    );

    List<httpre.MultipartFile> data = [];

    // for (var element in file) {
    //   data.add(httpre.MultipartFile(
    //       'picture', element.readAsBytes().asStream(), element.lengthSync(),
    //       filename: element.path));
    // }
    print("hehehehe whehwehwe");
    print(resquestData);

    request.fields.addAll(resquestData);

    // request.files.addAll(data);

    // for (var i = 0; i < file.length; i++) {
    //   request.files.add(httpre.MultipartFile(
    //       'picture', file[i].readAsBytes().asStream(), file[i].lengthSync(),
    //       filename: file[i].path));
    // }
    print(file.path);
    request.files.add(httpre.MultipartFile(
        'picture', file.readAsBytes().asStream(), file.lengthSync(),
        filename: file.path));
    var res = await request.send();
    print("response");
    print(res.statusCode);
    print(res.reasonPhrase);
    switch (res.statusCode) {
      case 201:
        return true;
      default:
        return false;
    }
  }
}
