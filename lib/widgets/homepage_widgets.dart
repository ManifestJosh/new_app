import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:new_app/screens/main_app_screens/HomePage/notification_Page.dart';
import 'package:new_app/widgets/widgets.dart';

import '../controllers/auth_controller.dart';
import '../screens/Auth_screens/auth_page.dart';
import '../utils/app_spacing.dart';
import '../utils/my_colors.dart';
import 'Buttons.dart';

class Bmi_box extends StatelessWidget {
  const Bmi_box({
    super.key,
    required this.authController,
  });
  final AuthController authController;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppSpacing.allMd,
      width: 349.w,
      height: 146.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(18.r)),
        gradient: MyColors.button_gradient,
      ),
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'BMI (Body Mass Index)',
                style: Theme.of(context).textTheme.displayLarge,
              ),
              10.verticalSpace,
              Obx(() {
                double weight = authController.weight.value.toDouble();
                double height = authController.height.value.toDouble();

                double bmi = height != 0 ? weight / (height * height) : 0.0;

                return Text(
                  bmi > 26 ? 'You are OverWeight' : 'You have normal weight',
                  style: Theme.of(context).textTheme.displaySmall,
                );
              }),
              20.verticalSpace,
              Buttons2(width: 95, height: 35, text: 'View More', onTap: () {}),
            ],
          ),
          30.horizontalSpace,
          Stack(
            children: [
              Image.asset(
                'assets/images/bmi2.png',
                width: 120.w,
                height: 120.h,
              ),
              Positioned(
                  top: 0.h,
                  right: 0.w,
                  child: SvgPicture.asset('assets/vectors/bmi.svg')),
              Positioned(
                top: 32.h,
                right: 32.w,
                child: Obx(() {
                  double weight = authController.weight.value.toDouble();
                  double height = authController.height.value.toDouble();

                  double bmi = height != 0 ? weight / (height * height) : 0.0;

                  return Text(
                    bmi.toStringAsFixed(2),
                    style: Theme.of(context).textTheme.displayLarge,
                  );
                }),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class name_n_notification_tab extends StatelessWidget {
  const name_n_notification_tab({
    super.key,
    required this.authController,
  });

  final AuthController authController;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome,',
              style: Theme.of(context).textTheme.displayMedium,
            ),
            Text(
              '${authController.name} ${authController.last_name}',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ],
        ),
        Spacer(),
        box2(
          width: 40,
          height: 40,
          widget: Icon(
            Icons.notifications_outlined,
            size: 15.sp,
          ),
          color: MyColors.border_color,
          onTap: () {
            Get.to(() => NotificationPage());
          },
        )
      ],
    );
  }
}
