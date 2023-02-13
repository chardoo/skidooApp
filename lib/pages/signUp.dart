import 'dart:io';
//import 'package:face_camera/face_camera.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:skiddoapp/components/Screens/captureFace.dart';
import 'package:skiddoapp/controller/signUp_controller.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:skiddoapp/pages/login.dart';
// import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
// import 'package:camera/camera.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({
    super.key,
    required this.camera,
  });

  final CameraDescription camera;
  @override
  _SignUpScreen createState() => _SignUpScreen();
}

class _SignUpScreen extends State<SignUpScreen>
    with SingleTickerProviderStateMixin {
  final SignUpController controller = Get.put(SignUpController());
  static const colorizeTextStyle =
      TextStyle(fontSize: 25.0, fontFamily: 'SF', color: Colors.redAccent);
  String imagepath = "";
  late List<File> facefiles = [];
  late File faces;
  Color mycolor = const Color.fromARGB(255, 15, 19, 26);
  Color whiteColor = Colors.white;
  // String _image =
  //     'https://ouch-cdn2.icons8.com/84zU-uvFboh65geJMR5XIHCaNkx-BZ2TahEpE9TpVJM/rs:fit:784:784/czM6Ly9pY29uczgu/b3VjaC1wcm9kLmFz/c2V0cy9wbmcvODU5/L2E1MDk1MmUyLTg1/ZTMtNGU3OC1hYzlh/LWU2NDVmMWRiMjY0/OS5wbmc.png';
  late AnimationController loadingController;
  //late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    loadingController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..addListener(() {
        setState(() {});
      });

    // _controller = CameraController(
    //   widget.camera,
    //   ResolutionPreset.medium,
    // );
    // _initializeControllerFuture = _controller.initialize();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 5,
          centerTitle: true,
          title:  Text(
            "Skiddo",
            style: TextStyle(
                color: whiteColor, fontSize: 26, fontWeight: FontWeight.w700),
          ),
          backgroundColor: mycolor,
        ),
        backgroundColor: Colors.black,
        body: body(context));
  }

  Widget body(context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: mycolor,
            body: (ListView(
              children: [
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
                          child:  Text("Let's get Started",
                              style: TextStyle(
                                color: whiteColor,
                                  fontWeight: FontWeight.w600, fontSize: 22)),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                            margin: const EdgeInsets.only(left: 30),
                            child:  Text(
                              "Create an account and get best \nfeatures ",
                              softWrap: true,
                              style: TextStyle(color: whiteColor),
                            )),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Obx(() => controller.Imagepath.value.isNotEmpty
                        ? CircleAvatar(
                            radius: 69,
                            child: ClipOval(
                              child: SizedBox(
                                height: 150,
                                width: 150,
                                child: Image.file(
                                  File(controller.Imagepath.value),
                                  fit: BoxFit.cover,
                                  height: 150,
                                  width: 150,
                                ),
                              ),
                            ))
                        : Container()),
                    Container(
                        margin: const EdgeInsets.only(left: 30, right: 30),
                        child: Form(
                          key: controller.formKey,
                          child: Column(
                            children: [
                              Obx(() => Container(
                                    child: (controller.isError.value == true)
                                        ? const Text(
                                            "Register Again,Something went Wrong",
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 20),
                                          )
                                        : const Text(" "),
                                  )),
                              const SizedBox(
                                height: 30,
                              ),
                              Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 0),
                                  child: Column(
                                    children: [
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                          height: 70,
                                          width: 343,
                                          child: TextFormField(
                                            controller:
                                                controller.emailController,
                                            validator: (value) => controller
                                                .emailValidator(value),
                                            decoration: InputDecoration(
                                              helperText: ' ',
                                              focusColor: Colors.white,
                                              prefixIcon: const Icon(
                                                Icons.person,
                                                color: Colors.grey,
                                              ),
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide.none,
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                              fillColor: const Color.fromARGB(
                                                  255, 255, 254, 254),
                                              filled: true,
                                              labelText: ' Email',
                                              //lable style
                                              labelStyle: const TextStyle(
                                                color: Colors.grey,
                                                fontSize: 16,
                                                fontFamily: "verdana_regular",
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          )),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                          height: 70,
                                          width: 343,
                                          child: TextFormField(
                                            controller:
                                                controller.userNameController,
                                            validator: (value) => controller
                                                .userNameValidator(value),
                                            decoration: InputDecoration(
                                              helperText: ' ',
                                              focusColor: Colors.white,
                                              prefixIcon: const Icon(
                                                Icons.person,
                                                color: Colors.grey,
                                              ),
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide.none,
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                              fillColor: const Color.fromARGB(
                                                  255, 255, 254, 254),
                                              filled: true,
                                              labelText: 'UserName',
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
                                        height: 5,
                                      ),
                                      Obx(
                                        () => Container(
                                            height: 70,
                                            width: 343,
                                            child: TextFormField(
                                              controller:
                                                  controller.passwordController,
                                              validator: (value) => controller
                                                  .passwordValidator(value),
                                              obscureText: controller
                                                  .ispasswordHidden.value,
                                              decoration: InputDecoration(
                                                helperText: ' ',
                                                suffixIcon: IconButton(
                                                  icon: const Icon(
                                                      Icons.visibility),
                                                  onPressed: () {
                                                    print("hello");

                                                    controller.ispasswordHidden
                                                            .value =
                                                        !(controller
                                                            .ispasswordHidden
                                                            .value);
                                                    print("hote");
                                                    print(controller
                                                        .ispasswordHidden);
                                                  },
                                                ),
                                                focusColor: Colors.white,
                                                prefixIcon: const Icon(
                                                  Icons.lock,
                                                  color: Colors.grey,
                                                ),
                                                border: OutlineInputBorder(
                                                  borderSide: BorderSide.none,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
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
                                        height: 5,
                                      ),
                                      Obx(
                                        () => Container(
                                          height: 70,
                                          width: 343,
                                          child: TextFormField(
                                            obscureText: controller
                                                .ispasswordHidden.value,
                                            decoration: InputDecoration(
                                                helperText: ' ',
                                                suffixIcon: IconButton(
                                                  icon: const Icon(
                                                      Icons.visibility),
                                                  onPressed: () {
                                                    controller.ispasswordHidden
                                                            .value =
                                                        !(controller
                                                            .ispasswordHidden
                                                            .value);
                                                  },
                                                ),
                                                focusColor: Colors.white,
                                                prefixIcon: const Icon(
                                                  Icons.lock,
                                                  color: Colors.grey,
                                                ),
                                                border: OutlineInputBorder(
                                                  borderSide: BorderSide.none,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                                fillColor: const Color.fromARGB(
                                                    255, 255, 254, 254),
                                                filled: true,
                                                labelText: 'Confirm Password',
                                                //lable style
                                                labelStyle: const TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 16,
                                                  fontFamily: "verdana_regular",
                                                  fontWeight: FontWeight.w400,
                                                )),
                                          ),
                                        ),
                                      ),
                                      MaterialButton(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 0),
                                        onPressed: () async {
                                          //controller.selectFile();
                                          final cameras =
                                              await availableCameras();
                                          final firstCamera = cameras.last;
                                          await Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  TakePictureScreen(
                                                camera: firstCamera,
                                              ),
                                            ),
                                          );
                                        },
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children:  [
                                                Icon(Icons.camera, color: whiteColor,),
                                                Text("Register your face here", style: TextStyle(color: whiteColor),)
                                              ],
                                            ),
                                            Obx(
                                              () => controller
                                                          .Imagepath.isEmpty &&
                                                      controller
                                                              .isRegisterClicked
                                                              .value ==
                                                          true
                                                  ? const Text(
                                                      'Face not captured',
                                                      style: TextStyle(
                                                          color: Colors.red),
                                                    )
                                                  : const Text(" "),
                                            )
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  )),
                              const SizedBox(
                                height: 5,
                              ),
                              SizedBox(
                                  width: 343,
                                  height: 50,
                                  child: TextButton(
                                      style: TextButton.styleFrom(
                                      
                                        backgroundColor:whiteColor,
                                      ),
                                      onPressed: () async {
                                        controller.isRegisterClicked.value =
                                            true;
                                        File file =
                                            File(controller.Imagepath.value);
                                        controller.imageName.value =
                                            file.path.split('/').last;
                                        if (controller.formKey.currentState!
                                            .validate()) {
                                          // print("faces selected");
                                          // print(facefiles);
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                            backgroundColor:
                                                Color.fromARGB(255, 8, 8, 8),
                                            content:
                                                Text('Sign up please wait....'),
                                            duration: Duration(hours: 1),
                                          ));
                                          dynamic login =
                                              await controller.register(file);
                                          Get.closeAllSnackbars();
                                          if (login == true) {
                                            controller.isRegisterClicked.value =
                                                false;
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                    backgroundColor:
                                                        Color.fromARGB(
                                                            255, 8, 8, 8),
                                                    content: Text('Success')));
                                            Get.offNamed('/login');
                                          } else {
                                            controller.isRegisterClicked.value =
                                                false;
                                            controller.isError.value = true;
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                    backgroundColor:
                                                        Color.fromARGB(
                                                            255, 8, 8, 8),
                                                    content: Text(
                                                        'Sorry sign up unsuccessful')));
                                          }
                                        }
                                      },
                                      child:  Text(
                                        "Sign Up",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: mycolor),
                                      ))),
                              const SizedBox(
                                height: 20,
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                   Text("Don't have account Google?",
                                      style: TextStyle(fontSize: 15, color: whiteColor)),
                                  TextButton(
                                      onPressed: () {
                                       // Get.to(LoginScreen());
                                         Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                              builder: (BuildContext context) {
                                        return LoginScreen();
                                      }));
                                      },
                                      child:  Text(
                                        "Sign Up",
                                        style: TextStyle(
                                            fontSize: 15, color: whiteColor),
                                      ))
                                ],
                              )
                            ],
                          ),
                        ))
                  ],
                ))
              ],
            ))));
  }
}
