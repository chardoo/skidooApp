// ignore_for_file: file_names

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:skiddoapp/models/photos/Photo.dart';
import 'package:skiddoapp/components/common/cartItems.dart';
import 'package:skiddoapp/components/paymentCheckout.dart';
import 'package:skiddoapp/controller/cart_controller.dart';
import 'package:skiddoapp/services/auth_service.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:url_launcher/url_launcher.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreen createState() => _CartScreen();
}

class _CartScreen extends State<CartScreen> {
  CartController cartController = Get.find();
  String publicKey = "pk_test_2176d7c102b87e906c05f3294d86fda5b53c94d6";
  Color mycolor = const Color.fromARGB(255, 15, 19, 26);
    Color whitecolor = Colors.white;
  final plugin = PaystackPlugin();

  @override
  void initState() {
    //initialize the publicKey
    plugin.initialize(publicKey: publicKey);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: mycolor,
          title:  Text(
            "My Cart",
            style: TextStyle(
              color: whitecolor,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          leading: IconButton(
            icon:  Icon(
              Icons.arrow_back,
              color: whitecolor,
            ),
            onPressed: () {
              Get.toNamed('/home');
            },
          ),
        ),
        body: SafeArea(
          child: SizedBox(
            height: screenSize.height,
            width: double.infinity,
            child: cartController.cartItems.length == 0
                ? Container(
                    margin: const EdgeInsets.only(left: 50, right: 40, top: 100),
                    child: const Text("Sorry Nothing added to cart yet ",
                        style: TextStyle(
                            color: Color.fromARGB(255, 221, 217, 217))),
                  )
                : Obx(() => ListView.builder(
                      itemCount: cartController.cartItems.length,
                      itemBuilder: (context, index) {
                        return CartItem(photo: cartController.cartItems[index]);
                      },
                    )),
          ),
        ),
        bottomNavigationBar: Container(
            color: mycolor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  color: const Color.fromARGB(255, 240, 233, 233),
                  onPressed: () {
                    Get.toNamed('/home');
                  },
                  icon: Icon(
                    Icons.home,
                    size: 30,
                    color: whitecolor,
                  ),
                ),
                Obx(() => Text("Total: ${cartController.totalAmount}",
                    style:  TextStyle(
                        color: whitecolor))),
                FloatingActionButton.extended(
                  label:  Text("Pay",
                      style: TextStyle(color: mycolor)),
                  backgroundColor: const Color.fromARGB(255, 247, 245, 245),
                  icon:  Icon(
                    Icons.paypal,
                    color: mycolor,
                  ),
                  onPressed: () async {
                    // List<dynamic> paidItems = [];
                    // plugin.initialize(publicKey: publicKey);
                    if(cartController.totalAmount.value >1){
                    var me = await cartController.payForImages(
                        cartController.totalAmount.value.toString());
                      
                    cartController.referenceId.value = me["reference"];
                    // ignore: use_build_context_synchronously
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => checkoutComponent(
                                url: me["authorization_url"])));
                    }
                  },
                ),
              ],
            )));
  }

  launchPayment(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.inAppWebView);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<dynamic> processPayload(List<Photo> ImageInCart, reference) async {
    List<dynamic> paidItems = [];
    String clientId = await AuthService.getUserId();
    for (Photo item in ImageInCart) {
      paidItems.add(
          {"pictureId": item.id, "userId": item.userId, "clientId": clientId});
    }
    var payload = {
      "referenceId": reference,
      "clientId": clientId,
      "amount": cartController.totalAmount,
      "PaidImage": paidItems
    };
    return payload;
  }

  //async method to charge users card and return a response
  void _showMessage(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  //used to generate a unique reference for payment
  String _getReference() {
    var platform = (Platform.isIOS) ? 'iOS' : 'Android';
    final thisDate = DateTime.now().millisecondsSinceEpoch;
    return 'ChargedFrom${platform}_$thisDate';
  }

  //async method to charge users card and return a response
  chargeCard(context, amount) async {
    String email = await AuthService.getEmail();
    var charge = Charge()
      ..amount = amount *
          100 //the money should be in kobo hence the need to multiply the value by 100
      ..accessCode = "nfdfndfndifidfgidigdg"
      ..putCustomField('custom_id',
          '846gey6w') //to pass extra parameters to be retrieved on the response from Paystack
      ..email = email;

    CheckoutResponse response = await plugin.checkout(
      context,
      method: CheckoutMethod.selectable,
      charge: charge,
    );

    //check if the response is true or not
    if (response.status == true) {
      //you can send some data from the response to an API or use webhook to record the payment on a database
      _showMessage('Payment was successful!!!');
      return response;
    } else {
      //the payment wasn't successsful or the user cancelled the payment
      _showMessage('Payment Failed!!!');
      return response;
    }
  }
}
