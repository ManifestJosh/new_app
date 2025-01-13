import 'package:get/get.dart';

class Steppercontroller extends GetxController {
  var currentstep = 0.obs;

  void nextstep(int totalSteps) {
    if (currentstep.value < totalSteps - 1) {
      currentstep.value++;
    }
  }

  void previousstep() {
    if (currentstep.value > 1) {
      currentstep.value--;
    }
  }
}
