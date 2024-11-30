import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class ProfileController extends GetxController {
  var icons = <IconData>[].obs;

  var text = <String>[].obs;

  @override
  void onInit() {
    icons.value = [
      LineAwesomeIcons.user,
      FontAwesomeIcons.noteSticky,
      LineAwesomeIcons.chart_pie_solid,
      LineAwesomeIcons.chart_bar_solid
    ];
    text.value = [
      'Personal Data',
      'Achievements',
      'Activity History',
      'Workout Progress'
    ];
    super.onInit();
  }
}
