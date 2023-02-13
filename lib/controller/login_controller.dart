import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:skiddoapp/API/Auth/auth.dart';
import 'package:skiddoapp/models/Auth/LoginResponse.dart';
import 'package:skiddoapp/services/auth_service.dart';

class LoginController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  var ispasswordHidden = true.obs;
  var isError = false.obs;
  AuthHttpService LoginApi = AuthHttpService();

  AuthService service = AuthService();
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

  String? emailValidator(String? value) {
    //email RegExp
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

  Future<dynamic> login() async {
    
    Map<String, dynamic> loginDetails = {
      "password": passwordController.text.trim().toString(),
      "email": emailController.text.trim().toString(),
    };
    var response = await LoginApi.login(loginDetails);
    if (response.runtimeType == LoginResponseObject) {
      await AuthService.setToken(response.token);
      await AuthService.setUniqueName(response.uniqueName);
      await AuthService.setId(response.id);
      await AuthService.setEmail(response.email);
      await AuthService.setName(response.name);
      return true;
    } else {
      return false;
    }
  }

  // ignore: non_constant_identifier_names
  Future<bool> createUser() async {
    Map<String, dynamic> loginDetails = {
      "password": passwordController.text,
      "email": emailController.text,
    };
    // var response = await http.adminlogin(loginDetails);
    // await AuthService.setToken(response.token);
    // await AuthService.setId(response.id);
    // await AuthService.setEmail(response.email);
    // await AuthService.setRole(response.role);
    // var userController = Get.put(UserController());
    // userController.authenticated = true;

    return false;
  }
}
