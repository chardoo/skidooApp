import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skiddoapp/controller/login_controller.dart';

class LoginScreen extends StatelessWidget {
  final LoginController controller = Get.put(LoginController());

  Color mycolor = const Color.fromARGB(255, 15, 19, 26);
  static const colorizeTextStyle =
      TextStyle(fontSize: 25.0, fontFamily: 'SF', color: Colors.redAccent);
  bool secureTest = true;
  bool isError = false;
  
  LoginScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 5,
          centerTitle: true,
          title: const Text(
            "skiddo",
            style: TextStyle(
                color: Colors.white, fontSize: 26, fontWeight: FontWeight.w700),
          ),
          backgroundColor: mycolor,
        ),
        backgroundColor: mycolor,
        body: body(context));
  }

  Widget body(context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: mycolor,
            body: ListView(children: [
              Container(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        // alignment: AlignmentGeometry.lerp(a, b, t)
                        margin: const EdgeInsets.only(
                            left: 30, bottom: 15, top: 15),
                        child: const Text("Let's sign you in.",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 22,
                                color: Colors.white)),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                          margin: const EdgeInsets.only(left: 30),
                          child: const Text(
                            "Welcome back, \nget all your recent images! ",
                            softWrap: true,
                            style: TextStyle(color: Colors.white),
                          )),
                    ],
                  ),
                  const SizedBox(
                    height: 74,
                  ),
                  Form(
                      key: controller.formKey,
                      child: Column(
                        children: [
                          Obx(() => Container(
                                child: (controller.isError.value == true)
                                    ? const Text(
                                        "Invalid Credentials",
                                        style: TextStyle(
                                            color: Colors.red, fontSize: 20),
                                      )
                                    : const Text(" "),
                              )),
                          const SizedBox(
                            height: 30,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: Column(
                              children: [
                                Container(
                                    width: 343,
                                    child: TextFormField(
                                      controller: controller.emailController,
                                      validator: (value) =>
                                          controller.emailValidator(value),
                                      decoration: InputDecoration(
                                        focusColor: Colors.white,
                                        prefixIcon: const Icon(
                                          Icons.person,
                                          color: Colors.grey,
                                        ),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            borderSide: BorderSide.none),
                                        fillColor: const Color.fromARGB(
                                            255, 255, 254, 254),
                                        filled: true,
                                        labelText: 'UserName or Email',
                                        //lable style
                                        labelStyle: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 16,
                                          fontFamily: "verdana_regular",
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    )),
                                const SizedBox(
                                  height: 20,
                                ),
                                Obx(
                                  () => Container(
                                      width: 343,
                                      child: TextFormField(
                                        validator: (value) =>
                                            controller.passwordValidator(value),
                                        controller:
                                            controller.passwordController,
                                        obscureText:
                                            controller.ispasswordHidden.value,
                                        decoration: InputDecoration(
                                          suffixIcon: IconButton(
                                            icon: const Icon(Icons.visibility),
                                            onPressed: () {
                                              controller
                                                      .ispasswordHidden.value =
                                                  !(controller
                                                      .ispasswordHidden.value);
                                            },
                                          ),
                                          focusColor: Colors.white,
                                          prefixIcon: const Icon(
                                            Icons.lock,
                                            color: Colors.grey,
                                          ),

                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              borderSide: BorderSide.none),
                                          fillColor: const Color.fromARGB(
                                              255, 255, 254, 254),
                                          filled: true,
                                          labelText: 'Password',
                                          //lable style
                                          labelStyle: const TextStyle(
                                            color: Colors.grey,
                                            fontSize: 16,
                                            fontFamily: "verdana_regular",
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      )),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    TextButton(
                                      onPressed: () {},
                                      child: const Text(
                                        "Forget Password",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 60,
                                ),
                                SizedBox(
                                    width: 343,
                                    height: 50,
                                    child: TextButton(
                                        style: TextButton.styleFrom(
                                          backgroundColor: Colors.white,
                                        ),
                                        onPressed: () async {
                                          if (controller.formKey.currentState!
                                              .validate()) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                    duration:
                                                        Duration(hours: 2),
                                                    backgroundColor:
                                                        Color.fromARGB(
                                                            255, 8, 8, 8),
                                                    content: Text(
                                                        'loggin In .....')));
                                            dynamic login =
                                                await controller.login();
                                            ScaffoldMessenger.of(context)
                                                .removeCurrentSnackBar();
                                            if (login == true) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                      backgroundColor:
                                                          Color.fromARGB(
                                                              255, 8, 8, 8),
                                                      content:
                                                          Text('Success')));
                                              Get.offNamed('/home');
                                            } else {
                                              controller.isError.value = true;
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                      backgroundColor:
                                                          Color.fromARGB(
                                                              255, 8, 8, 8),
                                                      content: Text(
                                                          'Sorry Login Failed')));
                                            }
                                          }
                                        },
                                        child: Text(
                                          "Login",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: mycolor, fontSize: 15),
                                        ))),
                                const SizedBox(
                                  height: 20,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text("Don't have account?",
                                        style: TextStyle(
                                            fontSize: 15, color: Colors.white)),
                                    TextButton(
                                        onPressed: () {
                                          Get.offNamed('/signUp');
                                        },
                                        child: const Text(
                                          "Sign Up",
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.white),
                                        ))
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ))
                ],
              ))
            ])));
  }
}
