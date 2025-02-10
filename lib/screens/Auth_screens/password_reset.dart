import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:new_app/service/Auth.dart';
import 'package:new_app/widgets/Buttons.dart';
import 'package:new_app/widgets/text_box.dart';

import '../../utils/my_colors.dart';
import '../../widgets/widgets.dart';

class PasswordReset extends StatefulWidget {
  const PasswordReset({super.key});

  @override
  State<PasswordReset> createState() => _PasswordResetState();
}

class _PasswordResetState extends State<PasswordReset> {
  final Auth _auth = Auth();
  final emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 8.0.w, top: 10.h),
              child: box2(
                width: 32,
                height: 32,
                widget: Icon(
                  Icons.arrow_back_ios,
                  size: 16.sp,
                ),
                color: MyColors.border_color,
                onTap: () {
                  Get.back();
                },
              ),
            ),
            150.verticalSpace,
            Center(
              child: Text(
                'Reset Password',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            30.verticalSpace,
            Text(
              'To reset your password, kindly provide your email below',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontSize: 15),
              overflow: TextOverflow.visible,
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
            50.verticalSpace,
            Textbox(
                hintText: 'Enter Email',
                width: double.infinity,
                height: 0.06.sh,
                controller: emailController),
            50.verticalSpace,
            Center(
              child: Buttons(
                  width: 0.7.sw,
                  height: 0.06.sh,
                  text: 'Reset Password',
                  onTap: () {
                    _auth.resetPassword(emailController.text.trim());
                  }),
            )
          ],
        ),
      )),
    );
  }
}
