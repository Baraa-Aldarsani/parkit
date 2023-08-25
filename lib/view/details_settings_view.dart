import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/locale_controller.dart';
import '../controller/settings_controller.dart';
import '../helper/constant.dart';

class DetailsSettingsView extends StatelessWidget {
  DetailsSettingsView({Key? key}) : super(key: key);
  final SettingsController _settingsController = Get.put(SettingsController());
  final LocaleController _localeController = Get.put(LocaleController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 35),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    size: 35,
                  ),
                ),
                Text(
                  "4".tr,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Language:',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Obx(() => Container(
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(
                  border: Border.all(width: 1.5, color: Colors.grey.shade400),
                  borderRadius: const BorderRadius.all(Radius.circular(5))),
              child: DropdownButton<String>(
                padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                value: _settingsController.selectedLanguage.value,
                isExpanded: true,
                iconEnabledColor: deepdarkblue,
                iconDisabledColor: deepdarkblue,
                underline: Container(),
                onChanged: (newValue) {
                  _settingsController.selectedLanguage.value = newValue!;
                  _localeController.changeLanguage(newValue);
                },
                iconSize: 35,
                alignment: Alignment.center,
                style: TextStyle(color: deepdarkblue,fontSize: 25),
                items: <String>['English', 'Arabic']
                    .map<DropdownMenuItem<String>>(
                      (String value) => DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  ),
                )
                    .toList(),
              ),
            )),
            const SizedBox(height: 16),
            const Text(
              'Dark Mode:',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Obx(() => SwitchListTile(
              title: const Text('Enable Dark Mode',style: TextStyle(fontSize: 18),),
              activeColor: deepdarkblue,
              contentPadding: const EdgeInsets.symmetric(horizontal: 0),
              value: _settingsController.isDarkMode.value,
              onChanged: (newValue) {
                _settingsController.isDarkMode.value = newValue;
                if(Get.isDarkMode){
                  Get.changeTheme(ThemeData.light());
                }else{
                  Get.changeTheme(ThemeData.dark());
                }
              },
            )),
          ],
        ),
      ),
    );
  }
}
