import 'package:get/get.dart';

class SwitchController extends GetxController {
  var isturnedOn = false.obs;

  void turnOn(value) {
    isturnedOn.value = value;
  }
}
