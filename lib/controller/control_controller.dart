import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parking/view/profile/profile_view.dart';
import 'package:parking/view/session_view.dart';
import 'package:parking/view/services&subscripe_view.dart';
import 'package:parking/view/cars/vehicle_view.dart';
import '../../view/map_view.dart';

class ControlController extends GetxController {
  int _navigationbar = 0;

  Widget _currentScreen = MapView();

  get navigationValue => _navigationbar;

  get currentScreen => _currentScreen;

  void changeSelectedValue(int selected) {
    _navigationbar = selected;
    update();
    switch (selected) {
      case 0:
        {
          _currentScreen = MapView();
          break;
        }
      case 1:
        {
          _currentScreen = SessionsView();
          break;
        }
      case 2:
        {
          _currentScreen = VehicleView();
          break;
        }
      case 3:
        {
          _currentScreen = ServicesAndSubscripeView();
          break;
        }
      case 4:
        {
          _currentScreen = ProfileView();
          break;
        }
    }
  }
}
