import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../../service/Auth.dart';
import '../../Auth_screens/login.dart';

class ProfileController extends GetxController {
  final Auth auth = Auth();
  var icons = <IconData>[].obs;

  var text = <String>[].obs;
  var onTap = <Function()>[].obs;

  @override
  void onInit() {
    icons.value = [
      FontAwesomeIcons.noteSticky,
      LineAwesomeIcons.chart_pie_solid,
      LineAwesomeIcons.sign_out_alt_solid
    ];
    text.value = ['Achievements', 'Activity History', 'Sign Out'];
    onTap.value = [
      () {},
      () {},
      () {
        auth.signOut();
        Get.offAll(() => LoginPage());
      }
    ];
    super.onInit();
  }
}
