import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../controllers/auth_controller.dart';
import '../screens/auth_page.dart';
import '../utils/app_spacing.dart';
import '../utils/my_colors.dart';
import 'Buttons.dart';

class Bmi_box extends StatelessWidget {
  const Bmi_box({
    super.key,
  });

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
              Text(
                'You have a normal weight',
                style: Theme.of(context).textTheme.displaySmall,
              ),
              20.verticalSpace,
              Buttons2(width: 95, height: 35, text: 'View More', onTap: () {}),
            ],
          ),
          30.horizontalSpace,
          Stack(
            children: [
              SvgPicture.asset('assets/vectors/bmi.svg',
                  width: 116.w, height: 116.h),
              Positioned(
                  top: 22.h,
                  right: 30.w,
                  child: Text(
                    '35.1',
                    style: Theme.of(context).textTheme.displayLarge,
                  )),
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
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            Text(
              'Welcome Back,',
              style: Theme.of(context).textTheme.displayMedium,
            ),
            Text(
              '${authController.name} ${authController.last_name}',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ],
        ),
        180.horizontalSpace,
        box2(
          width: 40,
          height: 40,
          widget: Icon(
            Icons.notifications_outlined,
            size: 15.sp,
          ),
          color: MyColors.border_color,
        )
      ],
    );
  }
}
