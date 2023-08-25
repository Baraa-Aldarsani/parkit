// ignore_for_file: must_be_immutable, depend_on_referenced_packages

import 'package:flutter/material.dart';

// import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart' as lat;
import 'package:parking/model/location_model.dart';
import 'package:parking/view/data_search_location.dart';
import 'controller/garage/location_controller.dart';
import '../helper/constant.dart';

class Test extends GetView<LocationController> {
  Test({Key? key, this.latitude, this.longitude}) : super(key: key);
  double? latitude;
  double? longitude;

  // Position? cl;
  final mapController = MapController();
  final LocationController myController = Get.put(LocationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Location'),
      ),
      body: Obx(
        () => myController.latitude.value != 0.0 &&
                myController.longitude.value != 0.0
            ? Stack(
                children: [
                  FlutterMap(
                    mapController: myController.mapController,
                    options: MapOptions(
                      center: lat.LatLng(
                        myController.latitude.value,
                        myController.longitude.value,
                      ),
                      zoom: 15.0,
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
                          Marker(
                            width: 80.0,
                            height: 80.0,
                            point: lat.LatLng(
                              myController.latitude.value,
                              myController.longitude.value,
                            ),
                            builder: (ctx) => Icon(
                              Icons.location_on,
                              color: Colors.red,
                              size: 40.0,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              )
            : Center(
                child: myController.latitude.value == 0.0 &&
                        myController.longitude.value == 0.0
                    ? CircularProgressIndicator()
                    : Text('تعذر الوصول إلى الموقع'),
              ),
      ),
      floatingActionButton: IconButton(
          onPressed: () async {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: SpinKitChasingDots(
                    color: Colors.blue, // لون دائرة التحميل
                    size: 50.0, // حجم دائرة التحميل
                  ),
                );
              },
            );
            await myController.getCurrentLocation();
            Navigator.pop(context);
            print(myController.latitude.value);
            print(myController.longitude.value);
          },
          icon: Icon(Icons.my_location)),
    );
  }
}

class Tester extends GetView<LocationController> {
  Tester({Key? key, this.latitude, this.longitude}) : super(key: key);
  double? latitude;
  double? longitude;

  // Position? cl;
  final mapController = MapController();
  final LocationController myController = Get.put(LocationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Location'),
      ),
      body: Obx(() => Stack(
            children: [
              FlutterMap(
                mapController: myController.mapController,
                options: MapOptions(
                  center: lat.LatLng(
                    myController.latitude.value,
                    myController.longitude.value,
                  ),
                  zoom: 15.0,
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
                      Marker(
                        width: 80.0,
                        height: 80.0,
                        point: lat.LatLng(
                          myController.latitude.value,
                          myController.longitude.value,
                        ),
                        builder: (ctx) => Icon(
                          Icons.location_on,
                          color: Colors.red,
                          size: 40.0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              myController.isLoading.value
                  ? AnimatedContainer(
                      duration: Duration(milliseconds: 500),
                      // الوقت الذي يستغرقه التحرك من الأعلى إلى الأسفل
                      height: myController.isLoading.value ? 60 : 48,
                      // ارتفاع الحاوية
                      width: myController.isLoading.value ? 60 : 48,
                      // عرض الحاوية
                      decoration: BoxDecoration(
                        color: myController.isLoading.value
                            ? Colors.blue
                            : Colors.red, // لون الخلفية
                        borderRadius: BorderRadius.circular(
                            myController.isLoading.value
                                ? 30
                                : 24), // شكل الحاوية
                      ),

                      child: Center(
                        child: SpinKitChasingDots(
                          color: Colors.white,
                          size: 30.0,
                        ),
                      ),
                    )
                  : Text("")
            ],
          )),
      floatingActionButton: IconButton(
          onPressed: () async {
            if(myController.serviceEnabled.value) {
              myController.isLoading.value = true;
            }
            await myController.getCurrentLocation();
            myController.isLoading.value = false;
            print(myController.latitude.value);
            print(myController.longitude.value);
          },
          icon: Icon(Icons.my_location)),
    );
  }
}
