import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:new_app/screens/Auth_screens/auth_page.dart';
import 'package:new_app/utils/my_colors.dart';

import '../../../widgets/widgets.dart';

class WorkOut extends StatefulWidget {
  const WorkOut({super.key});

  @override
  State<WorkOut> createState() => _WorkOutState();
}

class _WorkOutState extends State<WorkOut> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.primary_color,
      body: SafeArea(
          child: Stack(
        children: [
          Positioned(
            top: 15.h,
            left: 20.w,
            child: box2(
              width: 32,
              height: 32,
              widget: Padding(
                padding: const EdgeInsets.only(left: 4.0),
                child: Icon(
                  Icons.arrow_back_ios,
                  size: 12.sp,
                ),
              ),
              color: MyColors.border_color,
              onTap: () {
                Get.back();
              },
            ),
          ),
          Positioned(
              top: 70.h,
              left: 40.w,
              right: 40.w,
              child: Container(
                width: 288.w,
                height: 288.h,
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    shape: BoxShape.circle),
              )),
          Positioned(
              top: 20.h,
              left: 0.1.sw,
              child: Image.asset(
                'assets/images/welcome_images/w3.png',
                width: 316.w,
                height: 415.h,
              )),
          Positioned(
            top: 15.h,
            right: 20.w,
            child: box2(
              width: 32,
              height: 32,
              widget: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.circle,
                    size: 4.sp,
                  ),
                  Icon(
                    Icons.circle,
                    size: 4.sp,
                  ),
                ],
              ),
              color: MyColors.border_color,
              onTap: () {},
            ),
          ),
          Positioned(
            top: 0.4.sh,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 1294.h,
              decoration: BoxDecoration(
                  color: MyColors.ScreenBackground_color,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32.r),
                      topRight: Radius.circular(32.r))),
              child: SingleChildScrollView(
                child: Column(
                  children: [Text('')],
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
