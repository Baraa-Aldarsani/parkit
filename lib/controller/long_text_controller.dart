import 'package:get/get.dart';

class LongTextController extends GetxController {
  var isExpanded = false.obs;

  @override
  void onInit() {
    isExpanded.value = false;
    super.onInit();
  }
  void toggleExpansion() {
    isExpanded.value = !isExpanded.value;
  }
}