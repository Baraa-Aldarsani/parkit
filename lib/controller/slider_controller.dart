import 'package:get/get.dart';

class SliderController extends GetxController {
  var value = 2.0.obs;
  var add = 0.0.obs;
  void setValue(double newValue) {
    value.value = newValue;
  }

  void setAdd(double newValue) {
    add.value = newValue;
  }

  double valueSlider() {
    return add.value;
  }

  double totalPrice(double price){
    price = price * add.value;
    return price;
  }
}