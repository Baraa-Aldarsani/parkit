import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parking/controller/services/services_controller.dart';
import 'package:parking/helper/constant.dart';
import 'package:parking/model/services_mode.dart';

class ServiceDetailsScreen extends StatelessWidget {
  ServiceDetailsScreen({super.key, required this.service});
  final ServiceModel service;
  final ServicesController _controller = Get.put(ServicesController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(service.name,style: TextStyle(color: deepdarkblue,fontSize: 25),),
        backgroundColor: lightgreen,
        leading: IconButton(
          onPressed: (){
            Get.back();
          },
         icon: Icon(Icons.arrow_back,
          size: 35,
          color: deepdarkblue,
        ),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: CachedNetworkImage(
                imageUrl: service.image,
                placeholder: (context, url) => const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Services:',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,color: deepdarkblue),
            ),
            Text(
              service.name,
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 16),
            Text(
              'Description:',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,color: deepdarkblue),
            ),
            Text(
              service.serviceInformation,
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            Text(
              'Price:',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,color: deepdarkblue),
            ),
            Text(
              '\$${service.price.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  _controller.orderConfirmation(service.id,service.price);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: deepdarkblue,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text(
                  'Request service',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}