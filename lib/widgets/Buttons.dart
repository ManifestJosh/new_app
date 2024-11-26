import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_app/utils/my_colors.dart';

class Buttons extends StatelessWidget {
  final double width;
  final double height;
  final String text;
  final Function() onTap;
  final Widget? icon;
  final bool isIconBeforeText;

  Buttons({
    super.key,
    required this.width,
    required this.height,
    required this.text,
    this.icon,
    this.isIconBeforeText = true,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width.w,
        height: height.h,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                blurRadius: 5,
                offset: Offset(0, 10),
                color: Colors.grey.shade400)
          ],

          gradient: MyColors.button_gradient,
          // border: Border.all(
          //   color: MyColors.border_color,
          // ),
          borderRadius: BorderRadius.all(Radius.circular(36.r)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null && isIconBeforeText) ...[
              icon!,
            ],
            5.horizontalSpace,
            Text(
              text,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: MyColors.ScreenBackground_color,
              ),
            ),
            if (icon != null && !isIconBeforeText) ...[
              icon!,
            ],
            if (icon == null && !isIconBeforeText)
              Text(
                text,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: MyColors.ScreenBackground_color,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class Buttons2 extends StatelessWidget {
  final double width;
  final double height;
  final String text;
  final Function() onTap;
  final Widget? icon;
  final bool isIconBeforeText;

  Buttons2({
    super.key,
    required this.width,
    required this.height,
    required this.text,
    this.icon,
    this.isIconBeforeText = true,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width.w,
        height: height.h,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
            colors: [MyColors.secondary_color, MyColors.secondary_colors],
          ),
          // border: Border.all(
          //   color: MyColors.border_color,
          // ),
          borderRadius: BorderRadius.all(Radius.circular(36.r)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null && isIconBeforeText) ...[
              icon!,
            ],
            5.horizontalSpace,
            Text(
              text,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 10.sp,
                fontWeight: FontWeight.w700,
                color: MyColors.ScreenBackground_color,
              ),
            ),
            if (icon != null && !isIconBeforeText) ...[
              icon!,
            ],
            if (icon == null && !isIconBeforeText)
              Text(
                text,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: MyColors.ScreenBackground_color,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class Buttons3 extends StatelessWidget {
  final double width;
  final double height;
  final String text;
  final Function() onTap;
  final Widget? icon;
  final bool isIconBeforeText;

  Buttons3({
    super.key,
    required this.width,
    required this.height,
    required this.text,
    this.icon,
    this.isIconBeforeText = true,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width.w,
        height: height.h,
        decoration: BoxDecoration(
          gradient: MyColors.button_gradient,
          // border: Border.all(
          //   color: MyColors.border_color,
          // ),
          borderRadius: BorderRadius.all(Radius.circular(36.r)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null && isIconBeforeText) ...[
              icon!,
            ],
            5.horizontalSpace,
            Text(
              text,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: MyColors.ScreenBackground_color,
              ),
            ),
            if (icon != null && !isIconBeforeText) ...[
              icon!,
            ],
            if (icon == null && !isIconBeforeText)
              Text(
                text,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: MyColors.ScreenBackground_color,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
