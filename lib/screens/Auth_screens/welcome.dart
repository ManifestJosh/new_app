import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:new_app/utils/my_colors.dart';
import 'package:new_app/widgets/Buttons.dart';

import 'onboard_screens/onboard.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            300.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Fitnest',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                Text(
                  'X',
                  style: TextStyle(
                      fontFamily: 'poppins',
                      fontSize: 40.sp,
                      fontWeight: FontWeight.w800,
                      color: MyColors.secondary_color),
                )
              ],
            ),
            Text(
              'Everybody Can Train',
              style: TextStyle(
                  fontFamily: 'poppins',
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w400,
                  color: MyColors.grey_color),
            ),
            300.verticalSpace,
            Buttons(
              width: 306,
              height: 60,
              text: 'Get Started',
              onTap: () {
                Get.to(() => Onboard_Page());
              },
            )
          ],
        ),
      ),
    );
  }
}
