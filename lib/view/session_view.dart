import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parking/controller/reservation_controller/reservation_controller.dart';
import 'package:parking/helper/constant.dart';
import 'package:parking/model/archive_model.dart';
import 'package:parking/view/parking_timer.dart';

import '../controller/bottomSheet_controller.dart';
import '../controller/sessions_controller.dart';
import 'parking_ticket_view.dart';

class SessionsView extends StatelessWidget {
  SessionsView({Key? key}) : super(key: key);
  final _controller = Get.put(SessionsController());
  final ReservationController _resController = Get.put(ReservationController());
  final bottomSheet = Get.put(BottomSheetController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              size: 45,
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
                            Radius.circular(30),
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
                                fontSize: 18,
                                fontFamily: 'Playfair Display1'
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
              GetBuilder<SessionsController>(
                  init: SessionsController(),
                  builder: (controller) => controller.selectIndex == 0
                      ? FutureBuilder(
                          future: _resController.getNowReservation(),
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
                              if (_resController.reservationNow.value.model1.isNotEmpty) {
                                return Expanded(
                                  child: ListView.builder(
                                    itemCount: _resController.reservationNow.value.model1.length,
                                    itemBuilder: (context, index) {
                                      ArchiveModel1 model1 =
                                          _resController.reservationNow.value.model1[index];
                                      ArchiveModel2 model2 =
                                          _resController.reservationNow.value.model2[index];
                                      double hoursDouble = double.parse(
                                          model1.time_end.split(':')[0]) - double.parse(
                                          model1.time_begin.split(':')[0]);
                                      double minutebegin = double.parse(
                                          model1.time_begin.split(':')[1]);
                                      double minuteend = double.parse(
                                          model1.time_end.split(':')[1]);
                                      if (minutebegin < minuteend) {
                                        hoursDouble++;
                                      }
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 6, vertical: 8),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: Container(
                                            color: Colors.white,
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                    height: 135,
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          height: 150,
                                                          width: 150,
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(15),
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20),
                                                            child: Image.asset(
                                                              "assets/images/parking.jpg",
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 15,
                                                                  left: 6),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                model2
                                                                    .parking
                                                                    .floor!
                                                                    .locationModel!
                                                                    .name,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        28,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color:
                                                                        deepdarkblue),
                                                              ),
                                                              const SizedBox(
                                                                  height: 8),
                                                              Text(
                                                                "${model2.parking.floor!.number} Floor, ${model2.parking.number} parking",
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        20,
                                                                    color: Colors
                                                                        .grey),
                                                              ),
                                                              Expanded(
                                                                child: Row(
                                                                  children: [
                                                                    Text(
                                                                      '\$${model1.pay} / ${hoursDouble.toInt()} hour',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              16,
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          color:
                                                                              darkblue),
                                                                    ),
                                                                    const SizedBox(
                                                                        width:
                                                                            20),
                                                                    InkWell(
                                                                      onTap:
                                                                          () {
                                                                        bottomSheet.deleteReservation(model1.id);
                                                                      },
                                                                      child:
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
                                                                              color: red),
                                                                          borderRadius:
                                                                              const BorderRadius.all(
                                                                            Radius.circular(8),
                                                                          ),
                                                                        ),
                                                                        child:
                                                                            Text(
                                                                          "Cancelled",
                                                                          style:
                                                                              TextStyle(color: red)
                                                                        )
                                                                      )
                                                                    )
                                                                  ]
                                                                )
                                                              )
                                                            ]
                                                          )
                                                        )
                                                      ]
                                                    )),
                                                const Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 30),
                                                  child:
                                                      Divider(thickness: 1.2),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15,
                                                          right: 15,
                                                          top: 4,
                                                          bottom: 6),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: InkWell(
                                                          onTap: () {
                                                            Get.to(ParkingTimer(model1: model1, model2: model2, hours: hoursDouble));
                                                          },
                                                          splashColor: darkblue,
                                                          child: Container(
                                                            height: 40,
                                                            alignment: Alignment
                                                                .center,
                                                            decoration:
                                                                BoxDecoration(
                                                              border: Border.all(
                                                                  width: 2,
                                                                  color:
                                                                      deepdarkblue),
                                                              borderRadius:
                                                                  const BorderRadius
                                                                      .all(
                                                                Radius.circular(
                                                                    18),
                                                              ),
                                                            ),
                                                            child: Text(
                                                              "View Timer",
                                                              style: TextStyle(
                                                                  color:
                                                                      deepdarkblue,
                                                                  fontSize: 16),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 15,
                                                      ),
                                                      Expanded(
                                                        child: InkWell(
                                                          onTap: () {
                                                            Get.to(ParkingTicketView(model1: model1,model2: model2,duration: hoursDouble.toInt(),year: 0,mounth: '',day: 0, time: const [], parkingSpot: const [],));
                                                          },
                                                          child: Container(
                                                            height: 40,
                                                            alignment: Alignment
                                                                .center,
                                                            decoration:
                                                                BoxDecoration(
                                                              color:
                                                                  deepdarkblue,
                                                              border: Border.all(
                                                                  width: 2,
                                                                  color:
                                                                      deepdarkblue),
                                                              borderRadius:
                                                                  const BorderRadius
                                                                      .all(
                                                                Radius.circular(
                                                                    18),
                                                              ),
                                                            ),
                                                            child: const Text(
                                                              "View Ticket",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 16),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              } else {
                                return Padding(
                                  padding: const EdgeInsets.only(top: 30),
                                  child: Column(
                                    children: [
                                      Image.asset(
                                        "assets/images/noActiveSessions.png",
                                      ),
                                      const Text(
                                        "No active sessions",
                                        style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(height: 15),
                                      const Text(
                                        "There are no active sessions registered on your account",
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
                          })
                      : FutureBuilder(
                          future: _resController.fetchData(),
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
                              List<ArchiveModel1> model1 =
                                  _resController.reservationData.value.model1;
                              List<ArchiveModel2> model2 =
                                  _resController.reservationData.value.model2;
                              if (model1.isNotEmpty) {
                                return Expanded(
                                    child: ListView.builder(
                                        itemCount: model1.length,
                                        itemBuilder: (context, index) {
                                          final uc = model1[index];
                                          final pf = model2[index];
                                          double hoursDouble = double.parse(uc
                                              .time_reservation
                                              .split(':')[0]);
                                          double minutebegin = double.parse(
                                              uc.time_begin.split(':')[1]);
                                          double minuteend = double.parse(
                                              uc.time_end.split(':')[1]);
                                          if (minutebegin < minuteend) {
                                            hoursDouble++;
                                          }
                                          return Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 6,
                                                      vertical: 8),
                                              child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  child: Container(
                                                      color: Colors.white,
                                                      child: Column(children: [
                                                        SizedBox(
                                                            height: 135,
                                                            child: Row(
                                                                children: [
                                                                  Container(
                                                                      height:
                                                                          150,
                                                                      width:
                                                                          150,
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              15),
                                                                      child: ClipRRect(
                                                                          borderRadius: BorderRadius.circular(
                                                                              20),
                                                                          child: Image.asset(
                                                                              "assets/images/pic.jpg",
                                                                              fit: BoxFit.cover))),
                                                                  Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          top:
                                                                              15,
                                                                          left:
                                                                              6),
                                                                      child: Column(
                                                                          mainAxisAlignment: MainAxisAlignment
                                                                              .spaceBetween,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            Text(
                                                                              pf.parking.floor!.locationModel!.name,
                                                                              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: deepdarkblue),
                                                                            ),
                                                                            const SizedBox(height: 8),
                                                                            Text("${pf.parking.floor!.number} Floor, ${pf.parking.number} parking",
                                                                                style: const TextStyle(fontSize: 20, color: Colors.grey)),
                                                                            Expanded(
                                                                                child: Row(children: [
                                                                              Text(
                                                                                '\$${uc.pay} / ${hoursDouble.toInt()} hour',
                                                                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: darkblue),
                                                                              ),
                                                                              const SizedBox(width: 20),
                                                                              Container(width: 90, height: 30, alignment: Alignment.center, decoration: BoxDecoration(border: Border.all(width: 1.6, color: lightblue), borderRadius: const BorderRadius.all(Radius.circular(8))), child: Text("Finished", style: TextStyle(color: lightblue,fontWeight: FontWeight.bold)))
                                                                            ]))
                                                                          ]))
                                                                ])),
                                                      ]))));
                                        }));
                              } else {
                                return Padding(
                                    padding: const EdgeInsets.only(top: 30),
                                    child: Column(
                                      children: [
                                        Image.asset(
                                            "assets/images/historySessions.png"),
                                        const Text(
                                          "You have no history",
                                          style: TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(height: 15),
                                        const Text(
                                            "There are no historic sessions registered on your account in the last 3 months",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.grey),
                                            textAlign: TextAlign.center)
                                      ],
                                    ));
                              }
                            }
                          }))
            ],
          ),
        ));
  }
}
