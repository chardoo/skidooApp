import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:crop_your_image/crop_your_image.dart';
import 'package:path_provider/path_provider.dart';
import 'package:skiddoapp/controller/signUp_controller.dart';
// import 'package:get/get_core/src/get_main.dart';

import 'package:skiddoapp/controller/userProfile_controller.dart';

class CropImages extends StatelessWidget {
  Uint8List file;
  CropImages({required this.file});

  SignUpController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    final cropController = CropController();

    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.black, title: const Text('Take a selfie')),
        // You must wait until the controller is initialized before displaying the
        // camera preview. Use a FutureBuilder to display a loading spinner until the
        // controller has finished initializing.
        body: Crop(
            image: file,
            controller: cropController,
            onCropped: (image) async {
                Directory appDocumentsDirectory = await getApplicationDocumentsDirectory(); // 1
                String appDocumentsPath = appDocumentsDirectory.path; // 2
                String filePath = '$appDocumentsPath/imagefedff.png'; 

              // File file = File.fromRawPath(image);
              print("path found man");
            var file = await File(filePath).writeAsBytes(image);
            print("hello how are you doing the gogod");
              print(file.path);
              controller.Imagepath.value = file.path;
              // do something with image data
            }),
        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.black,
            // Provide an onPressed callback.
            onPressed: () async {
              cropController.crop();
              Navigator.pop(context, true);
              Navigator.pop(context, true);
            }));

    //  Stack(children: [
    //   Crop(
    //       image: file,
    //       controller: cropController,
    //       onCropped: (image) async {
    //         File file = File.fromRawPath(image);
    //         controller.Imagepath.value = file.path;
    //         // do something with image data
    //       }),
    //   MaterialButton(
    //     child: Text("crop"),
    //     onPressed: () {
    //       cropController.crop();
    //       Navigator.pop(context, true);
    //       Navigator.pop(context, true);
    //     },
    //   )
    // ]);
  }
}
