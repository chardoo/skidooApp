import 'package:crop_your_image/crop_your_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skiddoapp/models/event/Event.dart';
import 'package:skiddoapp/components/common/SearchItem.dart';
import 'package:skiddoapp/components/common/photographersChat.dart';
import 'package:skiddoapp/controller/home_controller.dart';
import 'package:easy_autocomplete/easy_autocomplete.dart';
import 'package:find_dropdown/find_dropdown.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/services.dart';
import 'package:skiddoapp/pages/cartScreen.dart';
import 'package:skiddoapp/pages/photographers.dart';

class HomeNavigationScreen extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: const Icon(
                Icons.shopping_bag,
                size: 20,
                color: Color.fromARGB(255, 200, 199, 199),
              ),
              onPressed: () {
                Get.to(CartScreen(), transition: Transition.fadeIn);
              },
            )
          ],
          automaticallyImplyLeading: false,
          elevation: 3,
          bottom: const PreferredSize(
            preferredSize: Size(double.infinity, 5),
            child: Divider(color: Color.fromARGB(255, 237, 233, 233)),
          ),
          leading: Obx(() => Container(
                margin: const EdgeInsets.only(top: 10),
                child: controller.issearching.value == true
                    ? BackButton(
                        onPressed: () async {
                          await SystemChannels.textInput
                              .invokeMethod('TextInput.hide');
                          controller.issearching.value = false;
                        },
                      )
                    : const CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.white,
                      ),
              )),
          title: Container(
              margin: const EdgeInsets.only(top: 10),
              height: 30,
              // width: 343,
              child: TextFormField(
                // onTap: () => ,

                onTap: () async {
                  controller.issearching.value = true;
                },
                decoration: InputDecoration(
                  focusColor: const Color.fromARGB(255, 88, 88, 88),
                  suffixIcon: Obx(() => controller.issearching.value == true
                      ? IconButton(
                          icon: const Icon(Icons.close),
                          color: const Color.fromARGB(255, 247, 245, 245),
                          onPressed: () async {
                            await SystemChannels.textInput
                                .invokeMethod('TextInput.hide');
                            controller.issearching.value = false;
                          },
                        )
                      : const Text('')),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  fillColor: const Color.fromARGB(255, 74, 73, 73),
                  filled: true,
                  labelText: 'Search',
                  //lable style
                  labelStyle: const TextStyle(
                    color: Color.fromARGB(255, 200, 198, 198),
                    fontSize: 12,
                    fontFamily: "verdana_regular",
                    fontWeight: FontWeight.w400,
                  ),
                ),
                onChanged: (value) {
                  controller.searchEvents(value);
                },
              )),
          backgroundColor: Color.fromARGB(255, 10, 13, 17),
        ),
        body: body());
  }

  Widget body() {
    return SafeArea(
        child: Obx(() => Scaffold(
            // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.white,
              onPressed: () async {
                // controller.index.value = 0;
                Get.to(ChatPage(), transition: Transition.fadeIn);
              },
              child: Container(
                // color: Colors.white,
                child: Icon(
                  Icons.emoji_people,
                  color: Colors.black,
                ),
              ),
            ),
            backgroundColor: const Color.fromARGB(255, 10, 10, 10),
            body: controller.issearching.value == true
                ? Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: controller.eventSearched.isEmpty
                        ? const Center(
                            child: Text(
                              "no event found please",
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        : controller.searchEvent.value == true
                            ? Container(
                                alignment: Alignment.topCenter,
                                margin: const EdgeInsets.only(top: 20),
                                child: const CircularProgressIndicator(
                                  backgroundColor: Colors.grey,
                                  color: Colors.purple,
                                  strokeWidth: 10,
                                ))
                            : ListView.builder(
                                scrollDirection: Axis.vertical,
                                itemCount: controller.eventSearched.length,
                                itemBuilder: (BuildContext ctxt, int index) {
                                  return ListTile(
                                      selected: false,
                                      title: SearchTale(
                                          event:
                                              controller.eventSearched[index]));
                                }))
                : Column(children: [
                    SizedBox(
                      height: 500,
                      child: ListView(
                        children: [
                          CarouselSlider(
                            items: [
                              Container(
                                margin: const EdgeInsets.all(6.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8.0),
                                  image: const DecorationImage(
                                    image: NetworkImage(
                                        "https://res.cloudinary.com/dpakfvvhu/image/upload/v1641466489/sample.jpg"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),

                              //3rd Image of Slider
                              Container(
                                margin: const EdgeInsets.all(6.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8.0),
                                  image: const DecorationImage(
                                    image: NetworkImage(
                                        "https://res.cloudinary.com/dpakfvvhu/image/upload/v1641466489/sample.jpg"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),

                              //4th Image of Slider
                              Container(
                                margin: const EdgeInsets.all(6.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  image: const DecorationImage(
                                    image: NetworkImage(
                                        "https://res.cloudinary.com/dpakfvvhu/image/upload/v1641466489/sample.jpg"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),

                              //5th Image of Slider
                              Container(
                                margin: const EdgeInsets.all(6.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8.0),
                                  image: const DecorationImage(
                                    image: NetworkImage(
                                        "https://res.cloudinary.com/dpakfvvhu/image/upload/v1641466489/sample.jpg"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ],

                            //Slider Container properties
                            options: CarouselOptions(
                              height: 180.0,
                              enlargeCenterPage: true,
                              autoPlay: true,
                              aspectRatio: 16 / 9,
                              autoPlayCurve: Curves.fastOutSlowIn,
                              enableInfiniteScroll: true,
                              autoPlayAnimationDuration:
                                  const Duration(milliseconds: 800),
                              viewportFraction: 0.8,
                            ),
                          ),
                        ],
                      ),
                    )
                  ]))));
  }
}
