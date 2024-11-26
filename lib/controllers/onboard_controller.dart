import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardController extends GetxController {
  var currentPage = 0.obs;
  PageController pageController = PageController();

  void nextpage() {
    currentPage.value++;
    pageController.animateToPage(
      currentPage.value,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }
}
