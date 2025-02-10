import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_app/utils/my_colors.dart';

import '../utils/app_spacing.dart';

class DropdownList extends StatefulWidget {
  const DropdownList(
      {super.key,
      required this.namecontroller,
      this.onChanged,
      required this.items,
      required this.hinttext,
      this.icon,
      required this.width,
      required this.height});

  final TextEditingController namecontroller;
  final Function(String)? onChanged;
  final List<String> items;
  final String hinttext;
  final Widget? icon;
  final double width;
  final double height;

  @override
  State<DropdownList> createState() => _DropdownListState();
}

class _DropdownListState extends State<DropdownList> {
  @override
  Widget build(BuildContext context) {
    String? dropdownValue;
    return Container(
      width: widget.width.w,
      height: widget.height.h,
      decoration: BoxDecoration(
          color: MyColors.border_color,
          borderRadius: BorderRadius.all(Radius.circular(12.r))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DropdownButtonFormField<String>(
            hint: Text(
              widget.hinttext,
              style: TextStyle(
                  fontFamily: 'poppins',
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400),
            ),
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(style: BorderStyle.none),
                  borderRadius: BorderRadius.all(Radius.circular(12.r))),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(style: BorderStyle.none),
                  borderRadius: BorderRadius.all(Radius.circular(12.r))),
              prefixIcon: widget.icon,
            ),
            value: dropdownValue,
            icon: const Icon(
              Icons.arrow_drop_down_outlined,
              color: Colors.grey,
            ),
            onChanged: (String? newValue) {
              setState(() {
                dropdownValue = newValue;
                widget.namecontroller.text = newValue!;
                widget.onChanged?.call(newValue);
              });
            },
            items: widget.items.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class box1 extends StatelessWidget {
  const box1({
    super.key,
    required this.width,
    required this.height,
    required this.data,
  });
  final double width;
  final double height;
  final String data;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width.w,
      height: height.h,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerRight,
          end: Alignment.centerLeft,
          colors: [MyColors.secondary_colors, MyColors.secondary_color],
        ),
        borderRadius: BorderRadius.all(Radius.circular(16.r)),
      ),
      child: Center(
        child: Text(
          data,
          style: TextStyle(
              fontFamily: 'poppins',
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: MyColors.ScreenBackground_color),
        ),
      ),
    );
  }
}

class box2 extends StatelessWidget {
  const box2({
    super.key,
    required this.width,
    required this.height,
    required this.widget,
    this.color,
    this.gradient,
    required this.onTap,
  });
  final double width;
  final double height;
  final Gradient? gradient;
  final Widget widget;
  final Color? color;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width.w,
        height: height.h,
        decoration: BoxDecoration(
          gradient: gradient,
          color: color,
          borderRadius: BorderRadius.all(Radius.circular(12.r)),
        ),
        child: Center(
          child: widget,
        ),
      ),
    );
  }
}

class box_4 extends StatelessWidget {
  const box_4({
    super.key,
    required this.widget,
  });

  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppSpacing.allSm,
      width: 130.w,
      height: 70.h,
      decoration: BoxDecoration(
          color: MyColors.ScreenBackground_color,
          borderRadius: BorderRadius.all(Radius.circular(16.r))),
      child: widget,
    );
  }
}
