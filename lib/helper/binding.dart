import 'package:get/get.dart';
import 'package:parking/controller/control_controller.dart';
class Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ControlController>(() => ControlController());
  }
}
