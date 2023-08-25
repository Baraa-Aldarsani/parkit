import 'package:flutter/material.dart';
import '../../controller/device_preview/functions/get_device_type.dart';
import '../../model/deviceInfo_model.dart';

class InfoWidget extends StatelessWidget {
  final Widget Function(BuildContext context, DeviceInfo deviceInfo) builder;

  const InfoWidget({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constrains) {
      var mediaQueryData = MediaQuery.of(context);
      var deviceInfo = DeviceInfo(
        orientation: mediaQueryData.orientation,
        deviceType: getDeviceType(mediaQueryData),
        screenWidth: mediaQueryData.size.width,
        screenHeight: mediaQueryData.size.height,
        localWidth: constrains.maxWidth,
        localHeight: constrains.maxHeight,
      );
      return builder(context, deviceInfo);
    });
  }
}
