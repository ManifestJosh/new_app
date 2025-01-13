import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_app/utils/my_colors.dart';

class Textbox extends StatelessWidget {
  final Icon? icon;
  final TextEditingController controller;
  final Icon? suffixIcon;
  final Widget? suffix;
  final String? Function(String?)? validator;
  final String hintText;
  final double width;
  final double height;
  final bool obscureText;
  const Textbox(
      {super.key,
      this.icon,
      this.suffixIcon,
      this.suffix,
      required this.hintText,
      required this.width,
      required this.height,
      this.obscureText = false,
      required this.controller,
      this.validator});

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
            validator: validator ?? (value) => null,
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
                errorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        style: BorderStyle.solid, color: Colors.red),
                    borderRadius: BorderRadius.all(Radius.circular(12.r))),
                focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(style: BorderStyle.none),
                    borderRadius: BorderRadius.all(Radius.circular(12.r))),
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(style: BorderStyle.none),
                    borderRadius: BorderRadius.all(Radius.circular(12.r))),
                suffix: suffix,
                suffixIcon: suffixIcon),
          ),
        ),
      ],
    );
  }
}

class Passwordbox extends StatefulWidget {
  final Icon? icon;
  final TextEditingController controller;
  final Icon? suffixIcon;
  final Widget? suffix;
  final String? Function(String?)? validator;
  final String hintText;
  final double width;
  final double height;

  const Passwordbox(
      {super.key,
      this.icon,
      this.suffixIcon,
      this.suffix,
      required this.hintText,
      required this.width,
      required this.height,
      required this.controller,
      this.validator});

  @override
  State<Passwordbox> createState() => _PasswordboxState();
}

class _PasswordboxState extends State<Passwordbox> {
  bool _obscureText = false;
  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: widget.width.w,
          height: widget.height.h,
          decoration: BoxDecoration(
              color: MyColors.border_color,
              borderRadius: BorderRadius.all(Radius.circular(12.r)),
              border: Border.all(style: BorderStyle.none)),
          child: TextFormField(
            validator: widget.validator ?? (value) => null,
            obscureText: _obscureText,
            controller: widget.controller,
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10.0.h, horizontal: 20.w),
              prefixIcon: widget.icon,
              hintText: widget.hintText,
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
              errorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                      style: BorderStyle.solid, color: Colors.red),
                  borderRadius: BorderRadius.all(Radius.circular(12.r))),
              suffix: GestureDetector(
                onTap: _togglePasswordVisibility,
                child: _obscureText
                    ? Icon(
                        Icons.visibility_outlined,
                        color: Colors.grey,
                        size: 18.sp,
                      )
                    : Icon(
                        Icons.visibility_off_outlined,
                        color: Colors.grey,
                        size: 18.sp,
                      ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
