import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skiddoapp/components/Screens/croptimage.dart';
import 'package:skiddoapp/controller/signUp_controller.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_cropper/image_cropper.dart';

class TakePictureScreen extends StatefulWidget {
  const TakePictureScreen({
    super.key,
    required this.camera,
  });

  final CameraDescription camera;

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  SignUpController controller = Get.find();
  @override
  void initState() {
    super.initState();
    // To display the current output from the Camera,
    // create a CameraController.
    _controller = CameraController(
        // Get a specific camera from the list of available cameras.
        widget.camera,
        // Define the resolution to use.
        ResolutionPreset.medium,
        imageFormatGroup: ImageFormatGroup.jpeg);

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.black, title: const Text('Take a selfie')),
      // You must wait until the controller is initialized before displaying the
      // camera preview. Use a FutureBuilder to display a loading spinner until the
      // controller has finished initializing.
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the Future is complete, display the preview.
            return CameraPreview(_controller);
          } else {
            // Otherwise, display a loading indicator.
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        // Provide an onPressed callback.
        onPressed: () async {
          // Take the Picture in a try / catch block. If anything goes wrong,
          // catch the error.
          try {
            // Ensure that the camera is initialized.
            await _initializeControllerFuture;

            // Attempt to take a picture and get the file `image`
            // where it was saved.

            final image = await _controller.takePicture();
            File file = new File(image.path);
            final inputImage = InputImage.fromFilePath(image.path);
            final faceDetector = GoogleMlKit.vision.faceDetector();
            final List<Face> faces =
                await faceDetector.processImage(inputImage);

            if (faces.isNotEmpty) {
              await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => CropImages(file: file.readAsBytesSync()),
              ));
            } else {
              showDialog(
                  context: context,
                  builder: (context) {
                    return const AlertDialog(
                      title: Center(
                          child: Text(
                        'Sorry No face Detected',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )),
                    );
                  });
              Future.delayed(
                Duration(seconds: 2),
                () {
                  Navigator.pop(context, true);
                },
              );
            }

            //   final inputImage = InputImage.fromFilePath(image.path);

            //   final faceDetector = GoogleMlKit.vision.faceDetector();

            //   final List<Face> faces =
            //       await faceDetector.processImage(inputImage);
            //   // print("hello the sjdjds");
            //   // print(faces);

            //   if (faces.isNotEmpty) {

            //     faces[0].boundingBox;
            //     controller.Imagepath.value = image.path;
            //     showDialog(
            //         context: context,
            //         builder: (context) {
            //           return const AlertDialog(
            //             title: Center(
            //                 child: Text(
            //               'Face Captured',
            //               style: TextStyle(
            //                   fontSize: 20, fontWeight: FontWeight.bold),
            //             )),
            //           );
            //         });
            //     print("navigater");

            //     Future.delayed(
            //       Duration(seconds: 2),
            //       () {
            //         Navigator.pop(context, true);
            //         Navigator.pop(context, true);
            //       },
            //     );
            //   } else {
            //     showDialog(
            //         context: context,
            //         builder: (context) {
            //           return const AlertDialog(
            //             title: Center(
            //                 child: Text(
            //               'Sorry No face Detected',
            //               style: TextStyle(
            //                   fontSize: 20, fontWeight: FontWeight.bold),
            //             )),
            //           );
            //         });
            //     Future.delayed(
            //       Duration(seconds: 2),
            //       () {
            //         Navigator.pop(context, true);
            //       },
            //     );
            //   }
            //   if (!mounted) return;

            //   // If the picture was taken, display it on a new screen.

          } catch (e) {
            // If an error occurs, log the error to the console.
            print(e);
          }
        },
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}
