import 'dart:ui';

import 'package:flutter/material.dart';

class MyColors {
  static const ScreenBackground_color = Color(0xffFFFFFF);
  static const primary_color = Color(0xff92A3FD);
  static const primary_color2 = Color(0xff9DCEFF);
  static const secondary_colors = Color(0xffEEA4CE);
  static const secondary_color = Color(0xffC58BF2);
  static const black = Color(0xff1D1617);
  static const border_color = Color(0xffF7F8F8);
  static const grey_color = Color(0xff7B6F72);
  static const light_grey = Color(0xffDDDADA);
  static const button_gradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primary_color2, primary_color],
  );
}
