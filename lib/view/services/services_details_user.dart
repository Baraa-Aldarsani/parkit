import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parking/model/services_mode.dart';

import '../../helper/constant.dart';

class ServiceDetailsPage extends StatelessWidget {
  const ServiceDetailsPage({super.key, required this.service});
  final ServiceModel service;
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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                height: 200,
                child: CachedNetworkImage(
                  imageUrl: service.image,
                  placeholder: (context, url) => const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Garage Name :',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 3),
            Text(
              service.garageModel!.name,
              style:  const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 16),
            const Text(
              'Service Information:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 3),
            Text(
              service.serviceInformation,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Text(
              'Price :  \$${service.price.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 18),

          ],
        ),
      ),
    );
  }
}
