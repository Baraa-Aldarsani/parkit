import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parking/controller/services/services_controller.dart';
import '../controller/services&subscripe_controller.dart';
import '../controller/subscription/subscription_controller.dart';
import '../helper/constant.dart';
import 'services/services_details_user.dart';

class ServicesAndSubscripeView extends StatelessWidget {
  ServicesAndSubscripeView({Key? key}) : super(key: key);
  final controllerSub = Get.put(SubscriptionController());
  final _controller = Get.put(ServicesAndSubscripeController());
  final ServicesController _controllerServices = Get.put(ServicesController());
  String nameGarage = '';
  String openGarage = '';
  String closeGarage = '';
  String startDate = '';
  String endDate = '';
  String typeSubscription = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Parkit",
          style: TextStyle(
            fontFamily: 'Billabong',
            color: deepdarkblue,
            fontSize: 50,
            fontWeight: FontWeight.w500,
            height: 2,
          ),
        ),
        elevation: 1.5,
        backgroundColor: lightgreen,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.menu,
            color: deepdarkblue,
            size: 45
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.notifications_active,
                color: deepdarkblue,
                size: 45,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
          child: Column(
            children: [
              SizedBox(
                height: 60,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: 2,
                    itemBuilder: (BuildContext context, int index) {
                      return Obx(
                        () => InkWell(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(30)
                          ),
                          splashColor: darkblue,
                          onTap: () {
                            _controller.changeColor(index);
                          },
                          child: Container(
                            width: 197,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(width: 1.6, color: deepdarkblue),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(23),
                              ),
                              color: _controller.getColorButtons(index),
                            ),
                            child: Text(
                              _controller.text[index],
                              style: TextStyle(
                                color: _controller.getColorText(index),
                                fontWeight: FontWeight.bold,
                                fontSize: 17,fontFamily: 'Playfair Display1',
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const SizedBox(width: 5),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              GetBuilder<ServicesAndSubscripeController>(
                  init: ServicesAndSubscripeController(),
                  builder: (controller) => controller.selectIndex == 0
                      ? FutureBuilder(
                          future: _controllerServices.getServicesForUser(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: Padding(
                                padding: EdgeInsets.only(top: 280.0),
                                child: CircularProgressIndicator(),
                              ));
                            } else if (snapshot.hasError) {
                              return const Text("");
                            } else {
                              if (_controllerServices.services.isNotEmpty) {
                                return Obx(
                                  () => Expanded(
                                    child: ListView.builder(
                                      itemCount:
                                          _controllerServices.services.length,
                                      itemBuilder: (context, index) {
                                        final service = _controllerServices
                                            .services[index].serviceModel;
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 6, vertical: 8),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(20),
                                            child: Container(
                                                height: 145,
                                                color: Colors.grey.shade50,
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      height: 150,
                                                      width: 150,
                                                      padding:
                                                          const EdgeInsets.all(
                                                              15),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                20),
                                                        child: CachedNetworkImage(
                                                          imageUrl: service.image,
                                                          placeholder: (context, url) => const CircularProgressIndicator(),
                                                          errorWidget: (context, url, error) => const Icon(Icons.error),
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .only(
                                                          top: 15,
                                                          left: 15,right:15 ),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            service.name,
                                                            style: TextStyle(
                                                                fontSize: 28,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color:
                                                                    deepdarkblue),
                                                          ),
                                                          const SizedBox(
                                                              height: 10),
                                                          Text(
                                                            "Garage : ${service.garageModel!.name}",
                                                            style:
                                                                const TextStyle(
                                                                    fontSize: 20,
                                                                    color: Colors
                                                                        .grey),
                                                          ),
                                                          Expanded(
                                                            child: Row(
                                                              children: [
                                                                Text(
                                                                  '\$${service.price.toStringAsFixed(2)}',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          16,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color:
                                                                          darkblue),
                                                                ),
                                                                const SizedBox(
                                                                  width: 20
                                                                ),
                                                                InkWell(
                                                                  onTap: () {
                                                                    Get.to(ServiceDetailsPage(
                                                                        service:
                                                                            service));
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    width: 110,
                                                                    height: 30,
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      border: Border.all(
                                                                          width:
                                                                              1.4,
                                                                          color:
                                                                              deepdarkblue),
                                                                      borderRadius:
                                                                          const BorderRadius
                                                                              .all(
                                                                        Radius.circular(
                                                                            10),
                                                                      ),
                                                                    ),
                                                                    child: Text(
                                                                      "View Details",
                                                                      style: TextStyle(
                                                                          color:
                                                                              deepdarkblue),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                )),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                );
                              } else {
                                return Padding(
                                  padding: const EdgeInsets.only(top: 60.0),
                                  child: Column(
                                    children: [
                                      Image.asset("assets/images/services.png",
                                          height: 370),
                                      const Text(
                                        "You have no services",
                                        style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(height: 15),
                                      const Text(
                                        "You can browse and explore the application and take advantage of the services provided by the garage",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.grey,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                );
                              }
                            }
                          })
                      : FutureBuilder(
                          future: controllerSub.fetchData(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: Padding(
                                padding: EdgeInsets.only(top: 280.0),
                                child: CircularProgressIndicator(),
                              ));
                            } else if (snapshot.hasError) {
                              return const Text("");
                            } else {
                              final List<dynamic> subscriptions =
                                  controllerSub.data['subscriptions'];
                              final List<dynamic> garage =
                                  controllerSub.data['garage'];
                              if (subscriptions.isNotEmpty) {
                                return Flexible(
                                  child: ListView.builder(
                                    itemCount: subscriptions.length,
                                    itemBuilder: (context, index) {
                                      final subscription = subscriptions[index];
                                      final garageSubscription = garage[index];
                                      nameGarage = garageSubscription[
                                              'garage_subscriptions']['garages']
                                          ['name'];
                                      typeSubscription = garageSubscription[
                                              'garage_subscriptions']
                                          ['subscription']['type'];
                                      startDate =
                                          subscription['start_date_sub'];
                                      endDate = subscription['end_date_sub'];
                                      openGarage = garageSubscription[
                                              'garage_subscriptions']['garages']
                                          ['time_open'];
                                      closeGarage = garageSubscription[
                                              'garage_subscriptions']['garages']
                                          ['time_close'];
                                      return Card(
                                        elevation: 3,
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 5),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(15),
                                          child: ListTile(
                                            title: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text('Garage : $nameGarage',style: TextStyle(fontSize: 25,color: deepdarkblue),),
                                                Container(
                                                    width:
                                                    90,
                                                    height:
                                                    30,
                                                    alignment:
                                                    Alignment.center,
                                                    decoration:
                                                    BoxDecoration(
                                                      border: Border.all(
                                                          width: 1.4,
                                                          color:typeSubscription == 'monthly' ? red : lightblue),
                                                      borderRadius:
                                                      const BorderRadius.all(
                                                        Radius.circular(8),
                                                      ),
                                                    ),
                                                    child:
                                                    Text(
                                                        typeSubscription,
                                                        style:
                                                        TextStyle(color:typeSubscription == 'monthly' ? red : lightblue)
                                                    )
                                                ),

                                              ],
                                            ),
                                            subtitle: Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 10),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                          'Start Date : $startDate'),
                                                      Text('End Date : $endDate'),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 5),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                          'Open Garage : $openGarage'),
                                                      Text(
                                                          'Close Garage : $closeGarage'),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            onTap: () {},
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              } else {
                                return Padding(
                                  padding: const EdgeInsets.only(top: 60.0),
                                  child: Column(
                                    children: [
                                      Image.asset(
                                        "assets/images/subscripe.png",
                                        height: 370,
                                      ),
                                      const Text(
                                        "You have no subscriptions",
                                        style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(height: 15),
                                      const Text(
                                        "You can browse and explore the app and take advantage of the features available to you as a non-subscribed user",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.grey),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                );
                              }
                            }
                          }))
            ],
          )),
    );
  }
}