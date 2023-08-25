import 'package:flutter/material.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';

class MyHomePage extends StatefulWidget {
   MyHomePage({Key? key}) : super(key: key);


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final int _duration = 150;
  final CountDownController _controller = CountDownController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Timer"),
      ),
      body: Center(
        child: CircularCountDownTimer(
          // Countdown duration in Seconds.
          duration: _duration,

          // Countdown initial elapsed Duration in Seconds.
          initialDuration: 0,

          // Controls (i.e Start, Pause, Resume, Restart) the Countdown Timer.
          controller: _controller,

          // Width of the Countdown Widget.
          width: MediaQuery.of(context).size.width / 2,

          // Height of the Countdown Widget.
          height: MediaQuery.of(context).size.height / 2,

          // Ring Color for Countdown Widget.
          ringColor: Colors.grey[300]!,

          // Ring Gradient for Countdown Widget.
          ringGradient: null,

          // Filling Color for Countdown Widget.
          fillColor: Colors.purpleAccent[100]!,

          // Filling Gradient for Countdown Widget.
          fillGradient: null,

          // Background Color for Countdown Widget.
          backgroundColor: Colors.purple[500],

          // Background Gradient for Countdown Widget.
          backgroundGradient: null,

          // Border Thickness of the Countdown Ring.
          strokeWidth: 20.0,

          // Begin and end contours with a flat edge and no extension.
          strokeCap: StrokeCap.round,

          // Text Style for Countdown Text.
          textStyle: const TextStyle(
            fontSize: 33.0,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),

          // Format for the Countdown Text.
          textFormat: CountdownTextFormat.HH_MM_SS,

          // Handles Countdown Timer (true for Reverse Countdown (max to 0), false for Forward Countdown (0 to max)).
          isReverse: true,

          // Handles Animation Direction (true for Reverse Animation, false for Forward Animation).
          isReverseAnimation: true,

          // Handles visibility of the Countdown Text.
          isTimerTextShown: true,

          // Handles the timer start.
          autoStart: true,

          // This Callback will execute when the Countdown Starts.
          onStart: () {
            // Here, do whatever you want
            debugPrint('Countdown Started');
          },

          // This Callback will execute when the Countdown Ends.
          onComplete: () {
            // Here, do whatever you want
            debugPrint('Countdown Ended');
          },

          // This Callback will execute when the Countdown Changes.
          onChange: (String timeStamp) {
            // Here, do whatever you want
            debugPrint('Countdown Changed $timeStamp');
          },

          /*
            * Function to format the text.
            * Allows you to format the current duration to any String.
            * It also provides the default function in case you want to format specific moments
              as in reverse when reaching '0' show 'GO', and for the rest of the instances follow
              the default behavior.
          */
          timeFormatterFunction: (defaultFormatterFunction,duration) {
            if (duration.inSeconds == 0) {
              // only format for '0'
              return "Start";
            } else {
              // other durations by it's default format
              return Function.apply(defaultFormatterFunction, [duration],);
            }
          },
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            width: 30,
          ),
          _button(
            title: "Start",
            onPressed: () => _controller.start(),
          ),
          const SizedBox(
            width: 10,
          ),
          _button(
            title: "Pause",
            onPressed: () => _controller.pause(),
          ),
          const SizedBox(
            width: 10,
          ),
          _button(
            title: "Resume",
            onPressed: () => _controller.resume(),
          ),
          const SizedBox(
            width: 10,
          ),
          _button(
            title: "Restart",
            onPressed: () => _controller.restart(duration: _duration),
          ),
        ],
      ),
    );
  }

  Widget _button({required String title, VoidCallback? onPressed}) {
    return Expanded(
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.purple),
        ),
        onPressed: onPressed,
        child: Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}



// ignore_for_file: must_be_immutable, depend_on_referenced_packages

// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:flutter_map/plugin_api.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:get/get.dart';
// import 'package:latlong2/latlong.dart' as lat;
// import 'package:parking/model/location_model.dart';
// import 'package:parking/view/data_search_location.dart';
// import '../controller/location_controller.dart';
// import '../helper/constant.dart';
//
// class MapView extends GetView<LocationController> {
//   MapView({Key? key, this.latitude, this.longitude}) : super(key: key);
//   double? latitude;
//   double? longitude;
//   Position? cl;
//   final mapController = MapController();
//
//   @override
//   Widget build(BuildContext context) {
//     final myController = Get.put(LocationController());
//     List<LocationModel> location = myController.locations.toList();
//     return Scaffold(
//       body: Stack(
//         children: [
//           FlutterMap(
//             options: MapOptions(
//               center: lat.LatLng(latitude ?? 33.5138, longitude ?? 36.2765),
//               zoom: 9.2,
//             ),
//             layers: [
//               TileLayerOptions(
//                 urlTemplate:
//                 'https://api.mapbox.com/styles/v1/baraa-aldarsani/clhmjlvn701nt01pr84vn0bur/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiYmFyYWEtYWxkYXJzYW5pIiwiYSI6ImNsaG1qMDVmbzFjYzIzZnM2aG5yaXBwcmYifQ.9OXu0PP5kUKps_So6nde0w',
//                 additionalOptions: const {
//                   'accessToken':
//                   'pk.eyJ1IjoiYmFyYWEtYWxkYXJzYW5pIiwiYSI6ImNsaG1qMDVmbzFjYzIzZnM2aG5yaXBwcmYifQ.9OXu0PP5kUKps_So6nde0w',
//                 },
//               ),
//               MarkerLayerOptions(
//                 markers: [
//                   for (var location in myController.locations)
//                     Marker(
//                       width: 80.0,
//                       height: 80.0,
//                       point: lat.LatLng(location.latitude, location.longitude),
//                       builder: (ctx) => IconButton(
//                         icon: const Icon(Icons.location_on),
//                         color: red,
//                         iconSize: 45.0,
//                         onPressed: () {
//                           controller.showParkingDetails(location);
//                         },
//                       ),
//                     ),
//                 ],
//               ),
//             ],
//           ),
//         ],
//       ),
//       floatingActionButton: Column(
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: [
//           Container(
//             decoration: BoxDecoration(
//               borderRadius: const BorderRadius.all(Radius.circular(100)),
//               color: deepdarkblue,
//             ),
//             child: IconButton(
//               onPressed: () {
//                 showSearch(
//                     context: context,
//                     delegate: DataSearchLocation(location: location));
//               },
//               icon: Icon(
//                 Icons.search,
//                 color: lightgreen,
//               ),
//             ),
//           ),
//           const SizedBox(
//             height: 15,
//           ),
//           Container(
//             decoration: BoxDecoration(
//               borderRadius: const BorderRadius.all(Radius.circular(100)),
//               color: deepdarkblue,
//             ),
//             child: IconButton(
//               onPressed: () async {
//               },
//               icon: Icon(
//                 Icons.my_location,
//                 color: lightgreen,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
