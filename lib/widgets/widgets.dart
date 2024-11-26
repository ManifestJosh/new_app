import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_app/utils/my_colors.dart';

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
