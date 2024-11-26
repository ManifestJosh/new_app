import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_app/utils/my_colors.dart';

final ThemeData appTheme = ThemeData(
  primaryColor: MyColors.primary_color,
  scaffoldBackgroundColor: MyColors.ScreenBackground_color,
  textTheme: TextTheme(
    headlineLarge: TextStyle(
        fontFamily: 'poppins', fontSize: 36.sp, fontWeight: FontWeight.w700),
    headlineMedium: TextStyle(
        fontFamily: 'poppins', fontSize: 24.sp, fontWeight: FontWeight.w700),
    headlineSmall: TextStyle(
        fontFamily: 'poppins', fontSize: 20.sp, fontWeight: FontWeight.w700),
    titleLarge: TextStyle(
        fontFamily: 'poppins', fontSize: 16.sp, fontWeight: FontWeight.w700),
    titleMedium: TextStyle(
        fontFamily: 'poppins', fontSize: 16.sp, fontWeight: FontWeight.w600),
    titleSmall: TextStyle(
        fontFamily: 'poppins', fontSize: 14.sp, fontWeight: FontWeight.w600),
    bodyLarge: TextStyle(
        fontFamily: 'poppins', fontSize: 14.sp, fontWeight: FontWeight.w500),
    bodyMedium: TextStyle(
        fontFamily: 'poppins', fontSize: 12.sp, fontWeight: FontWeight.w500),
    displayLarge: TextStyle(
        fontFamily: 'poppins',
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
        color: MyColors.ScreenBackground_color),
    displayMedium: TextStyle(
        fontFamily: 'poppins',
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
        color: MyColors.grey_color),
    displaySmall: TextStyle(
        fontFamily: 'poppins',
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
        color: MyColors.ScreenBackground_color),
    bodySmall: TextStyle(
        fontFamily: 'poppins',
        fontSize: 10.sp,
        fontWeight: FontWeight.w400,
        color: MyColors.grey_color),
  ),
);
