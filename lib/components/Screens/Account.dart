// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skiddoapp/controller/login_controller.dart';
import 'package:skiddoapp/controller/signUp_controller.dart';

// import 'package:get/get_core/src/get_main.dart';

import 'package:skiddoapp/controller/userProfile_controller.dart';
import 'package:skiddoapp/pages/login.dart';
import 'package:skiddoapp/services/auth_service.dart';

class AccountNavigationScreen extends StatelessWidget {
  final UserController controller = Get.put(UserController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: const Text(
            "Account",
            style: TextStyle(
                color: Colors.white, fontSize: 26, fontWeight: FontWeight.w700),
          ),
          backgroundColor: Colors.black,
        ),
        body: Container(
          color: const Color.fromARGB(255, 22, 22, 22),
          child: Container(
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 22, 22, 22),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            margin: const EdgeInsets.only(left: 16, right: 16, top: 23),
            height: 544,
            child: ListView(
              children: <Widget>[
                ListTile(
                  leading: const Icon(
                    Icons.map,
                    color: Colors.white,
                  ),
                  title: Text(
                    controller.name,
                    style: const TextStyle(
                        color: Color.fromARGB(255, 230, 233, 239)),
                  ),
                ),
                ListTile(
                  leading: const Icon(
                    Icons.photo_album,
                    color: Colors.white,
                  ),
                  title: Text(controller.email,
                      style: const TextStyle(
                          color: Color.fromARGB(255, 230, 233, 239))),
                ),
                const ListTile(
                  leading: Icon(
                    Icons.settings,
                    color: Colors.white,
                  ),
                  title: Text('Setting',
                      style:
                          TextStyle(color: Color.fromARGB(255, 230, 233, 239))),
                ),
                const SizedBox(
                  height: 200,
                ),
                ListTile(
                  title: TextButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Center(
                                    child: Text(
                                  'Skiddo',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                )),
                                content: const Padding(
                                  padding:
                                      EdgeInsets.only(top: 5.0, bottom: 18),
                                  child: Text(
                                    "Are you Sure you want to Log Out",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: const Text("CANCEL",
                                        style: TextStyle(color: Colors.red)),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      Get.back();
                                      // Navigator.pushReplacement();
                                      // await Navigator.of(context)
                                      //     .push(MaterialPageRoute(
                                      //   builder: (context) => LoginScreen(),
                                      // ));
                                      Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                              builder: (BuildContext context) {
                                        return LoginScreen();
                                      }));
                                    },
                                    child: const Text(
                                      "CONFIRM",
                                      style: TextStyle(color: Colors.blue),
                                    ),
                                  ),
                                ],
                              );
                            });
                      },
                      child: const Text("Log Out",
                          style: TextStyle(color: Colors.white))),
                ),
              ],
            ),
          ),
        ));
  }
}
