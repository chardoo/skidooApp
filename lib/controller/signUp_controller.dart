import 'dart:async';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:skiddoapp/API/Auth/auth.dart';
import 'dart:async';
import 'dart:io';

// import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
// import '../contollers/user_controller.dart';
// import '../services/auth/auth_service.dart';
// import "../apis/httpService.dart";
// import '../configuration/constants.dart';
//import '../services/http/constants.dart';

class SignUpController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final emailController = TextEditingController();
  final contactController = TextEditingController();
  final userNameController = TextEditingController();
  var ispasswordHidden = true.obs;
  var isError = false.obs;
  var Imagepath = ''.obs;
  var imageName = ''.obs;
  var isRegisterClicked = false.obs;
  late File filetry;
  AuthHttpService LoginApi = AuthHttpService();

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field cannot be empty';
    }
    if (value.length < 4) {
      return 'Password too short';
    }
    return null;
  }
   String? userNameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field cannot be empty';
    }
    if (value.length < 4) {
      return 'Password too short';
    }
    return null;
  }

  String? contactValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field cannot be empty';
    }
    if (value.length < 4) {
      return 'Password too short';
    }
    return null;
  }

  String? nameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field cannot be empty';
    }
    if (value.length < 4) {
      return 'Password too short';
    }
    return null;
  }

  String? emailValidator(String? value) {
    final _emailRegExp = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

    if (value == null || value.isEmpty) {
      return 'This field cannot be empty';
    }
    if (value.length < 4) {
      return 'Username too short';
    }
    return null;
  }

  void selectFile() async {
    final file = await FilePicker.platform.pickFiles(
        type: FileType.custom, allowedExtensions: ['png', 'jpg', 'jpeg']);
    if (file != null) {
      filetry = File(file.files.single.path!);
      // _file = File(file.files.single.path!);
      // fileName.value = file.files.single.name;
      // _platformFile = file.files.first;
      // filePath.value = _file.path;
    }
    // print("helloe r");
    // print(_file.path);
  }

  Future<bool> register(File file) async {
    Map<String, String> loginDetails = {
      "password": passwordController.text,
      "email": emailController.text,
      "contact": " ",
      "name": userNameController.text.isNotEmpty ? userNameController.text : "chardoo"
    };
    return await LoginApi.register(loginDetails, File(Imagepath.value));
  }
}
