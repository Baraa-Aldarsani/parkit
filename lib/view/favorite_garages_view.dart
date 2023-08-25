import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parking/controller/garage/location_controller.dart';

import '../helper/constant.dart';

class FavoriteGaragesView extends StatelessWidget {
  FavoriteGaragesView({Key? key}) : super(key: key);
  final _controller = Get.put(LocationController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My Favorite Garages",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
            color: Colors.black
          ),
        ),
        backgroundColor: Colors.grey.shade50,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(
            Icons.arrow_back,
            size: 35,
              color: Colors.black
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Column(
              children: [
                FutureBuilder(
                    future: _controller.favoriteGarage(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Expanded(
                            child: Center(
                              child: CircularProgressIndicator(),
                            ));
                      } else if (snapshot.hasError) {
                        return const Text("");
                      } else {
                        if (_controller.favorite.isNotEmpty) {
                          return Expanded(
                            child: ListView.separated(
                              physics: const ClampingScrollPhysics(),
                              itemCount: _controller.favorite.length,
                              itemBuilder: (context, index) {
                        final fav = _controller.favorite[index];
                                return Card(
                                  elevation: 4,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 6),
                                  child: SizedBox(
                                      height: 130,
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
                                              BorderRadius
                                                  .circular(20),
                                              child: Image.asset(
                                                "assets/images/parking.jpg",
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                            const EdgeInsets.symmetric(
                                                vertical: 20,horizontal: 15),
                                            child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .start,
                                              children: [
                                                Text(
                                                  fav.garageModel.name,
                                                  style: TextStyle(
                                                      fontSize: 28,
                                                      fontWeight:
                                                      FontWeight
                                                          .bold,
                                                      color:
                                                      deepdarkblue),
                                                ),
                                                Text(
                                                  "Open : ${fav.garageModel.time_open}",
                                                  style:
                                                  const TextStyle(
                                                      fontSize:
                                                      16,
                                                      color: Colors
                                                          .grey),
                                                ),
                                                Text(
                                                  "Close : ${fav.garageModel.time_close}",
                                                  style:
                                                  const TextStyle(
                                                      fontSize:
                                                      16,
                                                      color: Colors
                                                          .grey),
                                                ),
                                                Text(
                                                  '\$${fav.garageModel.price}',
                                                  style: TextStyle(
                                                      fontSize:
                                                      16,
                                                      fontWeight:
                                                      FontWeight
                                                          .bold,
                                                      color:
                                                      darkblue),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      )),
                                );
                              }, separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 10,),
                            ),
                          );
                        } else {
                          return const Text("");
                        }
                      }
                    }),
              ],
            ),
      ),
    );
  }
}
