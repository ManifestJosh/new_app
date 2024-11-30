import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:new_app/utils/my_colors.dart';
import 'package:new_app/utils/app_spacing.dart';

import 'onboard_controller.dart';
import '../signUp.dart';

class Onboard_page4 extends StatelessWidget {
  const Onboard_page4({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
            top: 0,
            child: SvgPicture.asset(
              'assets/vectors/vector4.svg',
              width: MediaQuery.of(context).size.width,
              // height: MediaQuery.of(context).size.height * 0.518,
            )),
        Positioned(
            top: 0,
            left: 0.10.sw,
            child: Image.asset(
              'assets/images/onboard_images/onboard4.png',
              width: 320.w,
              height: 600.h,
            )),
        Positioned(
            bottom: 0.4.sw,
            left: 30.w,
            right: 30.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Improve Sleep  Quality',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                AppSpacing.height(AppSpacing.md),
                Text(
                  "Improve the quality of your sleep with us, good quality sleep can bring a good mood in the morning",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            )),
        Positioned(
            bottom: 30.h,
            right: 10.w,
            child: InkWell(
              onTap: () {
                Get.to(() => SignUpPage());
              },
              child: Container(
                width: 50.w,
                height: 50.h,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, gradient: MyColors.button_gradient),
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                  size: 18.sp,
                ),
              ),
            ))
      ],
    );
  }
}

class Onboard_page3 extends StatelessWidget {
  const Onboard_page3({
    super.key,
    required this.onboardController,
  });

  final OnboardController onboardController;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 0,
          child: SvgPicture.asset(
            'assets/vectors/vector3.svg',
            width: 1.sw, // Full screen width
          ),
        ),
        Positioned(
          top: 0,
          left: 0.16.sw,
          child: Image.asset(
            'assets/images/onboard_images/onboard3.png',
            width: 320.w,
            height: 570.h,
          ),
        ),
        Positioned(
          top: 0.6.sh, // 60% of screen height
          left: 30.w,
          right: 30.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Eat Well',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              AppSpacing.height(AppSpacing.md), // Responsive spacing
              Text(
                "Let's start a healthy lifestyle with us, we can determine your diet every day. healthy eating is fun",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 30.h,
          right: 10.w,
          child: InkWell(
            onTap: onboardController.nextpage,
            child: Container(
              width: 50.r, // Circular container with proportional size
              height: 50.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: MyColors.button_gradient,
              ),
              child: Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
                size: 18.sp, // Responsive icon size
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class Onboard_page2 extends StatelessWidget {
  const Onboard_page2({
    super.key,
    required this.onboardController,
  });

  final OnboardController onboardController;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 0,
          child: SvgPicture.asset(
            'assets/vectors/vector2.svg',
            width: 1.sw, // Full screen width
          ),
        ),
        Positioned(
          top: 0,
          left: 0.15.sw, // 15% of screen width
          child: Image.asset(
            'assets/images/onboard_images/onboard2.png',
            width: 300.w,
            height: 500.h,
          ),
        ),
        Positioned(
          top: 0.6.sh,
          left: 30.w,
          right: 30.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Get Burn',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              AppSpacing.height(AppSpacing.md),
              Text(
                "Let’s keep burning, to achieve your goals. It hurts only temporarily. If you give up now, you'll be in pain forever.",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 30.h,
          right: 10.w,
          child: InkWell(
            onTap: onboardController.nextpage,
            child: Container(
              width: 50.r,
              height: 50.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: MyColors.button_gradient,
              ),
              child: Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
                size: 18.sp,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class Onboard_page1 extends StatelessWidget {
  const Onboard_page1({
    super.key,
    required this.onboardController,
  });

  final OnboardController onboardController;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 0,
          child: SvgPicture.asset(
            'assets/vectors/vector1.svg',
            width: 1.sw,
            height: 0.518.sh, // 51.8% of screen height
          ),
        ),
        Positioned(
          top: 0,
          left: 0.13.sw,
          child: Image.asset(
            'assets/images/onboard_images/onboard1.png',
            width: 300.w,
            height: 462.h,
          ),
        ),
        Positioned(
          top: 0.6.sh,
          left: 30.w,
          right: 30.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Track your Goal',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              AppSpacing.height(AppSpacing.md),
              Text(
                "Don't worry if you have trouble determining your goals. We can help you determine and track them.",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 30.h,
          right: 10.w,
          child: InkWell(
            onTap: onboardController.nextpage,
            child: Container(
              width: 50.r,
              height: 50.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: MyColors.button_gradient,
              ),
              child: Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
                size: 18.sp,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
