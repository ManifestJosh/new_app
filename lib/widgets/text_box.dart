import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_app/utils/my_colors.dart';

class Textbox extends StatelessWidget {
  final Icon? icon;
  final TextEditingController controller;
  final Icon? suffixIcon;
  final String hintText;
  final double width;
  final double height;
  final bool obscureText;
  const Textbox(
      {super.key,
      this.icon,
      this.suffixIcon,
      required this.hintText,
      required this.width,
      required this.height,
      this.obscureText = false,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: width.w,
          height: height.h,
          decoration: BoxDecoration(
              color: MyColors.border_color,
              borderRadius: BorderRadius.all(Radius.circular(12.r)),
              border: Border.all(style: BorderStyle.none)),
          child: TextFormField(
            obscureText: obscureText,
            controller: controller,
            decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10.0.h, horizontal: 20.w),
                prefixIcon: icon,
                hintText: hintText,
                hintStyle: TextStyle(
                    fontFamily: 'poppins',
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey.shade500),
                focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(style: BorderStyle.none),
                    borderRadius: BorderRadius.all(Radius.circular(12.r))),
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(style: BorderStyle.none),
                    borderRadius: BorderRadius.all(Radius.circular(12.r))),
                suffixIcon: suffixIcon),
          ),
        ),
      ],
    );
  }
}
