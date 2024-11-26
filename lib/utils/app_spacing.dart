// spacing.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppSpacing {
  // Standardized spacing constants
  static double xs = 4.0.w;
  static double sm = 8.0.w;
  static double md = 16.0.w;
  static double lg = 24.0.w;
  static double xl = 32.0;
  static double xlg = 64.0;
  static const double xxl = 100.0;
  static const double xxlg = 150.0;

  // Custom combinations for vertical and horizontal spacing
  static EdgeInsets horizontalSm = EdgeInsets.symmetric(horizontal: sm);
  static EdgeInsets horizontalMd = EdgeInsets.symmetric(horizontal: md);
  static EdgeInsets horizontalLg = EdgeInsets.symmetric(horizontal: lg);

  static EdgeInsets verticalSm = EdgeInsets.symmetric(vertical: sm);
  static EdgeInsets verticalMd = EdgeInsets.symmetric(vertical: md);
  static EdgeInsets verticalLg = EdgeInsets.symmetric(vertical: lg);

  static EdgeInsets allSm = EdgeInsets.all(sm);
  static EdgeInsets allMd = EdgeInsets.all(md);
  static EdgeInsets allLg = EdgeInsets.all(lg);

  // Custom sized box spacers for flexibility
  static Widget height(double value) => SizedBox(height: value);
  static Widget width(double value) => SizedBox(width: value);
}
