
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';


class DocumentsHttpService {
  static const BASE_URL = "https://docoradi-app-phrl5joxbq-uc.a.run.app";
  //static const BASE_URL = "http://localhost:8080/";
  static const documentURL = BASE_URL + '/service/documents/initialDocuments';
  static const mimeUrl = BASE_URL + '/service/documents/getDocumentTypes';
  static const mimeFiles = BASE_URL + '/service/documents/getFilesByMimeTypes';
  static const searchURL = BASE_URL + '/service/documents/search';

  // Future<List<Documents>> getDocuments() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   final res = await post(Uri.parse(documentURL),
  //       body: {'userId': prefs.getString('email')});

  //   if (res.statusCode == 200) {
  //     List<dynamic> body = jsonDecode(res.body);
  //     List<Documents> documents = body
  //         .map(
  //           (dynamic item) => Documents.fromMap(item),
  //         )
  //         .toList();
  //     return documents;
  //   } else {
  //     throw "Unable to retrieve posts.";
  //   }
  // }

  // Future<List<MimeTypeModel>> getMime() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   final res = await post(Uri.parse(mimeUrl),
  //       body: {'userId': prefs.getString('email')});
  //   if (res.statusCode == 200) {
  //     dynamic data = jsonDecode(res.body);
  //     List<dynamic> body = data["filteredArr"];
  //     List<MimeTypeModel> mimeTypes = body
  //         .map(
  //           (dynamic item) => MimeTypeModel.fromMap(item),
  //         )
  //         .toList();
  //     return mimeTypes;
  //   } else {
  //     throw "Unable to retrieve posts.";
  //   }
  // }

  // Future<List<Documents>> getDocumentsByMimeTypes(resquestData) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   final res = await post(Uri.parse(mimeFiles),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //       },
  //       body: jsonEncode(resquestData));

  //   if (res.statusCode == 200) {
  //     List<dynamic> body = jsonDecode(res.body);
  //     List<Documents> documents = body
  //         .map(
  //           (dynamic item) => Documents.fromMap(item),
  //         )
  //         .toList();
  //     return documents;
  //   } else {
  //     throw "Unable to retrieve posts.";
  //   }
  // }

  // Future<List<Documents>> searchDocuments(String searchIndex) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   final searchresults = await post(Uri.parse(searchURL),
  //       body: {'userId': prefs.getString('email'), 'searchIndex': searchIndex});
  //   if (searchresults.statusCode == 200) {
  //     List<dynamic> body = jsonDecode(searchresults.body);
  //     print("body");
  //     print(body);
  //     List<Documents> documents = body
  //         .map(
  //           (dynamic item) => Documents.fromMap(item),
  //         )
  //         .toList();
  //     return documents;
  //   } else {
  //     throw "Unable to retrieve posts.";
  //   }
  // }
}
