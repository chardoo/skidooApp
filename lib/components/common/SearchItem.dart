import 'dart:async';

import 'package:skiddoapp/models/event/Event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skiddoapp/controller/cart_controller.dart';
import 'package:skiddoapp/controller/home_controller.dart';
import 'package:intl/intl.dart';

class SearchTale extends StatelessWidget {
  // ignore: empty_constructor_bodies
  HomeController controller = Get.find();
  Event event = new Event('', '', '');

  @override
  SearchTale({Key? key, required this.event}) : super(key: key);
  Widget build(BuildContext context) {
    return Container(
      
        margin: const EdgeInsets.only(bottom: 5, right: 0, left: 0),
        height: 55,
        decoration: const BoxDecoration(
          
            color: Color.fromARGB(255, 227, 225, 225),
            // borderRadius: BorderRadius.all(Radius.circular(10))
            ),
        child: ListTile(
          leading: Text(event.photographer,
              style: const TextStyle(
                  color: Color.fromARGB(255, 33, 32, 32),
                  fontWeight: FontWeight.w900,
                  fontStyle: FontStyle.normal,
                  fontFamily: 'Open Sans',
                  fontSize: 15)),
          title: Text(
            event.eventName,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                color: Color.fromARGB(255, 33, 32, 32),
                fontWeight: FontWeight.w900,
                fontStyle: FontStyle.normal,
                fontFamily: 'Open Sans',
                fontSize: 15),
          ),
          subtitle: Text(
            DateFormat.yMMMd()
                .format(DateTime.parse(event.eventDate))
                .toString(),
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                color: Color.fromARGB(255, 27, 26, 26),
                ),
          ),
          onTap: () async {
            Get.toNamed('/searchresults');
            await controller.searchimages(event.eventName);
            Timer(const Duration(seconds: 10), () async {
              if (controller.searchImage.isEmpty) {
                await controller.searchimages(event.eventName);
              } else {}
            });
            Timer(const Duration(seconds: 20), () async {
              if (controller.searchImage.isEmpty) {
                await controller.searchimages(event.eventName);
              } else {}
            });
          },
        ));
  }
}
