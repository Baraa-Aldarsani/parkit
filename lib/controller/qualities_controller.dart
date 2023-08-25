import 'package:get/get.dart';
import 'package:parking/model/qualities_model.dart';

class QualitiesController extends GetxController {
  RxMap<String, Map<String,String>>? flrAquai;
  String isBusy = 'Available';

  void updateFlrAquai(RxMap<String, List> flrAquai) {
    this.flrAquai = flrAquai as RxMap<String, Map<String, String>>?;
    update();
  }

  void setIsBusy(String isBusy) {
    this.isBusy = isBusy;
    update();
  }
}