import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:new_app/controllers/auth_controller.dart';
import 'package:new_app/utils/bottomNavbar.dart';
import 'package:new_app/widgets/Buttons.dart';

class Welcomepage2 extends StatelessWidget {
  const Welcomepage2({super.key, required this.firstName, required this.uid});
  final String firstName;
  final String uid;

  @override
  Widget build(BuildContext context) {
    // final AuthController authController = Get.put(AuthController());

    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          Positioned(
              top: 0.05.sh,
              left: 0.2.sw,
              child: SvgPicture.asset(
                'assets/vectors/welcomevect1.svg',
                width: 270.w,
                height: 292.h,
              )),
          Positioned(
              top: 0.1.sh,
              right: 50.w,
              child: SvgPicture.asset(
                'assets/vectors/welcomevect2.svg',
                width: 46.w,
                height: 63.h,
              )),
          Positioned(
              top: 0.19.sh,
              left: 75.w,
              child: SvgPicture.asset(
                'assets/vectors/welcomevect3.svg',
                width: 28.w,
                height: 68.h,
              )),
          Positioned(
              top: 0.07.sh,
              left: 0.27.sw,
              child: Image.asset(
                'assets/images/welcome_images/w5.png',
                width: 124.w,
                height: 290.h,
              )),
          Positioned(
              top: 0.075.sh,
              right: 0.27.sw,
              child: Image.asset(
                'assets/images/welcome_images/w5_2.png',
                width: 83.w,
                height: 263.h,
              )),
          Positioned(
              top: 0.5.sh,
              left: 90.w,
              right: 90.w,
              child: Column(
                children: [
                  Text(
                    'Welcome, $firstName',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  10.verticalSpace,
                  Text(
                    'You are all set now, let’s reach your goals together with us',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                ],
              )),
          Positioned(
              left: 50.w,
              right: 50.w,
              bottom: 30.h,
              child: Buttons(
                  width: 315,
                  height: 60,
                  text: 'Go to Home',
                  onTap: () {
                    Get.offAll(BottomNavbar(uid: uid));
                  }))
        ],
      )),
    );
  }
}
