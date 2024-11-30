import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:new_app/screens/Auth_screens/onboard_screens/onboard_controller.dart';
import 'package:new_app/screens/Auth_screens/signUp.dart';
import 'package:new_app/utils/app_spacing.dart';
import 'package:new_app/utils/my_colors.dart';

import 'onboard_screens.dart';

class Onboard_Page extends StatefulWidget {
  const Onboard_Page({super.key});

  @override
  State<Onboard_Page> createState() => _Onboard_PageState();
}

class _Onboard_PageState extends State<Onboard_Page> {
  final OnboardController onboardController = Get.put(OnboardController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: PageView(
        physics: AlwaysScrollableScrollPhysics(),
        controller: onboardController.pageController,
        children: [
          Onboard_page1(onboardController: onboardController),
          Onboard_page2(onboardController: onboardController),
          Onboard_page3(onboardController: onboardController),
          Onboard_page4(),
        ],
      )),
    );
  }
}
