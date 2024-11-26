import 'package:get/get.dart';

class BottomNavcontroller extends GetxController {
  var selectedIndex = 0.obs;

  void changeTabIndex(index) {
    selectedIndex.value = index;
  }
}
