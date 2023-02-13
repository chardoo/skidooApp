import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skiddoapp/controller/cart_controller.dart';
// import 'package:photoapp_mobile/contollers/cart_controller.dart';
import 'package:webview_flutter/webview_flutter.dart';

class checkoutComponent extends StatefulWidget {
  String url = "";
  checkoutComponent({super.key, required this.url});
  @override
  State<checkoutComponent> createState() => _checkoutComponent();
}

class _checkoutComponent extends State<checkoutComponent> {
  CartController cartController = Get.find();
  late WebViewController controller;
  @override
  initState() {
    super.initState();

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {
            print("fjjdfjfjdfjfjjdf");
          },
          
          onWebResourceError: (WebResourceError error) {
             print("we resource");
          },
          onNavigationRequest: (NavigationRequest request) async {
           
            print(request.url);
            if (request.url.contains('https://example.com/richCode/')) {
            
             await  cartController.completePayment("");

              print("hehehehehehe");
              return NavigationDecision.prevent;
            }
            await  cartController.completePayment("");
            print("nothing found man");
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}
