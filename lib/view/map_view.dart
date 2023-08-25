// ignore_for_file: must_be_immutable, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart' as lat;
import 'package:parking/model/location_model.dart';
import 'package:parking/view/data_search_location.dart';
import '../controller/garage/location_controller.dart';
import '../helper/constant.dart';
import 'favorite_garages_view.dart';

class MapView extends GetView<LocationController> {
  MapView({Key? key, this.latitude, this.longitude}) : super(key: key);
  double? latitude;
  double? longitude;
  final MapController mapController = MapController();
  final LocationController myController = Get.put(LocationController());
  @override
  Widget build(BuildContext context) {
    List<LocationModel> location = myController.locations.toList();
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
          IconButton(
            onPressed: () {
              myController.favoriteGarage();
              Get.to(FavoriteGaragesView());
            },
            icon: Icon(
              Icons.favorite_border_outlined,
              color: deepdarkblue,
              size: 45,
            ),
          ),
          const SizedBox(width: 10),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.notifications_active,
              color: deepdarkblue,
              size: 45,
            ),
          ),
          const SizedBox(width: 10)
        ],
      ),
      body: Obx(
        () => Stack(
          children: [
            FutureBuilder(
              future: myController.fetchLocationsAvailible(),
              builder: (context, snapshot) {
                return FlutterMap(
                  mapController: mapController,
                  options: MapOptions(
                    center:
                        lat.LatLng(latitude ?? 33.496142, longitude ?? 36.312207),
                    zoom: 11.0,
                  ),
                  layers: [
                    TileLayerOptions(
                      urlTemplate:
                          'https://api.mapbox.com/styles/v1/baraa-aldarsani/clhmjlvn701nt01pr84vn0bur/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiYmFyYWEtYWxkYXJzYW5pIiwiYSI6ImNsaG1qMDVmbzFjYzIzZnM2aG5yaXBwcmYifQ.9OXu0PP5kUKps_So6nde0w',
                      additionalOptions: const {
                        'accessToken':
                            'pk.eyJ1IjoiYmFyYWEtYWxkYXJzYW5pIiwiYSI6ImNsaG1qMDVmbzFjYzIzZnM2aG5yaXBwcmYifQ.9OXu0PP5kUKps_So6nde0w',
                      },
                    ),
                    MarkerLayerOptions(
                      markers: [
                        for (var location in myController.locations)
                          Marker(
                            width: 80.0,
                            height: 80.0,
                            point: lat.LatLng(
                                location.latitude, location.longitude),
                            builder: (ctx) => IconButton(
                              icon: const Icon(Icons.location_pin),
                              color: deepdarkblue,
                              iconSize: 50,
                              onPressed: () {
                                myController.showParkingDetails(location);
                              },
                            ),
                          ),
                        for (var location in myController.locationNon)
                          Marker(
                              width: 80.0,
                              height: 80.0,
                              point: lat.LatLng(
                                  location.latitude, location.longitude),
                              builder: (ctx) => Icon(
                                    Icons.location_pin,
                                    color: red,
                                    size: 50,
                                  )),
                        if (myController.serviceEnabled.value)
                          Marker(
                            width: 80.0,
                            height: 80.0,
                            point: lat.LatLng(
                              myController.latitude.value,
                              myController.longitude.value,
                            ),
                            builder: (ctx) => const Icon(
                              Icons.my_location,
                              color: Colors.red,
                              size: 40.0,
                            ),
                          ),
                      ],
                    ),
                  ],
                );
              },
            ),
            if (myController.isLoading.value)
              AnimatedContainer(
                margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width / 2.0, top: 20),
                duration: const Duration(milliseconds: 500),
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: lightgreen,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                  child: SpinKitChasingDots(
                    color: deepdarkblue,
                    size: 30.0,
                  ),
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(100)),
              color: deepdarkblue,
            ),
            child: IconButton(
              onPressed: () async {
                showSearch(
                    context: context,
                    delegate: DataSearchLocation(location: location));
              },
              icon: Icon(
                Icons.search,
                color: lightgreen,
                size: 30,
              ),
            ),
          ),
          const SizedBox(height: 15),
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(100)),
              color: deepdarkblue,
            ),
            child: IconButton(
              onPressed: () async {
                if (myController.serviceEnabled.value) {
                  myController.isLoading.value = true;
                }
                await myController.getCurrentLocation();
                myController.isLoading.value = false;
              },
              icon: Icon(
                Icons.my_location,
                color: lightgreen,
                size: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
