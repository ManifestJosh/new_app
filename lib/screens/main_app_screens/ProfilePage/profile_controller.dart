import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:new_app/screens/main_app_screens/ProfilePage/changepassword.dart';

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
      LineAwesomeIcons.key_solid,
      LineAwesomeIcons.sign_out_alt_solid
    ];
    text.value = [
      'Achievements',
      'Activity History',
      'Change Password',
      'Sign Out'
    ];
    onTap.value = [
      () {},
      () {},
      () {
        Get.to(() => ChangePassword());
      },
      () {
        auth.signOut();
        Get.offAll(() => LoginPage());
      }
    ];
    super.onInit();
  }
}
